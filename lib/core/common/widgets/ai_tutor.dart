import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiTutorCard extends StatelessWidget {
  const AiTutorCard({super.key});

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
                  'AI Tutor Ready!',
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
                  'I’m here to help you learn something new today! ',
                  maxLines: 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                CustomElevatedButton(
                  width: MediaQuery.of(context).size.width * .4,
                  leadingIcon: Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  ),
                  text: 'Start Learning',
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
