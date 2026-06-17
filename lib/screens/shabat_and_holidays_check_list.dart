import 'package:flutter/material.dart';
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
                style: TextButton.styleFrom(foregroundColor: Colors.red),
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

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.choresBeforeShabbatMenu,
        trailing: TextButton(
          onPressed: () => setState(() => _isAll = !_isAll),
          child: Text(
            _isAll ? l10n.all : l10n.my,
            style: TextStyle(color: Colors.grey.shade700),
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
              : CustomScrollView(
                slivers: [
                  if (selectedPredefined.isNotEmpty)
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final key = selectedPredefined.toList()[index];
                        final element =
                            reminders.allShabatAndHolidaysThingsToRemindMap(
                              context,
                            )[key]!;
                        return ThingToRemind(
                          title: element['action'] as String,
                          icon: element['icon'] as IconData,
                        );
                      }, childCount: selectedPredefined.length),
                    ),
                  if (reminders.customChecklistItems.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Text(
                          l10n.customTasksSection,
                          style: TextStyle(
                            color: Colors.grey[600],
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
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
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
    );
  }
}
