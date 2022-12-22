import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SfiratOmerScreen extends StatelessWidget {
  const SfiratOmerScreen({super.key});
static String routeName = '/sfirat_omer_screen';

  List<Widget> getSederWidgets() {
    const TextStyle boldFont =
        TextStyle(fontWeight: FontWeight.w600, fontSize: 12);
    List<Widget> widgets = [];
    for (int i = 0; i < seder.length; i++) {
      String? text;
      if (seder[i].contains('T')) { // T = title
        text = seder[i].substring(0, seder[i].length - 2);
      }

      widgets.add(text == null
          ? Text(
              seder[i],
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            )
          : Text(
              text,
              textDirection: TextDirection.rtl,
              style: boldFont,
              textAlign: TextAlign.center,
            ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.sederSfiratOmer),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [Center(child: Text(AppLocalizations.of(context)!.sederSfiratOmer)),]//getSederWidgets(),
            ),
          ),
        ));
  }

  // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
  final List<String> seder = const [
    '\n',
    'ברכת ספירת העומר:T'
    '\n',
  ];
}