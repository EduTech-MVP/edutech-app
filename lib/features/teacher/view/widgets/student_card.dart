import 'package:edutech_app/core/models/student_flag.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final StudentFlag flag;
  final VoidCallback? onTap;

  const StudentCard({
    super.key,
    required this.student,
    this.flag = StudentFlag.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: _getCardColor(),
          border: Border.all(
            color: _getBorderColor(),
            width: _getBorderWidth(),
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _getShadowColor(),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Avatar
              _buildAvatar(),
              const SizedBox(width: 16),

              /// Student Info (flexible so it shrinks if needed)
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text(
                      student.name.isNotEmpty
                          ? student.name
                          : 'Unknown Student',
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    /// Completed Lessons Row
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/book.svg',
                          height: 18,
                          width: 18,
                          colorFilter: const ColorFilter.mode(
                            AppColors.buttonprimary,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),

                        /// Prevent overflow inside this row
                        Flexible(
                          child: Text(
                            'Completed ${student.completedLessons} lessons',
                            style: AppTypography.labelmedium.copyWith(
                              color: AppColors.buttonprimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // const SizedBox(width: 12),

              // /// Points Badge - Commented out for now
              // _buildPointsBadge(),
            ],
          ),
        ),
      ),
    );
  }

  /// Avatar Builder
  Widget _buildAvatar() {
    final hasImage = student.profileImageUrl != null &&
        student.profileImageUrl!.isNotEmpty &&
        (student.profileImageUrl!.startsWith('http://') ||
            student.profileImageUrl!.startsWith('https://'));

    final initial = student.name.isNotEmpty
        ? student.name[0].toUpperCase()
        : 'S';

    return CircleAvatar(
      radius: 32,
      backgroundImage: hasImage ? NetworkImage(student.profileImageUrl!) : null,
      backgroundColor: AppColors.sky100,
      child: !hasImage
          ? Text(
              initial,
              style: const TextStyle(
                color: AppColors.sky600,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            )
          : null,
    );
  }

  // /// Points Badge - Commented out for now
  // Widget _buildPointsBadge() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(100),
  //       border: Border.all(color: const Color(0xFF25AFF4), width: 2),
  //     ),
  //     child: Text(
  //       '${student.points} pts',
  //       style: AppTypography.labellarge.copyWith(
  //         color: const Color(0xFF25AFF4),
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  // }

  Color _getCardColor() {
    switch (flag) {
      case StudentFlag.excellent:
        // Green - excellent performance
        return const Color(0xFFE8F5E9); // Light green
      case StudentFlag.good:
        // Blue - good performance
        return const Color(0xFFE3F2FD); // Light blue
      case StudentFlag.average:
        // Yellow - average performance
        return const Color(0xFFFFF9C4); // Light yellow
      case StudentFlag.needsAssistance:
        // Red - needs assistance
        return const Color(0xFFFFEBEE); // Light red
      case StudentFlag.normal:
        return Colors.white;
    }
  }

  Color _getBorderColor() {
    switch (flag) {
      case StudentFlag.excellent:
        return AppColors.success; // Green
      case StudentFlag.good:
        return AppColors.sky500; // Blue
      case StudentFlag.average:
        return AppColors.warning; // Yellow/Orange
      case StudentFlag.needsAssistance:
        return AppColors.error; // Red
      case StudentFlag.normal:
        return AppColors.border;
    }
  }

  double _getBorderWidth() {
    switch (flag) {
      case StudentFlag.excellent:
        return 2.0; // Thicker border for excellent students
      case StudentFlag.good:
        return 1.5;
      case StudentFlag.average:
        return 1.5;
      case StudentFlag.needsAssistance:
        return 1.5;
      case StudentFlag.normal:
        return 1.0;
    }
  }

  Color _getShadowColor() {
    switch (flag) {
      case StudentFlag.excellent:
        return AppColors.success.withOpacity(0.15); // Green shadow
      case StudentFlag.good:
        return AppColors.sky500.withOpacity(0.15); // Blue shadow
      case StudentFlag.average:
        return AppColors.warning.withOpacity(0.15); // Yellow shadow
      case StudentFlag.needsAssistance:
        return AppColors.error.withOpacity(0.15); // Red shadow
      case StudentFlag.normal:
        return Colors.black.withOpacity(0.04);
    }
  }
}
