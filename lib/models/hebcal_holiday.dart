class HebcalHoliday {
  final String title;
  final String hebrew;
  final DateTime date;
  final bool isMajor;

  const HebcalHoliday({
    required this.title,
    required this.hebrew,
    required this.date,
    required this.isMajor,
  });

  /// Name to show for the given UI language. [title] is already localized by
  /// Hebcal for non-Hebrew languages; for Hebrew the dedicated [hebrew] field
  /// is cleaner (no nikud).
  String displayName(String languageCode) {
    if (languageCode == 'he' && hebrew.isNotEmpty) return hebrew;
    return title;
  }
}
