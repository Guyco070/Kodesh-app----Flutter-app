import 'dart:ui';

Locale currentLocal = const Locale('en');

class L10n {
  // Language-only locales: a country part would end up in <html lang> on
  // the web and confuse screen readers. Display names are in [names].
  static final all = [
    const Locale('en'),
    const Locale('he'),
    const Locale('es'),
    const Locale('ru'),
  ];

  static final names = {
    'en': {'locale': 'English', 'english': 'English'},
    'he': {'locale': 'עברית', 'english': 'Hebrew'},
    'es': {'locale': 'Español', 'english': 'Spanish'},
    'ru': {'locale': 'Русский', 'english': 'Russian'},
  };
}
