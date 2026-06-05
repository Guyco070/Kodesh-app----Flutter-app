// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: deprecated_member_use
import 'dart:js' as js;

Future<({double lat, double lng, String tzid})?> requestGeolocation() async {
  try {
    final pos = await html.window.navigator.geolocation.getCurrentPosition();
    final lat = (pos.coords!.latitude as num).toDouble();
    final lng = (pos.coords!.longitude as num).toDouble();
    final tzid = js.context.callMethod(
            'eval', ['Intl.DateTimeFormat().resolvedOptions().timeZone'])
        as String? ??
        'UTC';
    return (lat: lat, lng: lng, tzid: tzid);
  } catch (_) {
    return null;
  }
}
