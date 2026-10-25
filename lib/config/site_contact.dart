/// Public contact details shown on the accessibility statement and privacy
/// policy. Israeli accessibility regulations require the statement to name a
/// contact for accessibility requests.
class SiteContact {
  SiteContact._();

  /// Name of the person handling accessibility requests.
  static const String accessibilityCoordinatorName = '';

  /// Email for accessibility and privacy requests.
  static const String email = '';

  /// Optional phone number. Leave empty to omit.
  static const String phone = '';

  static bool get isConfigured =>
      accessibilityCoordinatorName.isNotEmpty && email.isNotEmpty;
}
