import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

final _controller = StreamController<double?>.broadcast();
bool _listening = false;

Stream<double?> getCompassStream() {
  if (!_listening) {
    _listening = true;
    web.window.addEventListener(
      'deviceorientationabsolute',
      ((web.DeviceOrientationEvent e) {
        final alpha = e.alpha;
        if (alpha != null) _controller.add(alpha);
      }).toJS,
    );
    // Fallback for relative orientation (some browsers)
    web.window.addEventListener(
      'deviceorientation',
      ((web.DeviceOrientationEvent e) {
        if (!_controller.hasListener) return;
        final alpha = e.alpha;
        if (alpha != null) _controller.add(alpha);
      }).toJS,
    );
  }
  return _controller.stream;
}

bool get isCompassAvailable => true;

bool get needsPermissionRequest => _needsPermission().toDart;

@JS('window.needsCompassPermission')
external JSBoolean _needsPermission();

@JS('window.requestCompassPermission')
external JSPromise<JSBoolean> _requestPermissionJs();

Future<bool> requestPermission() async {
  try {
    final result = await _requestPermissionJs().toDart;
    return result.toDart;
  } catch (_) {
    return true;
  }
}
