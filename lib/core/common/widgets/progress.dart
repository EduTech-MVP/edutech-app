import 'package:edutech_app/core/common/widgets/subject_card_widget.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/child/models/subjec_model.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Subject> subjects = [
      Subject(
        image: 'assets/images/math.svg',
        title: 'Math',
        subTitle: 'Class B -',
        lessonsCompleted: 'Completed 8 lessons',
      ),
      Subject(
        image: 'assets/images/science.svg',
        title: 'Science',
        subTitle: 'Class A - Metro Boomin',
        lessonsCompleted: 'Completed 12 lessons',
      ),
      Subject(
        image: 'assets/images/english.svg',
        title: 'English',
        subTitle: 'Class M - Kendrick Lamar',
        lessonsCompleted: 'Completed 10 lessons',
      ),
      Subject(
        image: 'assets/images/arabic.svg',
        title: 'Arabic',
        subTitle: 'Class C - DJ Khalid',
        lessonsCompleted: 'Completed 7 lessons',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Image(
              height: AppSpacing.iconLG,
              color: AppColors.sky500,
              image: AssetImage('assets/icons/star.svg'),
            ),
            SizedBox(width: AppSpacing.sm),
            Text('Your progress', style: AppTypography.heading3),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subjects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return SubjectCard(subject: subjects[index]);
            },
          ),
        ),
      ],
    );
  }
}
