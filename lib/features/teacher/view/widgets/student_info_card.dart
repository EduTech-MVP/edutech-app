import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentInfoCard extends StatelessWidget {
  final String studentName;
  final int grade;
  final String? profileImageUrl;
  final int completedLessons;
  final int totalLessons;
  final int weeklyProgress;

  const StudentInfoCard({
    super.key,
    required this.studentName,
    required this.grade,
    this.profileImageUrl,
    required this.completedLessons,
    required this.totalLessons,
    required this.weeklyProgress,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [AppColors.shadowLarge],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Section
            Row(
              children: [
                // Profile Picture
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: profileImageUrl != null &&
                            profileImageUrl!.isNotEmpty &&
                            (profileImageUrl!.startsWith('http://') ||
                                profileImageUrl!.startsWith('https://'))
                        ? DecorationImage(
                            image: NetworkImage(profileImageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: profileImageUrl == null ? AppColors.funmint : null,
                  ),
                  child: profileImageUrl == null
                      ? Center(
                          child: Text(
                            _getInitials(studentName),
                            style: AppTypography.heading2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Name and Grade
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        studentName,
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${grade}th Grade',
                        style: AppTypography.labellarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stats Section
            Row(
              children: [
                // Lessons Stat
                Expanded(
                  child: _buildStatCard(
                    iconPath: 'assets/icons/book.svg',
                    iconColor: AppColors.primary,
                    label: 'Lessons',
                    value: '$completedLessons/$totalLessons',
                    backgroundColor: Color(0xffF0F7FF),
                    borderColor: AppColors.border,
                    textColor: AppColors.foreground,
                    labelColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                // Weekly Progress Stat
                Expanded(
                  child: _buildStatCard(
                    iconPath: 'assets/icons/lineup.svg',
                    iconColor: AppColors.secondary,
                    label: 'Weekly',
                    value: '$weeklyProgress%',
                    backgroundColor: AppColors.funmint2,
                    borderColor: AppColors.border,
                    textColor: AppColors.foreground,
                    labelColor: AppColors.foreground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String iconPath,
    required Color iconColor,
    required String label,
    required String value,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required Color labelColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTypography.labelmedium.copyWith(color: labelColor),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.heading2.copyWith(color: textColor)),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    List<String> names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
