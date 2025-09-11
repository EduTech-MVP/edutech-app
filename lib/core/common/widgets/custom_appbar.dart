import 'dart:ui';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  // Page AppBar - shows title with back arrow
  const CustomAppbar.page({
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
            color: Colors.white.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
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
    return Row(
      children: [
        // Profile avatar
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.06,
          backgroundColor: AppColors.sky100,
          child: Icon(
            Icons.person,
            color: AppColors.sky600,
            size: MediaQuery.of(context).size.width * 0.08,
          ),
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
                'Maryam Abdallah',
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
        // Back arrow
        GestureDetector(
          onTap: onBackPressed ?? () => Navigator.pop(context),
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/backarrow.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                AppColors.neutral800,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Page title
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
