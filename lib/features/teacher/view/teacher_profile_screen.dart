// ignore_for_file: use_build_context_synchronously

import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/profile_achievements_card.dart';
import 'package:edutech_app/core/common/widgets/profile_card.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.page(
          trailingWidget: LogoutButton(),
          pageTitle: "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                children: [
                  const ProfileCard(),
                  SizedBox(height: MediaQuery.of(context).size.width * .08),
                  Row(
                    children: [
                      const ProfileAchievementsCard(
                        image: 'assets/icons/book.svg',
                        num: 0,
                        acheive: 'Lessons Created',
                      ),
                      const SizedBox(width: 10),
                      const ProfileAchievementsCard(
                        image: 'assets/icons/grad_cap.svg',
                        num: 2,
                        acheive: 'Classes',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return GradientScaffold.main(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(90 + MediaQuery.of(context).padding.top),
//         child: _buildAppBar(context),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Profile Card
//               //  _buildProfileCard(context),
//               ProfileCard(),

//               // Stats
//               _buildStatsSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAppBar(BuildContext context) {
//     return const CustomAppbar.page(
//       pageTitle: 'Profile',
//       trailingWidget: Icon(
//         Icons.settings_outlined,
//         color: AppColors.textPrimary,
//       ),
//     );
//   }

//   Widget _buildProfileCard(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(AppSpacing.spacing32),
//       margin: const EdgeInsets.all(AppSpacing.spacing24),
//       decoration: BoxDecoration(
//         color: AppColors.sky50,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: AppColors.borderLight),
//         boxShadow: [AppColors.defaultShadow],
//       ),
//       child: Column(
//         children: [
//           // Profile Image
//           Stack(
//             children: [
//               const CircleAvatar(
//                 radius: 64,
//                 backgroundImage: AssetImage(
//                   'assets/images/profile_placeholder.png',
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   padding: const EdgeInsets.all(AppSpacing.spacing4),
//                   decoration: BoxDecoration(
//                     color: AppColors.sky50,
//                     shape: BoxShape.circle,
//                     boxShadow: [AppColors.defaultShadow],
//                   ),
//                   child: const Icon(
//                     Icons.camera_enhance_outlined,
//                     color: AppColors.sky700,
//                     size: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: AppSpacing.spacing16),

//           // Name and Username
//           Text('Aubrey Graham', style: AppTypography.heading3),
//           Text(
//             '@certifiedloverboy',
//             style: AppTypography.subtle.copyWith(color: AppColors.textPrimary),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatsSection(BuildContext context) {
//     final classesController = context.watch<TeacherClassesController>();

//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing24),
//       child: Row(
//         children: [
//           ProfileAchievementsCard(
//             image: 'assets/icons/book.svg',
//             num: 37,
//             acheive: 'Lessons Created',
//           ),
//           const SizedBox(width: AppSpacing.spacing16),
//           ProfileAchievementsCard(
//             image: 'assets/icons/grad_cap.svg',
//             num: classesController.classCount,
//             acheive: 'Classes',
//           ),
//         ],
//       ),
//     );
//   }
// }

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        "Logout",
        style: AppTypography.large.copyWith(color: AppColors.sky300),
      ),
      onTap: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Logout", textAlign: TextAlign.center),

            contentTextStyle: AppTypography.tableItem,
            content: Text("Are you sure you want to logout?"),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              ),
            ],
          ),
        );

        if (confirmed != null && confirmed) {
          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          await userProvider.logout();
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.signIn,
            (route) => false,
          );
        }
      },
    );
  }
}
