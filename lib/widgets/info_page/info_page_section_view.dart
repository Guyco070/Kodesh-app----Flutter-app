import 'package:flutter/material.dart';
import 'package:kodesh_app/models/info_page_section.dart';

/// One section: an optional heading (announced as a heading by screen
/// readers) followed by paragraphs.
class InfoPageSectionView extends StatelessWidget {
  const InfoPageSectionView({super.key, required this.section});

  final InfoPageSection section;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Semantics(
                header: true,
                child: Text(
                  section.title!,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          for (final paragraph in section.paragraphs)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                paragraph,
                style: textTheme.bodyLarge?.copyWith(height: 1.55),
              ),
            ),
        ],
      ),
    );
  }
}
