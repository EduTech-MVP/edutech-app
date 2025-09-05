import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DashedCircleUploadButton extends StatelessWidget {
  final double circularSize;
  final VoidCallback? onPressed;
  const DashedCircleUploadButton({
    super.key,
    this.circularSize = AppSpacing.xxxxxl * 2,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        painter: _DashedCirclePainter(
          strokeWidth: AppSpacing.xs,
          color: AppColors.neutral200,
          dashLength: AppSpacing.sm,
          spaceLength: AppSpacing.sm,
        ),
        child: Container(
          width: circularSize,
          height: circularSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Icon(
              Icons.file_upload_outlined,
              size: circularSize * 0.3,
              color: AppColors.sky700,
            ),
          ),
        ),
      ),
    );
  }
}

// CustomPainter to draw the dashed circle border
class _DashedCirclePainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dashLength;
  final double spaceLength;

  _DashedCirclePainter({
    required this.strokeWidth,
    required this.color,
    required this.dashLength,
    required this.spaceLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double circumference = 2 * pi * radius;
    final double dashAndSpaceLength = dashLength + spaceLength;
    final int numberOfDashes = (circumference / dashAndSpaceLength).floor();

    // Draw the dashes
    for (int i = 0; i < numberOfDashes; i++) {
      final double startAngle =
          (i * dashAndSpaceLength) / circumference * (2 * pi);
      final double sweepAngle = dashLength / circumference * (2 * pi);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.spaceLength != spaceLength;
  }
}
