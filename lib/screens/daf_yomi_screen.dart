import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class DafYomiScreen extends StatefulWidget {
  const DafYomiScreen({super.key});

  static const String routeName = '/daf_yomi';

  @override
  State<DafYomiScreen> createState() => _DafYomiScreenState();
}

class _DafYomiScreenState extends State<DafYomiScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDafYomi();
  }

  Future<void> _loadDafYomi() async {
    setState(() => _isLoading = true);
    await Provider.of<Events>(context, listen: false).fetchDafYomi();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final events = Provider.of<Events>(context);

    return GlassScaffold(
      backdrop: KodeshBackdrop.sunset,
      appBar: CustomAppBar(title: appLocalizations.dafYomiMenu),
      body: _buildBody(appLocalizations, events),
    );
  }

  Widget _buildBody(AppLocalizations appLocalizations, Events events) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (events.dafYomiError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appLocalizations.apiErrorMessage),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadDafYomi,
              child: Text(appLocalizations.retry),
            ),
          ],
        ),
      );
    }

    final daf = events.dafYomiItem;
    if (daf == null) {
      return Center(child: Text(appLocalizations.apiErrorMessage));
    }

    final parsedDate = DateTime.tryParse(daf.date);
    final dateText =
        parsedDate == null
            ? daf.date
            : DateFormat.yMMMMEEEEd(
              Localizations.localeOf(context).toLanguageTag(),
            ).format(parsedDate);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: TabHeader.maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GlassPanel(
            strong: true,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appLocalizations.todaysDaf,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    daf.hebrew,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(daf.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  dateText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (daf.link != null) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 4),
                  SelectableText(
                    daf.link!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
