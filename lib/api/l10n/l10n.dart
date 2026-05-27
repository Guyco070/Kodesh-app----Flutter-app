import 'dart:ui';

Locale currentLocal = const Locale('en');

class L10n {
  static final all = [
    const Locale('en', 'English'),
    const Locale('he', 'עברית'),
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
  };
}
