import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final Color color;
  final double height;
  final double width;
  final double borderRadius;

  const CustomTabIndicator({
    required this.color,
    required this.height,
    required this.width,
    required this.borderRadius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(
      color: color,
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final Color color;
  final double width;
  final double height;
  final double borderRadius;

  _CustomTabIndicatorPainter({
    required this.color,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Rect.fromPoints(
      Offset(offset.dx, offset.dy + configuration.size!.height), // Adjust Y coordinate
      Offset(offset.dx + width, offset.dy + configuration.size!.height + height), // Adjust Y coordinate
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);

    final RRect roundedRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius), // Apply border radius
    );

    canvas.drawRRect(roundedRect, paint);

    // Draw the glow using a shadow
    canvas.drawRRect(
      roundedRect.inflate(10.0),
      shadowPaint,
    );
  }
}