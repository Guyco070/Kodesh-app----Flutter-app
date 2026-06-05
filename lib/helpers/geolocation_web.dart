// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<({double lat, double lng})?> requestGeolocation() async {
  try {
    final pos = await html.window.navigator.geolocation.getCurrentPosition();
    final lat = (pos.coords!.latitude as num).toDouble();
    final lng = (pos.coords!.longitude as num).toDouble();
    return (lat: lat, lng: lng);
  } catch (_) {
    return null;
  }
}
