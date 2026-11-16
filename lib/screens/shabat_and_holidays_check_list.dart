import 'package:flutter/material.dart';
import 'package:kodesh_app/widgets/tab_header.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/glass/glass_scaffold.dart';
import 'package:kodesh_app/providers/reminders.dart';
import 'package:kodesh_app/widgets/custom_app_bar.dart';
import 'package:kodesh_app/widgets/thing_to_remind.dart';
import 'package:provider/provider.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';

class ShabatAndHolidaysCheckList extends StatefulWidget {
  const ShabatAndHolidaysCheckList({super.key});

  @override
  State<ShabatAndHolidaysCheckList> createState() =>
      _ShabatAndHolidaysCheckListState();

  static const routeName = '/shabat_and_holidays_check_list';
}

class _ShabatAndHolidaysCheckListState
    extends State<ShabatAndHolidaysCheckList> {
  bool _isAll = false;

  void _showAddTaskDialog(
    BuildContext context,
    Reminders reminders,
    AppLocalizations l10n,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.addCustomTask),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(labelText: l10n.taskName),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  reminders.addCustomChecklistItem(value.trim());
                  Navigator.of(ctx).pop();
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    reminders.addCustomChecklistItem(controller.text.trim());
                    Navigator.of(ctx).pop();
                  }
                },
                child: Text(l10n.add),
              ),
            ],
          ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    Reminders reminders,
    AppLocalizations l10n,
    int index,
  ) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.deleteTaskTitle),
            content: Text(reminders.customChecklistItems[index]),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () {
                  reminders.removeCustomChecklistItem(index);
                  Navigator.of(ctx).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: Text(l10n.delete),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reminders = Provider.of<Reminders>(context);
    final l10n = AppLocalizations.of(context)!;

    final selectedPredefined =
        _isAll
            ? reminders
                .allShabatAndHolidaysThingsToRemindMap(context)
                .keys
                .toList()
            : reminders.shabatAndHolidaysThingsToRemindList;

    final hasContent =
        selectedPredefined.isNotEmpty ||
        reminders.customChecklistItems.isNotEmpty;

    return GlassScaffold(
      backdrop: KodeshBackdrop.home,
      appBar: CustomAppBar(
        title: l10n.choresBeforeShabbatMenu,
        // A glass pill as tall as the round back button at the other end.
        trailing: TextButton.icon(
          onPressed: () => setState(() => _isAll = !_isAll),
          icon: const Icon(Icons.filter_list_rounded, size: 20),
          label: Text(
            _isAll ? l10n.all : l10n.my,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: KodeshPalette.glassFill,
            side: const BorderSide(color: KodeshPalette.glassBorder),
            shape: const StadiumBorder(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, reminders, l10n),
        child: const Icon(Icons.add),
      ),
      body:
          !hasContent
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n.noChroesMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: TabHeader.maxContentWidth,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      if (selectedPredefined.isNotEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180,
                                  childAspectRatio: 0.92,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final key = selectedPredefined.toList()[index];
                              final element =
                                  reminders
                                      .allShabatAndHolidaysThingsToRemindMap(
                                        context,
                                      )[key]!;
                              return ThingToRemind(
                                title: element['action'] as String,
                                icon: element['icon'] as IconData,
                              );
                            }, childCount: selectedPredefined.length),
                          ),
                        ),
                      if (reminders.customChecklistItems.isNotEmpty) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                            child: Text(
                              l10n.customTasksSection,
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SliverReorderableList(
                          itemCount: reminders.customChecklistItems.length,
                          onReorder: reminders.reorderCustomChecklistItem,
                          itemBuilder: (context, index) {
                            final task = reminders.customChecklistItems[index];
                            return Material(
                              key: ValueKey(task + index.toString()),
                              color: Colors.transparent,
                              child: ListTile(
                                leading: ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(Icons.drag_handle),
                                ),
                                title: Text(task),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  onPressed:
                                      () => _showDeleteDialog(
                                        context,
                                        reminders,
                                        l10n,
                                        index,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                      const SliverToBoxAdapter(child: SizedBox(height: 80)),
                    ],
                  ),
                ),
              ),
    );
  }
}
