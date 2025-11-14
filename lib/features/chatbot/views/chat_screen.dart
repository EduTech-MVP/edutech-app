// ignore_for_file: deprecated_member_use
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/views/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();

    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.screen(
          pageTitle: 'Ai tutor',
          trailingWidget: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.neutral300),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.sky200, AppColors.primary50],
              ),
            ),
            child: Text(
              'Chat Mode',
              style: AppTypography.small.copyWith(color: AppColors.sky700),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(18),

              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return ChatBubbleWidget(message: message);
              },
            ),
          ),
          if (controller.isLoading) const LinearProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            cursorHeight: 18,
                            cursorColor: AppColors.neutral500,
                            controller: _controller,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: AppTypography.small.copyWith(
                                color: AppColors.neutral500,
                              ),
                              contentPadding: EdgeInsets.only(left: 16),
                              hintText: "Type a message...",
                              border: buildBorder(),
                              enabledBorder: buildBorder(),
                              focusedBorder: buildBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          controller.sendMessage(_controller.text);
                          _controller.clear();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.buttonprimary,
                            border: Border.all(color: Colors.grey),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/send.svg',
                            height: 32,
                            width: 32,
                            color: Colors.white,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      topRight: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
    borderSide: BorderSide(
      width: AppSpacing.radiusXS * .7,
      color: AppColors.neutral300,
    ),
  );
}
