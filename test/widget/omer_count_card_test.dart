import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/models/sfirat_omer.dart';
import 'package:kodesh_app/widgets/sfirat_omer_screen/omer_count_card.dart';

Widget _app(Locale locale, Widget child) => MaterialApp(
  locale: locale,
  supportedLocales: const [Locale('en'), Locale('he')],
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  final omer = SfiratOmer(
    title: 'י״ב בעומר',
    entryDate: DateTime(2026, 4, 14),
    titleOrig: 'Omer 12',
    sefira: const {
      'count': {
        'he':
            'הַיּוֹם שְׁנֵים עָשָׂר יוֹם, שֶׁהֵם שָׁבֽוּעַ אֶחָד וַחֲמִשָּׁה יָמִים לָעֽוֹמֶר',
        'en': 'Today is 12 days, which are 1 week and 5 days of the Omer',
      },
    },
  );

  for (final locale in const [Locale('he'), Locale('en')]) {
    testWidgets('fits a 320 px phone in ${locale.languageCode}', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        _app(locale, OmerCountCard(omer: omer, isTonight: true)),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(tester.takeException(), isNull);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('12 / 49'), findsOneWidget);
    });
  }
}
