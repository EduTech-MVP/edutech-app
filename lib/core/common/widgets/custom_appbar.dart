import 'dart:ui';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:edutech_app/features/student/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  final String? pageTitle;
  final Widget? trailingWidget;
  final VoidCallback? onTrailingPressed;
  final VoidCallback? onBackPressed;
  final bool isHomePage;
  final String? navigationPage;

  const CustomAppbar({
    super.key,
    this.pageTitle,
    this.trailingWidget,
    this.onTrailingPressed,
    this.onBackPressed,
    this.navigationPage,
  }) : isHomePage = pageTitle == null;

  // Home AppBar - shows profile and greeting
  const CustomAppbar.home({
    super.key,
    this.trailingWidget,
    this.onTrailingPressed,
    this.navigationPage,
  }) : pageTitle = null,
       onBackPressed = null,
       isHomePage = true;

  // Page AppBar - shows title with back arrow
  const CustomAppbar.page({
    super.key,
    required this.pageTitle,
    this.trailingWidget,
    this.onTrailingPressed,
    this.onBackPressed,
    this.navigationPage,
  }) : isHomePage = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.sky50,
            //  boxShadow: [AppColors.defaultShadow],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: isHomePage
                  ? _buildHomeContent(context)
                  : _buildPageContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.usersigned?.user ?? userProvider.profile;
    return Row(
      children: [
        // Profile avatar
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.06,
          backgroundImage:
              user?.profileImageUrl != null && user!.profileImageUrl!.isNotEmpty
              ? NetworkImage(user.profileImageUrl!)
              : NetworkImage(
                  'http://edutech.runasp.net/profile-images/default.jpg',
                ), // fallback URL
        ),

        const SizedBox(width: 16),
        // Greeting section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Good morning!',
                style: AppTypography.subtle.copyWith(
                  color: AppColors.neutral700,
                ),
              ),
              Text(
                '${user!.firstName}',
                style: AppTypography.heading4.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Trailing widget or notification bell
        if (trailingWidget != null)
          GestureDetector(onTap: onTrailingPressed, child: trailingWidget!)
        else
          GestureDetector(
            onTap: onTrailingPressed,
            child: Icon(
              FontAwesomeIcons.bell,
              color: AppColors.textPrimary,
              size: AppSpacing.iconMD,
            ),
          ),
      ],
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return Row(
      children: [
        //back arrow
        // GestureDetector(
        //   onTap: () => Navigator.pop(context),
        //   child: Container(
        //     width: 24,
        //     height: 24,
        //     alignment: Alignment.center,
        //     child: SvgPicture.asset(
        //       'assets/icons/backarrow.svg',
        //       width: 24,
        //       height: 24,
        //       colorFilter: ColorFilter.mode(
        //         AppColors.neutral800,
        //         BlendMode.srcIn,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(width: 16),
        //page title
        Expanded(
          child: Text(
            pageTitle ?? 'Page',
            style: AppTypography.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        // Trailing widget (optional)
        if (trailingWidget != null)
          GestureDetector(onTap: onTrailingPressed, child: trailingWidget!),
      ],
    );
  }
}
