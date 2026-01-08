import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AiTutorCard extends StatelessWidget {
  final String headerText;
  final String contentText;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const AiTutorCard({
    super.key,
    required this.headerText,
    required this.buttonText,
    required this.contentText,
    this.onButtonPressed,
  });

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
            colorFilter: ColorFilter.mode(
              AppColors.background,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerText,
                  //'AI Tutor Ready!',
                  style: AppTypography.heading1.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  style: AppTypography.subtle.copyWith(
                    height: 1.5,
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                  contentText,
                  //  'I’m here to help you learn something new today! ',
                  maxLines: 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                CustomElevatedButton(
                  width: MediaQuery.of(context).size.width * .4,
                  leadingIcon: Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  ),
                  text: buttonText,
                  // 'Start Learning',
                  onTap: onButtonPressed ??
                      () {
                        final controller = context.read<ChatController>();
                        controller.createNewSession();
                        Get.to(() => const ChatScreen());
                      },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
