import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/tile_engine.dart';
import '../../core/models/tile.dart';
import 'run_controller.dart';

class RunScreen extends ConsumerStatefulWidget {
  const RunScreen({super.key});

  @override
  ConsumerState<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends ConsumerState<RunScreen> {
  GoogleMapController? _map;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(runControllerProvider.notifier).start());
  }

  @override
  void dispose() {
    ref.read(runControllerProvider.notifier).stop();
    _map?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final run = ref.watch(runControllerProvider);

    final polylines = <Polyline>{};
    if (run.path.length > 1) {
      polylines.add(Polyline(
        polylineId: const PolylineId('path'),
        points: run.path,
        color: Colors.greenAccent,
        width: 4,
      ));
    }

    final polygons = <Polygon>{};
    for (final t in run.visitedTiles) {
      final pts = _tilePolygonToLatLngs(t);
      polygons.add(Polygon(
        polygonId: PolygonId('t_${t.x}_${t.y}'),
        points: pts,
        strokeWidth: 1,
        strokeColor: Colors.greenAccent.withOpacity(0.6),
        fillColor: Colors.greenAccent.withOpacity(0.2),
      ));
    }

    final camera = run.lastPosition != null
        ? CameraPosition(
            target: LatLng(run.lastPosition!.latitude, run.lastPosition!.longitude),
            zoom: 17,
          )
        : const CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 12); // Bengaluru default

    return Scaffold(
      appBar: AppBar(title: const Text('Run')),
      body: GoogleMap(
        initialCameraPosition: camera,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polylines: polylines,
        polygons: polygons,
        onMapCreated: (c) => _map = c,
      ),
    );
  }

  List<LatLng> _tilePolygonToLatLngs(TileIndex t) {
    final corners = TileEngine.tilePolygonLatLng(t);
    return corners.map((e) => LatLng(e[0], e[1])).toList(growable: false);
  }
}
