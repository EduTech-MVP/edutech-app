import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/models/messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Message message;

  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ChatController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: message.isBot
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        if (message.isBot) ...[
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blueAccent,
            child: SvgPicture.asset(
              'assets/icons/bot.svg',
              color: Colors.white,
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 8),
        ],
        //chat bubble
        if (message.isBot)
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //bot chat bubble
                ChatBubble(
                  clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10),
                  backGroundColor: AppColors.sky100,
                  child: Text(
                    message.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //choices
                if (message.choices != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 8,
                      bottom: 12,
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: message.choices!.map((choice) {
                        return GestureDetector(
                          onTap: () => controller.sendMessage(choice),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.sky200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3), // shadow position
                                ),
                              ],
                            ),
                            child: Text(
                              choice,
                              style: AppTypography.small.copyWith(
                                color: AppColors.sky700,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          )
        else
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ChatBubble(
                  clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 10, right: 42),
                  backGroundColor: AppColors.sky200,
                  child: Text(
                    message.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    child: SvgPicture.asset(''),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
