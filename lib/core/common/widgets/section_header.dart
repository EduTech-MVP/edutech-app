import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? icon;
  final String? actionButtonText;
  final VoidCallback? onActionPressed;
  final Widget child;
  final bool showViewAll;
  final bool useElevatedButton;

  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.actionButtonText,
    this.onActionPressed,
    required this.child,
    this.showViewAll = true,
    this.useElevatedButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// LEFT SIDE → icon + title
            Expanded(
              child: Row(
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppSpacing.spacing4),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: AppTypography.heading1.copyWith(fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            /// RIGHT SIDE → action button
            if (showViewAll && actionButtonText != null)
              useElevatedButton
                  ? CustomElevatedButton(
                      text: actionButtonText!,
                      onTap: onActionPressed ?? () {},
                      width: 135,
                      leadingIcon: Icon(Icons.add, color: AppColors.sky50),
                    )
                  : TextButton(
                      onPressed: onActionPressed,
                      child: Row(
                        children: [
                          Text(
                            actionButtonText!,
                            style: AppTypography.paragrah.copyWith(
                              color: AppColors.sky800,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.spacing4),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: AppColors.sky800,
                          ),
                        ],
                      ),
                    ),
          ],
        ),

        const SizedBox(height: 16),

        /// CHILD
        child,
      ],
    );
  }
}
