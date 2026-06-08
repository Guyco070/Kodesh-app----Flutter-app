import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kodesh_app/data/cities.dart';
import 'package:kodesh_app/data/city_coordinates.dart';
import 'package:kodesh_app/helpers/app_logger.dart';

class LocationService {
  /// Returns the [eNameAndCode] of the nearest city to the user's current
  /// position, or null if location is unavailable or permission is denied.
  static Future<String?> detectNearestCity() async {
    if (kIsWeb) {
      logger.i('Location detection skipped on web');
      return null;
    }

    final position = await _getPosition();
    if (position == null) return null;

    return _findNearestCity(position.latitude, position.longitude);
  }

  static Future<Position?> _getPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        logger.w('Location services are disabled');
        return null;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          logger.w('Location permission denied by user');
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        logger.w('Location permission permanently denied');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
    } catch (e, st) {
      logger.e('Failed to get position', error: e, stackTrace: st);
      return null;
    }
  }

  static String? _findNearestCity(double lat, double lon) {
    String? nearest;
    double minDist = double.infinity;

    for (final city in cities) {
      final eCode = city['eNameAndCode'] as String?;
      if (eCode == null) continue;

      final parts = eCode.split('|');
      if (parts.length < 2) continue;

      final geoId = parts[1];
      final coords = cityCoordinates[geoId];
      if (coords == null) continue;

      final d = _haversineKm(lat, lon, coords[0], coords[1]);
      if (d < minDist) {
        minDist = d;
        nearest = eCode;
      }
    }

    if (nearest != null) {
      logger.i('Nearest city: $nearest (${minDist.toStringAsFixed(1)} km)');
    }
    return nearest;
  }

  static double _haversineKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371.0;
    final dLat = _rad(lat2 - lat1);
    final dLon = _rad(lon2 - lon1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_rad(lat1)) * cos(_rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    return r * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  static double _rad(double deg) => deg * pi / 180;
}
