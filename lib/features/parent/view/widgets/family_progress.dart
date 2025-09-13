import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/model/family_progress_model.dart';
import 'package:edutech_app/features/parent/view/widgets/childern_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FamilyProgressCard extends StatelessWidget {
  const FamilyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FamilyProgressModel> familycards = [
      FamilyProgressModel(
        image: 'assets/icons/profile.svg',
        num: 2,
        title: 'Children',
      ),
      FamilyProgressModel(
        image: 'assets/icons/grad_cap.svg',
        num: 7,
        title: "Classes",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/cup.svg',
              height: AppSpacing.iconLG,
              colorFilter: ColorFilter.mode(AppColors.sky500, BlendMode.srcIn),
            ),
            SizedBox(width: AppSpacing.sm),
            Text('Family progress', style: AppTypography.heading3),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: familycards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return FamilyCard(familyProgress: familycards[index]);
            },
          ),
        ),
      ],
    );
  }
}
