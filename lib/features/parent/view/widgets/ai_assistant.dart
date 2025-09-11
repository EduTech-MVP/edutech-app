import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiAssistantCard extends StatelessWidget {
  const AiAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: EdgeInsets.all(AppSpacing.inputPaddingLarge),
      gradient: AppGradients.card,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/bot.svg',
            height: AppSpacing.iconXXXL,
            colorFilter: ColorFilter.mode(AppColors.sky500, BlendMode.srcIn),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: AppTypography.heading4.copyWith(
                    color: AppColors.sky700,
                  ),
                ),
                Text(
                  style: AppTypography.subtle.copyWith(
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  'Get insights about your children’s learning progress! ',
                  maxLines: 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                CustomElevatedButton(
                  width: MediaQuery.of(context).size.width * .4,
                  leadingIcon: SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: 'Get Insights',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
