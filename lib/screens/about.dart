import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/data/site_pages_content.dart';
import 'package:kodesh_app/screens/accessibility_statement_screen.dart';
import 'package:kodesh_app/screens/privacy_policy_screen.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/brand/kodesh_emblem.dart';
import 'package:kodesh_app/widgets/brand/kodesh_wordmark.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/widgets/info_page/info_page_body.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;

    return GlassScaffold(
      backdrop: KodeshBackdrop.settings,
      appBar: CustomAppBar(title: appLocalizations.aboutMenu),
      body: InfoPageBody(
        sections: SitePagesContent.about(lang),
        header: const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              KodeshEmblem(width: 140),
              SizedBox(height: 10),
              KodeshWordmark(fontSize: 40),
            ],
          ),
        ),
        footer: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
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
