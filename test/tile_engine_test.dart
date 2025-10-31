import 'package:flutter_test/flutter_test.dart';

import 'package:runnerprime_flutter/core/services/tile_engine.dart';
import 'package:runnerprime_flutter/core/models/tile.dart';
import 'package:runnerprime_flutter/core/services/run_validator.dart';

void main() {
  test('TileEngine maps nearby coords to same tile', () {
    final t1 = TileEngine.latLngToTile(12.9716, 77.5946);
    final t2 = TileEngine.latLngToTile(12.971601, 77.594601);
    expect(t1, t2);
  });

  test('TileEngine different coords far apart map to different tiles', () {
    final t1 = TileEngine.latLngToTile(12.9716, 77.5946);
    final t2 = TileEngine.latLngToTile(12.9726, 77.5946);
    expect(t1 == t2, isFalse);
  });

  test('RunValidator speed plausibility', () {
    expect(RunValidator.isPlausibleSpeed(0), isTrue);
    expect(RunValidator.isPlausibleSpeed(5), isTrue);
    expect(RunValidator.isPlausibleSpeed(12), isFalse);
  });
}
