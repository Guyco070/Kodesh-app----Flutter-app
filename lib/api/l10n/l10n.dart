import 'dart:ui';

Locale currentLocal = const Locale('en');

class L10n {
  static final all = [
    const Locale('en', 'English'),
    const Locale('he', 'עברית'),
    const Locale('es', 'Español'),
    const Locale('ru', 'Русский'),
  ];

  static final names = {
    'en': {
      'locale': 'English',
      'english': 'English',
    },
    'he': {
      'locale': 'עברית',
      'english': 'Hebrew',
    },
    'es': {
      'locale': 'Español',
      'english': 'Spanish',
    },
    'ru': {
      'locale': 'Русский',
      'english': 'Russian',
    },
  };
}
