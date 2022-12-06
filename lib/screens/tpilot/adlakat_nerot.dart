import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/appBar.dart';

class AdlakatNerot extends StatelessWidget {
  const AdlakatNerot({super.key});
static String routeName = '/adlakat_nerot';

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
      appBar: getRightBackAppBar(context, 'סדר הדלקת נרות'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: getSederWidgets(),
            ),
          ),
        ));
  }

  // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
  final List<String> seder = const [
    '\n',
    'סדר הדלקת נרות:T'
    '\n',
  ];
}