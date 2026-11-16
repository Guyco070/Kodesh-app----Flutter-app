import 'package:flutter/material.dart';
import 'package:kodesh_app/theme/kodesh_fonts.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';

/// Builds the app theme for the liquid-glass design.
///
/// Screens are painted by `GlassScaffold` on a dark gradient, so both modes
/// use a dark color scheme (white text). [isDark] only changes the solid
/// surfaces used by menus, dialogs, sheets and the drawer.
abstract final class KodeshTheme {
  static const double cardRadius = 28;
  static const double heroRadius = 36;

  static ThemeData build({required bool isDark}) {
    final solid =
        isDark ? KodeshPalette.navySurfaceDark : KodeshPalette.navySurface;

    final scheme = const ColorScheme.dark().copyWith(
      primary: KodeshPalette.flame,
      onPrimary: KodeshPalette.logoBlue,
      primaryContainer: KodeshPalette.glassFillStrong,
      onPrimaryContainer: Colors.white,
      secondary: KodeshPalette.sentenceBlue,
      onSecondary: KodeshPalette.logoBlue,
      secondaryContainer: KodeshPalette.glassFillStrong,
      onSecondaryContainer: Colors.white,
      tertiary: const Color(0xFF9EC5FF),
      onTertiary: KodeshPalette.logoBlue,
      tertiaryContainer: KodeshPalette.glassFill,
      onTertiaryContainer: Colors.white,
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      surface: solid,
      onSurface: Colors.white,
      onSurfaceVariant: KodeshPalette.textMuted,
      surfaceContainerLowest: solid,
      surfaceContainerLow: solid,
      surfaceContainer: solid,
      surfaceContainerHigh: Color.lerp(solid, Colors.white, 0.06),
      surfaceContainerHighest: Color.lerp(solid, Colors.white, 0.1),
      outline: KodeshPalette.glassBorder,
      outlineVariant: KodeshPalette.hairline,
      inverseSurface: Colors.white,
      onInverseSurface: KodeshPalette.logoBlue,
      inversePrimary: KodeshPalette.logoBlue,
      shadow: const Color(0xFF030F32),
    );

    final roundedGlass = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardRadius),
      side: const BorderSide(color: KodeshPalette.glassBorder),
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      fontFamily: KodeshFonts.ui,
    );

    return base.copyWith(
      extensions: [KodeshGlassTheme(isDark: isDark)],
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: solid,
      textTheme: base.textTheme.copyWith(
        displaySmall: base.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: KodeshPalette.glassFill,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: roundedGlass,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: solid,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Color.lerp(solid, Colors.white, 0.04),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: KodeshPalette.hairline),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: solid,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Color.lerp(solid, Colors.white, 0.04),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: const DividerThemeData(color: KodeshPalette.hairline),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        textColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        circularTrackColor: KodeshPalette.glassFill,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected)
                  ? KodeshPalette.switchOn
                  : KodeshPalette.glassFillStrong,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected)
                  ? KodeshPalette.switchOn
                  : Colors.transparent,
        ),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        side: const BorderSide(color: Colors.white, width: 1.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: KodeshPalette.glassFill,
        selectedColor: KodeshPalette.glassFillStrong,
        checkmarkColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.white),
        side: const BorderSide(color: KodeshPalette.glassBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) =>
                states.contains(WidgetState.selected)
                    ? KodeshPalette.glassFillStrong
                    : KodeshPalette.glassFill,
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          side: const WidgetStatePropertyAll(
            BorderSide(color: KodeshPalette.glassBorder),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KodeshPalette.glassFillStrong,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const StadiumBorder(
            side: BorderSide(color: KodeshPalette.glassBorder),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: KodeshPalette.logoBlue,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: KodeshPalette.logoBlue,
        elevation: 4,
        shape: StadiumBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KodeshPalette.glassFill,
        hintStyle: const TextStyle(color: KodeshPalette.textMuted),
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: KodeshPalette.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: KodeshPalette.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: Colors.white, width: 1.6),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(color: KodeshPalette.logoBlue),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Tells glass widgets whether the dark variant of the design is active.
class KodeshGlassTheme extends ThemeExtension<KodeshGlassTheme> {
  const KodeshGlassTheme({required this.isDark});

  final bool isDark;

  static bool isDarkOf(BuildContext context) =>
      Theme.of(context).extension<KodeshGlassTheme>()?.isDark ?? false;

  @override
  KodeshGlassTheme copyWith({bool? isDark}) =>
      KodeshGlassTheme(isDark: isDark ?? this.isDark);

  @override
  KodeshGlassTheme lerp(KodeshGlassTheme? other, double t) =>
      t < 0.5 ? this : (other ?? this);
}
