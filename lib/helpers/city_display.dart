/// City labels in the data are stored as "CC-Name" (e.g. "IL-ירושלים").
/// The country prefix is useful in the search list but reads badly as a
/// label, and mixing a Latin prefix with Hebrew text breaks bidi ordering
/// ("ירושלים-IL"). This returns just the city name.
String cityDisplayName(String label) {
  final match = RegExp(r'^[A-Z]{2}-(.+)$').firstMatch(label);
  return match?.group(1)?.trim() ?? label;
}
