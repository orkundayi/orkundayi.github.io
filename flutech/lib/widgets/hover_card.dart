import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double elevation;
  final double hoverElevation;
  final VoidCallback? onTap; // Added onTap parameter

  const HoverCard({
    super.key,
    required this.child,
    this.elevation = 4.0,
    this.hoverElevation = 8.0,
    this.onTap, // Added to constructor
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Added GestureDetector for handling taps
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: _isHovering ? widget.hoverElevation : widget.elevation,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          transform: _isHovering ? (Matrix4.identity()..translate(0.0, -5.0, 0.0)) : Matrix4.identity(),
          child: widget.child,
        ),
      ),
    );
  }
}
