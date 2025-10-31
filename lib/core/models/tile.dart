class TileIndex {
  final int x;
  final int y;
  const TileIndex(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TileIndex && x == other.x && y == other.y;
  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'TileIndex($x,$y)';
}
