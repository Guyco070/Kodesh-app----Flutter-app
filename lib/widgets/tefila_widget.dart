import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_fonts.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/providers/tfilot.dart';
import 'package:kodesh_app/theme/kodesh_theme.dart';
import 'package:kodesh_app/widgets/glass/glass_panel.dart';
import 'package:kodesh_app/widgets/glass/glass_round_button.dart';
import 'package:provider/provider.dart';

class TefilaWidget extends StatefulWidget {
  const TefilaWidget({
    Key? key,
    required this.getBracha,
    this.imagePath,
    this.imageExtaLine,
    this.isWithNosah = true,
    this.header,
  }) : super(key: key);

  /// Shown above everything else (e.g. the Omer count card).
  final Widget? header;

  final Map<String, Map<Nosah, List<String>>> getBracha;
  final String? imagePath;
  final String? imageExtaLine;
  final bool isWithNosah;

  @override
  State<TefilaWidget> createState() => _TefilaWidgetState();
}

class _TefilaWidgetState extends State<TefilaWidget> {
  double fontSizeScale = 0;

  increaseFontSizeScale() {
    setState(() {
      fontSizeScale++;
    });
  }

  decreaseFontSizeScale() {
    if (fontSizeScale > -3) {
      setState(() {
        fontSizeScale--;
      });
    }
  }

  resetFontSizeScale() {
    setState(() {
      fontSizeScale = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      primary: true,
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        16,
        24 + MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.header != null) ...[
                widget.header!,
                const SizedBox(height: 14),
              ],
              if (widget.imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(KodeshTheme.cardRadius),
                  child: Image.asset(
                    widget.imagePath!,
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                  ),
                ),
              if (widget.imageExtaLine != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                  child: Text(
                    widget.imageExtaLine!.trim(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              if (widget.isWithNosah) ...[
                const SizedBox(height: 16),
                Provider.of<Tfilot>(
                  context,
                ).getNosahim(context, widget.getBracha),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassRoundButton(
                    onPressed:
                        fontSizeScale > -3 ? decreaseFontSizeScale : null,
                    tooltip: l.decreaseTextSize,
                    icon: Icons.text_decrease_rounded,
                  ),
                  const SizedBox(width: 10),
                  GlassRoundButton(
                    onPressed: fontSizeScale != 0 ? resetFontSizeScale : null,
                    tooltip: l.resetTextSize,
                    icon: Icons.restart_alt_rounded,
                  ),
                  const SizedBox(width: 10),
                  GlassRoundButton(
                    onPressed: increaseFontSizeScale,
                    tooltip: l.increaseTextSize,
                    icon: Icons.text_increase_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GlassPanel(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 22,
                ),
                child: Text.rich(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: KodeshFonts.prayer,
                    height: 1.75,
                    color: Colors.white,
                  ),
                  TextSpan(
                    children: Provider.of<Tfilot>(
                      context,
                      listen: false,
                    ).getSederWidgets(
                      getBracha: widget.getBracha,
                      isWithNosah: widget.isWithNosah,
                      fontSizeScale: fontSizeScale,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
