import 'dart:math' as math;

import 'package:kodesh_app/data/city_coordinates.dart';

/// Latitude and longitude of the Western Wall in Jerusalem.
const double westernWallLat = 31.7767;
const double westernWallLon = 35.2345;

/// Initial great-circle bearing, in degrees clockwise from true north
/// (0–360), from [lat],[lon] towards the Western Wall.
double bearingToWesternWall(double lat, double lon) {
  double rad(double d) => d * math.pi / 180;
  final phi1 = rad(lat);
  final phi2 = rad(westernWallLat);
  final dLambda = rad(westernWallLon - lon);
  final y = math.sin(dLambda) * math.cos(phi2);
  final x =
      math.cos(phi1) * math.sin(phi2) -
      math.sin(phi1) * math.cos(phi2) * math.cos(dLambda);
  final deg = math.atan2(y, x) * 180 / math.pi;
  return (deg + 360) % 360;
}

/// The bearing to the Western Wall from the city stored as
/// "CC-Name|geonamesId", or null when the city's coordinates are unknown.
double? bearingFromCity(String cityCode) {
  final parts = cityCode.split('|');
  if (parts.length < 2) return null;
  final coords = cityCoordinates[parts[1]];
  if (coords == null) return null;
  return bearingToWesternWall(coords[0], coords[1]);
}
