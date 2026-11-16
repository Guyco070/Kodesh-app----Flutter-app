import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

class ThingToRemind extends StatefulWidget {
  final String title;
  final IconData icon;

  const ThingToRemind({super.key, required this.title, required this.icon});

  @override
  State<ThingToRemind> createState() => _ThingToRemindState();
}

class _ThingToRemindState extends State<ThingToRemind> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        final iconSize = size * 0.32;
        final fontSize = (size * 0.11).clamp(11.0, 16.0);

        return Semantics(
          button: true,
          checked: isChecked,
          child: GestureDetector(
            onTap: () => setState(() => isChecked = !isChecked),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color:
                    isChecked
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color:
                      isChecked
                          ? Theme.of(context).colorScheme.primary
                          : KodeshPalette.glassBorder,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isChecked ? Icons.check_circle_rounded : widget.icon,
                      key: ValueKey(isChecked),
                      size: iconSize,
                      color:
                          isChecked
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: size * 0.06),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size * 0.06),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                        color:
                            isChecked
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
