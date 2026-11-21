import 'dart:ui';

Locale currentLocal = const Locale('en');

class L10n {
  /// Supported UI locales. Language-only on purpose: these locales end up in
  /// the page's `<html lang>` attribute on web, which screen readers use to
  /// pick a voice, so they must be valid BCP-47 tags ("he", not "he-עברית").
  static const all = [Locale('en'), Locale('he'), Locale('es'), Locale('ru')];

  static final supportedLanguageCodes = all.map((l) => l.languageCode).toSet();

  /// Language for a first-time visitor: the device/browser language when it
  /// is supported, otherwise English.
  static String initialLanguageCode() {
    final deviceLanguage = PlatformDispatcher.instance.locale.languageCode;
    // Older Android devices report Hebrew as "iw".
    final normalized = deviceLanguage == 'iw' ? 'he' : deviceLanguage;
    return supportedLanguageCodes.contains(normalized) ? normalized : 'en';
  }

  static final names = {
    'en': {'locale': 'English', 'english': 'English'},
    'he': {'locale': 'עברית', 'english': 'Hebrew'},
    'es': {'locale': 'Español', 'english': 'Spanish'},
    'ru': {'locale': 'Русский', 'english': 'Russian'},
  };
}
