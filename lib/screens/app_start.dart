import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kodesh_app/providers/events.dart';
import 'package:kodesh_app/screens/home_shell.dart';
import 'package:kodesh_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

/// The app's home route: builds [HomeShell] at once (so its first fetch
/// starts) and keeps [SplashScreen] over it until the week's events arrive,
/// then fades the splash out.
///
/// The splash stays at least [_minShown] so it never just flashes, and at
/// most [_maxShown] so a slow or failed fetch never traps the user on it.
class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  static const Duration _minShown = Duration(milliseconds: 1600);
  static const Duration _maxShown = Duration(seconds: 6);

  bool _minElapsed = false;
  bool _hiding = false;
  bool _gone = false;
  Timer? _minTimer;
  Timer? _maxTimer;

  @override
  void initState() {
    super.initState();
    _minTimer = Timer(_minShown, () {
      _minElapsed = true;
      _maybeHide();
    });
    _maxTimer = Timer(_maxShown, _hide);
  }

  @override
  void dispose() {
    _minTimer?.cancel();
    _maxTimer?.cancel();
    super.dispose();
  }

  void _maybeHide() {
    if (!mounted || !_minElapsed) return;
    final loaded = context.read<Events>().eventsItems?.isNotEmpty ?? false;
    if (loaded) _hide();
  }

  void _hide() {
    if (!mounted || _hiding) return;
    setState(() => _hiding = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_gone && !_hiding) {
      // Re-check whenever events change.
      context.watch<Events>();
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeHide());
    }
    return Stack(
      children: [
        ExcludeSemantics(excluding: !_hiding, child: const HomeShell()),
        if (!_gone)
          IgnorePointer(
            ignoring: _hiding,
            child: AnimatedOpacity(
              opacity: _hiding ? 0 : 1,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOut,
              onEnd: () => setState(() => _gone = true),
              child: const SplashScreen(),
            ),
          ),
      ],
    );
  }
}
