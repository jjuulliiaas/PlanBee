import 'package:flutter/material.dart';

class BrowserTabIndicator extends Decoration {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double horizontalPadding;
  final double shadowElevation;

  const BrowserTabIndicator({
    required this.color,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.0,
    this.radius = 12.0,
    this.horizontalPadding = 0.0,
    this.shadowElevation = 0.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BrowserTabPainter(this, onChanged);
  }
}

class _BrowserTabPainter extends BoxPainter {
  final BrowserTabIndicator decoration;

  _BrowserTabPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Size size = configuration.size!;
    final double top = offset.dy;
    final double bottom = top + size.height;
    final double radius = decoration.radius;
    final double padding = decoration.horizontalPadding;

    final double left = offset.dx + padding;
    final double right = offset.dx + size.width - padding;

    final Path path = Path();

    path.moveTo(left - radius, bottom);
    path.quadraticBezierTo(left, bottom, left, bottom - radius);
    path.lineTo(left, top + radius);
    path.quadraticBezierTo(left, top, left + radius, top);
    path.lineTo(right - radius, top);
    path.quadraticBezierTo(right, top, right, top + radius);
    path.lineTo(right, bottom - radius);
    path.quadraticBezierTo(right, bottom, right + radius, bottom);

    if (decoration.shadowElevation > 0) {
      final Paint shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.12)
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, decoration.shadowElevation * 0.57735);

      canvas.drawPath(path.shift(const Offset(0, 2)), shadowPaint);
    }

    final Paint fillPaint = Paint()
      ..color = decoration.color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    if (decoration.borderColor != Colors.transparent) {
      final Paint strokePaint = Paint()
        ..color = decoration.borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = decoration.borderWidth
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true;

      canvas.drawPath(path, strokePaint);
    }
  }
}