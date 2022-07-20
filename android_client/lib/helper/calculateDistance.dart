import 'dart:math';

double calculationByDistance(
    double initialLat, double initialLong, double finalLat, double finalLong) {
  int r = 637100; // m
  double dLat = toRadians(finalLat - initialLat);
  double dLon = toRadians(finalLong - initialLong);
  initialLat = toRadians(initialLat);
  finalLat = toRadians(finalLat);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(initialLat) * cos(finalLat);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return r * c;
}

double toRadians(deg) {
  return deg * (pi / 180);
}
