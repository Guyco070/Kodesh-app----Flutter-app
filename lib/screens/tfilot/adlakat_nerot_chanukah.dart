import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';

class AdlakatNerotChanukah extends StatelessWidget {
  const AdlakatNerotChanukah({super.key});
  static const String routeName = '/adlakat_nerot_chanuca';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(title: 'סדר הדלקת נרות חנוכה'),
        body:  SizedBox(
          child: Text("הדלקת נרות חנוכה"),
        ));
  }
}
