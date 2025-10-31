class RunValidator {
  // Placeholder: can implement speed spikes, GPS jumps, and stationary filtering.
  static bool isPlausibleSpeed(double metersPerSecond) {
    // 10 m/s ~ 36 km/h — sprint ceiling; anything higher is suspicious.
    return metersPerSecond >= 0 && metersPerSecond <= 10.0;
  }
}
