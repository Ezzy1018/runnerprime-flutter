import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/models/tile.dart';
import '../../core/services/tile_engine.dart';

class RunState {
  final List<LatLng> path;
  final Set<TileIndex> visitedTiles;
  final Position? lastPosition;
  const RunState({
    this.path = const [],
    this.visitedTiles = const {},
    this.lastPosition,
  });

  RunState copyWith({
    List<LatLng>? path,
    Set<TileIndex>? visitedTiles,
    Position? lastPosition,
  }) => RunState(
        path: path ?? this.path,
        visitedTiles: visitedTiles ?? this.visitedTiles,
        lastPosition: lastPosition ?? this.lastPosition,
      );
}

final runControllerProvider =
    StateNotifierProvider<RunController, RunState>((ref) => RunController());

class RunController extends StateNotifier<RunState> {
  RunController() : super(const RunState());

  StreamSubscription<Position>? _sub;

  Future<void> start() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return;

    _sub?.cancel();
    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((pos) {
      final latLng = LatLng(pos.latitude, pos.longitude);
      final nextPath = [...state.path, latLng];
      final tile = TileEngine.latLngToTile(pos.latitude, pos.longitude);
      final nextTiles = {...state.visitedTiles, tile};
      state = state.copyWith(path: nextPath, visitedTiles: nextTiles, lastPosition: pos);
    });
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
