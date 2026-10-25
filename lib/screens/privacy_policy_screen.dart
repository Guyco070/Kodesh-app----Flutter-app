import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/data/site_pages_content.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/info_page/info_page_body.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const String routeName = '/privacy';

  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.privacyMenu),
      body: InfoPageBody(sections: SitePagesContent.privacy(lang)),
    );
  }
}
