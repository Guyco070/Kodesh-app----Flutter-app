import 'package:flutter/material.dart';
import 'package:kodesh_app/models/info_page_section.dart';
import 'package:kodesh_app/widgets/info_page/info_page_section_view.dart';

/// Scrollable, readable-width column of [InfoPageSection]s. Text is
/// selectable so people can copy contact details.
class InfoPageBody extends StatelessWidget {
  const InfoPageBody({super.key, required this.sections, this.footer});

  final List<InfoPageSection> sections;

  /// Optional widget shown after the sections (e.g. links to other pages).
  final Widget? footer;

  /// Lines longer than this are hard to read on wide screens.
  static const double maxReadableWidth = 760;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxReadableWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final section in sections)
                  InfoPageSectionView(section: section),
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
