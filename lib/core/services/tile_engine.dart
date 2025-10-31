import 'dart:math' as math;

import '../models/tile.dart';

class TileEngine {
  static const double tileSizeMeters = 100.0;
  static const double metersPerDegreeLat = 111320.0; // approx

  static double metersPerDegreeLon(double latDeg) {
    return 111320.0 * math.cos(latDeg * math.pi / 180.0);
  }

  static TileIndex latLngToTile(double lat, double lon) {
    final mPerLon = metersPerDegreeLon(lat).clamp(1.0, double.maxFinite);
    final xMeters = lon * mPerLon;
    final yMeters = lat * metersPerDegreeLat;
    final x = (xMeters / tileSizeMeters).floor();
    final y = (yMeters / tileSizeMeters).floor();
    return TileIndex(x, y);
  }

  static List<List<double>> tilePolygonLatLng(TileIndex t, {double? atLatForLonScale}) {
    // Convert tile corners back to lat/lon
    final latRef = atLatForLonScale ?? tileCenterLat(t);
    final mPerLon = metersPerDegreeLon(latRef).clamp(1.0, double.maxFinite);

    final xMinM = t.x * tileSizeMeters;
    final xMaxM = (t.x + 1) * tileSizeMeters;
    final yMinM = t.y * tileSizeMeters;
    final yMaxM = (t.y + 1) * tileSizeMeters;

    final lonMin = xMinM / mPerLon;
    final lonMax = xMaxM / mPerLon;
    final latMin = yMinM / metersPerDegreeLat;
    final latMax = yMaxM / metersPerDegreeLat;

    return [
      [latMin, lonMin],
      [latMin, lonMax],
      [latMax, lonMax],
      [latMax, lonMin],
    ];
  }

  static double tileCenterLat(TileIndex t) {
    final yCenterM = (t.y + 0.5) * tileSizeMeters;
    return yCenterM / metersPerDegreeLat;
  }
}
