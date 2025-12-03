import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;
  final VoidCallback? onTap;

  const StudentCard({super.key, required this.student, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(24), // 24dp radius from Figma
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Profile Image
              _buildAvatar(),
              const SizedBox(width: 16),

              // Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name
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
                    // Completed Lessons
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
                        Text(
                          'Completed ${student.completedLessons} lessons',
                          style: AppTypography.labelmedium.copyWith(
                            color: AppColors.buttonprimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Points Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFF25AFF4), width: 2),
                ),
                child: Text(
                  '${student.points} pts',
                  style: AppTypography.labellarge.copyWith(
                    color: const Color(0xFF25AFF4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage =
        student.profileImageUrl != null && student.profileImageUrl!.isNotEmpty;
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
}
