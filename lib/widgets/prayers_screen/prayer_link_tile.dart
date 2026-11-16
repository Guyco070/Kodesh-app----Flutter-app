import 'package:flutter/material.dart';

/// One row of the prayers list: tinted icon badge, title and a chevron that
/// points forward in the reading direction.
class PrayerLinkTile extends StatelessWidget {
  const PrayerLinkTile({
    super.key,
    required this.icon,
    required this.tint,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final Color tint;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border:
                showDivider
                    ? Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerTheme.color!,
                      ),
                    )
                    : null,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xB3FFFFFF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
