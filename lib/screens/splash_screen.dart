import 'package:flutter/material.dart';
import 'package:kodesh_app/animations/rise_in.dart';
import 'package:kodesh_app/api/l10n/app_localizations.dart';
import 'package:kodesh_app/theme/kodesh_fonts.dart';
import 'package:kodesh_app/theme/kodesh_palette.dart';
import 'package:kodesh_app/widgets/brand/kodesh_emblem.dart';
import 'package:kodesh_app/widgets/brand/kodesh_wordmark.dart';
import 'package:kodesh_app/widgets/glass/gradient_backdrop.dart';
import 'package:kodesh_app/widgets/splash_screen/splash_loading_bar.dart';

/// The animated loading screen shown over the app while the first week of
/// times loads. It continues the native launch screen, which shows the same
/// logo on the same gradient.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const GradientBackdrop(
            backdrop: KodeshBackdrop.splash,
            followDarkMode: false,
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                const RiseIn(
                  distance: 20,
                  duration: Duration(seconds: 1),
                  child: KodeshEmblem(excludeFromSemantics: true),
                ),
                const SizedBox(height: 10),
                Semantics(
                  header: true,
                  label: 'Kodesh',
                  child: const RiseIn(
                    distance: 20,
                    delay: Duration(milliseconds: 250),
                    duration: Duration(seconds: 1),
                    child: KodeshWordmark(shimmer: true),
                  ),
                ),
                const SizedBox(height: 10),
                RiseIn(
                  distance: 20,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        l.splashTagline,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontFamily: KodeshFonts.tagline,
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          letterSpacing: 14 * 0.34,
                          color: Color(0xB3FFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                RiseIn(
                  distance: 20,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(seconds: 1),
                  child: Column(
                    children: [
                      SplashLoadingBar(semanticLabel: l.loading),
                      const SizedBox(height: 14),
                      Text(
                        l.splashLoading,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xBFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 72),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
