import 'dart:ui';

Locale currentLocal = const Locale('en');

class L10n {
  static final all = [
    const Locale('en', 'English'),
    const Locale('he', 'עברית'),
    // const Locale('es'),
    // const Locale('fr'),
    // const Locale('ru', 'Rusion'),
    // const Locale('pl'),
    // const Locale('fi'),
    // const Locale('hu'),
    // const Locale('ro'),
    // const Locale('uk'),
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
    // 'es': {
    //   'locale': 'español',
    //   'english': 'Spanish',
    // },
    // 'ru': {
    //   'locale': 'ру́сский язы́к',
    //   'english': 'Russian',
    // },
  };
}
