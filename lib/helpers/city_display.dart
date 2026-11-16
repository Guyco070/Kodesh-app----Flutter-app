/// The city name to show to users: the stored name without its leading
/// two-letter country code ("IL-ירושלים" → "ירושלים").
///
/// City names are stored as "CC-Name". In Hebrew, the Latin code glued to
/// the name is reordered by the bidi algorithm and reads as garbage.
String cityDisplayName(String stored) =>
    stored.replaceFirst(RegExp(r'^[A-Z]{2}-'), '').trim();

/// The display name of the city stored as [cityCode] ("CC-Name|geonamesId")
/// in [langCode], looked up in [cityList]; falls back to the stored name.
String cityLabel(
  String cityCode,
  String langCode,
  List<Map<String, dynamic>> cityList,
) {
  for (final c in cityList) {
    if (c['eNameAndCode'] == cityCode) {
      final name = c[langCode] ?? c['en'];
      if (name is String) return cityDisplayName(name);
    }
  }
  return cityDisplayName(cityCode.split('|').first);
}
