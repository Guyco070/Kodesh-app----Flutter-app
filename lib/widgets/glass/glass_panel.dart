import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/theme/kodesh_theme.dart';

/// A translucent "glass" surface: white tint, thin light border and a top
/// highlight, as in the liquid-glass design.
///
/// By default it does not blur what is behind it: the screen gradients are
/// smooth, so a blur adds almost nothing and costs a lot on long lists. Set
/// [blur] only for surfaces that float over scrolling content (the bottom
/// navigation bar).
///
/// For a plain tappable card in a list, a themed `Card` already looks the
/// same; use this for heroes, grouped rows and custom layouts.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = KodeshTheme.cardRadius,
    this.strong = false,
    this.blur = false,
    this.elevated = false,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  /// A brighter, top-lit fill for the main card of a screen.
  final bool strong;

  /// Blur the content behind the panel.
  final bool blur;

  /// Adds a soft drop shadow.
  final bool elevated;

  /// Overrides the white glass tint (ignored when [strong]).
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    final decoration = BoxDecoration(
      borderRadius: borderRadius,
      color: strong ? null : (color ?? KodeshPalette.glassFill),
      gradient:
          strong
              ? const LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [Color(0x57FFFFFF), Color(0x1AFFFFFF)],
              )
              : null,
      border: Border.all(
        color: strong ? const Color(0x73FFFFFF) : KodeshPalette.glassBorder,
      ),
      boxShadow:
          elevated
              ? const [
                BoxShadow(
                  color: Color(0x66051446),
                  blurRadius: 50,
                  offset: Offset(0, 20),
                ),
              ]
              : null,
    );

    Widget panel = DecoratedBox(
      decoration: decoration,
      // Ink (ripples, highlights) of tappable rows inside the panel is
      // painted on this layer and clipped to the panel's rounded shape,
      // instead of on the scaffold underneath, where it would show square
      // corners past the panel's edge.
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Padding(padding: padding, child: child),
      ),
    );

    if (blur) {
      panel = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: panel,
        ),
      );
    }
    return panel;
  }
}
