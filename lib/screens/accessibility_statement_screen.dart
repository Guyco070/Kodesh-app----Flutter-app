import 'package:flutter/material.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/data/site_pages_content.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/info_page/info_page_body.dart';

/// Accessibility statement required by the Israeli Equal Rights for Persons
/// with Disabilities regulations (IS 5568).
class AccessibilityStatementScreen extends StatelessWidget {
  static const String routeName = '/accessibility';

  const AccessibilityStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.accessibilityMenu,
      ),
      body: InfoPageBody(sections: SitePagesContent.accessibility(lang)),
    );
  }
}
