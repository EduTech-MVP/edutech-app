import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/views/widgets/chat_messege_list.dart';
import 'package:edutech_app/features/chatbot/views/widgets/history_slide.dart';
import 'package:edutech_app/features/chatbot/views/widgets/image_preview.dart';
import 'package:edutech_app/features/chatbot/views/widgets/message_inputfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChatScreenContent();
  }
}

class _ChatScreenContent extends StatelessWidget {
  const _ChatScreenContent();

  @override
  Widget build(BuildContext context) {
    final showHistory = context.select<ChatController, bool>(
      (controller) => controller.showHistory,
    );

    final showImagePreview = context.select<ChatController, bool>(
      (controller) => controller.showImagePreview,
    );

    final isLoading = context.select<ChatController, bool>(
      (controller) => controller.isLoading,
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.75;

    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: showHistory ? -drawerWidth : 0,
          right: showHistory ? drawerWidth : 0,
          top: 0,
          bottom: 0,
          child: _MainChatContent(
            showImagePreview: showImagePreview,
            isLoading: isLoading,
          ),
        ),

        // History Drawer
        HistoryDrawer(
          isOpen: showHistory,
          onClose: () => context.read<ChatController>().closeHistory(),
        ),

        // Backdrop overlay
        if (showHistory)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: 0,
            right: drawerWidth,
            top: 0,
            bottom: 0,
            child: _BackdropOverlay(
              onTap: () => context.read<ChatController>().closeHistory(),
            ),
          ),
      ],
    );
  }
}

/// Main chat content
class _MainChatContent extends StatelessWidget {
  final bool showImagePreview;
  final bool isLoading;

  const _MainChatContent({
    required this.showImagePreview,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.witharrow(
          onBackPressed: () => Get.back(),
          pageTitle: 'AI Tutor',
          trailingWidget: _HistoryButton(
            onTap: () => context.read<ChatController>().toggleHistory(),
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatMessagesList()),

          if (isLoading) const LinearProgressIndicator(),

          if (showImagePreview) const ImagePreviewWidget(),

          if (!showImagePreview)
            MessageInputField(
              onSend: (text) =>
                  context.read<ChatController>().sendMessage(text),
              isLoading: isLoading,
            ),
        ],
      ),
    );
  }
}

class _HistoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const _HistoryButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.more_vert, color: AppColors.neutral700),
    );
  }
}

class _BackdropOverlay extends StatelessWidget {
  final VoidCallback onTap;

  const _BackdropOverlay({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(color: Colors.black.withOpacity(0.1)),
    );
  }
}
