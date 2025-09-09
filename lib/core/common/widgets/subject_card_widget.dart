import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class Subject {
  final String image;
  final String title;
  final String subTitle;
  final String lessonsCompleted;

  Subject({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.lessonsCompleted,
  });
}

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: AppColors.sky50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Image(color: AppColors.sky500, image: AssetImage(subject.image)),
          const SizedBox(height: 16),
          // Title
          Text(subject.title, style: AppTypography.heading4),

          // Subtitle
          Text(
            subject.subTitle,
            style: AppTypography.subtle.copyWith(fontSize: 12),
          ),
          // Lessons Completed
          Text(
            subject.lessonsCompleted,
            style: AppTypography.subtle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
