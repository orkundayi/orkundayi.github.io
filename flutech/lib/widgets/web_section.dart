import 'package:flutter/material.dart';

class WebSection extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool hasPattern;
  final String id; // Added id parameter for section identification

  const WebSection({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 100),
    this.hasPattern = false,
    required this.id, // Required parameter for section identification
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width > 1100 ? 120.0 : (screenSize.width > 768 ? 60.0 : 24.0);

    return Container(
      key: ValueKey(id), // Use id as key for section identification
      padding: padding,
      width: double.infinity,
      color: backgroundColor,
      child: Stack(
        children: [
          if (hasPattern)
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'assets/images/pattern.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
