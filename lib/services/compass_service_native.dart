import 'package:flutter_compass/flutter_compass.dart';

Stream<double?> getCompassStream() =>
    FlutterCompass.events?.map((e) => e.heading) ?? const Stream.empty();

bool get isCompassAvailable => FlutterCompass.events != null;

bool get needsPermissionRequest => false;

Future<bool> requestPermission() async => true;
