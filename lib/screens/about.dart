import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/data/site_pages_content.dart';
import 'package:kodesh_app/screens/accessibility_statement_screen.dart';
import 'package:kodesh_app/screens/privacy_policy_screen.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/info_page/info_page_body.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.aboutMenu),
      body: InfoPageBody(
        sections: SitePagesContent.about(lang),
        footer: Wrap(
          spacing: 8,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.accessibility_new),
              label: Text(appLocalizations.accessibilityMenu),
              onPressed:
                  () => Navigator.pushNamed(
                    context,
                    AccessibilityStatementScreen.routeName,
                  ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.privacy_tip_outlined),
              label: Text(appLocalizations.privacyMenu),
              onPressed:
                  () => Navigator.pushNamed(
                    context,
                    PrivacyPolicyScreen.routeName,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
