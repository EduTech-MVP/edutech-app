import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/view/widgets/add_child_dialog.dart';
import 'package:edutech_app/features/parent/view/widgets/child_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.page(
          //  navigationPage: ParentMainScreen(),
          pageTitle: "Children",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/profile.svg',
                      height: AppSpacing.iconLG,
                      colorFilter: ColorFilter.mode(
                        AppColors.sky500,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Manage Children',
                      style: AppTypography.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  text: 'Add Child',
                  width: 122,
                  onTap: () => AddChildDialog.show(context),
                  leadingIcon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: AppSpacing.iconSM,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // Children List
            Expanded(
              child: userProvider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : userProvider.children.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: userProvider.children.length,
                      itemBuilder: (context, index) {
                        final student = userProvider.children[index];
                        return ChildCard(
                          name: '${student.firstName} ${student.lastName}',
                          username: student.username,
                          lessonsCompleted: 0,
                          classes: 0,
                          points: 0,
                          profileImage: student.profileImagePath,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.family_restroom, size: 80, color: AppColors.neutral400),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No children added yet',
            style: AppTypography.heading4.copyWith(color: AppColors.neutral600),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap the "Add Child" button to add your child',
            style: AppTypography.subtle.copyWith(color: AppColors.neutral500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
