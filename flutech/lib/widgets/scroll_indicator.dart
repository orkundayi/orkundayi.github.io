import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math;

class ScrollIndicator extends StatefulWidget {
  final VoidCallback onTap;

  const ScrollIndicator({
    super.key,
    required this.onTap,
  });

  @override
  State<ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(30),
          hoverColor: theme.colorScheme.primary.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
              color: theme.colorScheme.surface.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.scrollDown,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Transform.translate(
                  offset: Offset(0, 4 * math.sin(_animation.value * 2 * math.pi)),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
