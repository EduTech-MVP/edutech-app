import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/models/messege.dart';
import 'package:edutech_app/features/chatbot/views/widgets/chat_bubble.dart';
import 'package:edutech_app/features/chatbot/views/widgets/chat_message_shimmer.dart';
import 'package:edutech_app/features/chatbot/views/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoadingHistory = context.select<ChatController, bool>(
      (controller) => controller.isLoadingHistory,
    );

    if (isLoadingHistory) {
      return const ChatMessagesShimmer();
    }

    return const _MessagesList();
  }
}

class _MessagesList extends StatefulWidget {
  const _MessagesList();

  @override
  State<_MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<_MessagesList> {
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final isAtBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100;

    context.read<ChatController>().updateScrollButtonVisibility(!isAtBottom);
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.select<ChatController, List<Message>>(
      (controller) => controller.messages,
    );

    final isBotTyping = context.select<ChatController, bool>(
      (controller) => controller.isBotTyping,
    );

    final showScrollButton = context.select<ChatController, bool>(
      (controller) => controller.showScrollButton,
    );

    _handleMessageUpdate(messages.length);

    if (messages.isEmpty) {
      return const _EmptyState();
    }

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(18),
          itemCount: messages.length + (isBotTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (isBotTyping && index == messages.length) {
              return const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: TypingIndicator(),
              );
            }

            final message = messages[index];
            return ChatBubbleWidget(
              key: ValueKey('message_${message.text}_$index'),
              message: message,
            );
          },
        ),
        if (showScrollButton && messages.isNotEmpty)
          _ScrollToBottomButton(onTap: _scrollToBottom),
      ],
    );
  }

  void _handleMessageUpdate(int currentCount) {
    if (currentCount != _previousMessageCount) {
      final isLoadingHistory = _previousMessageCount == 0 && currentCount > 0;
      _previousMessageCount = currentCount;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) return;

        if (isLoadingHistory) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        } else {
          final isNearBottom =
              _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200;

          if (isNearBottom || currentCount == 1) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        }
      });
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

/// Empty state widget
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Start a conversation',
        style: AppTypography.small.copyWith(color: AppColors.neutral500),
      ),
    );
  }
}

/// Scroll to bottom button
class _ScrollToBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ScrollToBottomButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: MediaQuery.of(context).size.width * 0.5 - 16,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.funsky),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Icon(
            Icons.arrow_drop_down_rounded,
            size: 32,
            color: AppColors.funsky,
          ),
        ),
      ),
    );
  }
}
