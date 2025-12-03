import 'dart:ui';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  final String? pageTitle;
  final Widget? trailingWidget;
  final VoidCallback? onTrailingPressed;
  final VoidCallback? onBackPressed;
  final bool isHomePage;

  const CustomAppbar({
    super.key,
    this.pageTitle,
    this.trailingWidget,
    this.onTrailingPressed,
    this.onBackPressed,
  }) : isHomePage = pageTitle == null;

  // Home AppBar - shows profile and greeting
  const CustomAppbar.home({
    super.key,
    this.trailingWidget,
    this.onTrailingPressed,
  }) : pageTitle = null,
       onBackPressed = null,
       isHomePage = true;

  // Page AppBar - shows title with no back arrow
  const CustomAppbar.screen({
    super.key,
    required this.pageTitle,
    this.trailingWidget,
    this.onTrailingPressed,
  }) : isHomePage = false,
       onBackPressed = null;

  // Page AppBar - shows title with back arrow
  const CustomAppbar.witharrow({
    super.key,
    required this.pageTitle,
    this.trailingWidget,
    this.onTrailingPressed,
    this.onBackPressed,
  }) : isHomePage = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
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
    final user = userProvider.profile;

    // Handle loading state
    if (userProvider.loading && user == null) {
      return Row(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.06,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 150,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Get greeting based on time of day
    final greeting = _getGreeting();

    return Row(
      children: [
        // Profile avatar
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.06,
          backgroundImage:
              user?.profileImageUrl != null && user!.profileImageUrl!.isNotEmpty
              ? NetworkImage(user.profileImageUrl!)
              : const NetworkImage(
                  'http://edutech.runasp.net/profile-images/default.jpg',
                ),
          child: user?.profileImageUrl == null || user!.profileImageUrl!.isEmpty
              ? Text(
                  user?.firstName?.isNotEmpty == true
                      ? user!.firstName![0].toUpperCase()
                      : 'U',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),

        const SizedBox(width: 16),

        // Greeting section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                greeting,
                style: AppTypography.subtle.copyWith(
                  color: AppColors.neutral700,
                ),
              ),
              Text(
                user?.firstName ?? 'User',
                style: AppTypography.heading4.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
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
        if (onBackPressed != null)
          GestureDetector(
            onTap: onBackPressed ?? () => Get.back(),
            child: SvgPicture.asset(
              'assets/icons/backarrow.svg',
              color: AppColors.buttonprimary,
            ),
          ),
        if (onBackPressed != null) const SizedBox(width: 16),
        Expanded(
          child: Text(
            pageTitle ?? 'Page',
            style: const TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ).copyWith(color: AppColors.buttonprimary),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Trailing widget (optional)
        if (trailingWidget != null)
          GestureDetector(onTap: onTrailingPressed, child: trailingWidget!),
      ],
    );
  }

  // Helper method to get greeting based on time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 17) {
      return 'Good afternoon!';
    } else if (hour < 21) {
      return 'Good evening!';
    } else {
      return 'Good night!';
    }
  }
}
