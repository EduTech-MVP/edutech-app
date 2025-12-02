import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/models/messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ChatBubbleWidget extends StatelessWidget {
  final Message message;

  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: message.isBot
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        if (message.isBot) ...[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: const _BotAvatar(),
          ),
          const SizedBox(width: 8),
        ],
        message.isBot
            ? _BotMessageBubble(message: message)
            : _UserMessageBubble(message: message),
      ],
    );
  }
}

//AVATAR WIDGETS

// Bot avatar
class _BotAvatar extends StatelessWidget {
  const _BotAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: AppGradients.card,
      ),
      child: SvgPicture.asset(
        'assets/icons/bot.svg',
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        fit: BoxFit.none,
        width: 12,
        height: 12,
      ),
    );
  }
}

/// User avatar
class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserProvider, dynamic>((p) => p.profile);
    final hasImage =
        user?.profileImageUrl != null && user!.profileImageUrl!.isNotEmpty;

    return CircleAvatar(
      radius: 18,
      backgroundImage: hasImage ? NetworkImage(user!.profileImageUrl!) : null,
      child: !hasImage
          ? Text(
              user?.firstName?.isNotEmpty == true
                  ? user!.firstName![0].toUpperCase()
                  : 'U',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.sky700,
              ),
            )
          : null,
    );
  }
}

//  MESSAGE BUBBLE WIDGETS

/// Bot message bubble
class _BotMessageBubble extends StatelessWidget {
  final Message message;

  const _BotMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MessageBubble(
            message: message,
            isBot: true,
            backgroundColor: AppColors.background,
            borderColor: AppColors.neutral200,
          ),
          if (message.choices != null && message.choices!.isNotEmpty)
            _ChoicesWidget(choices: message.choices!),
        ],
      ),
    );
  }
}

/// User message bubble
class _UserMessageBubble extends StatelessWidget {
  final Message message;

  const _UserMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.centerRight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _MessageBubble(
              message: message,
              isBot: false,
              backgroundColor: const Color(0xffDDF5F7),
              borderColor: AppColors.funmint,

              rightMargin: 42,
            ),
            const Positioned(top: 8, right: -2, child: _UserAvatar()),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isBot;
  final Color backgroundColor;
  final Color borderColor;
  final double rightMargin;

  const _MessageBubble({
    required this.message,
    required this.isBot,
    required this.backgroundColor,
    required this.borderColor,
    this.rightMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: rightMargin),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: _getBorderRadius(),
        boxShadow: [AppColors.shadowMedium],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * (isBot ? 0.7 : 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: _MessageContent(message: message),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    return isBot
        ? const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(20),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );
  }
}

/// Message content text , image
class _MessageContent extends StatelessWidget {
  final Message message;

  const _MessageContent({required this.message});

  @override
  Widget build(BuildContext context) {
    final hasImage = message.imageUrl != null && message.imageUrl!.isNotEmpty;
    final showText = message.text != '[Image]';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (hasImage)
          Padding(
            padding: EdgeInsets.only(bottom: showText ? 8 : 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _MessageImage(imageUrl: message.imageUrl!),
            ),
          ),
        if (showText)
          Text(
            message.text,
            style: const TextStyle(fontSize: 16),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
      ],
    );
  }
}

// IMAGE WIDGETS

///  image handler (network or local)
class _MessageImage extends StatelessWidget {
  final String imageUrl;

  const _MessageImage({required this.imageUrl});

  bool get _isNetworkImage =>
      imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        maxHeight: 300,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.neutral200,
      ),
      clipBehavior: Clip.antiAlias,
      child: _isNetworkImage
          ? _NetworkImage(url: imageUrl)
          : _LocalImage(path: imageUrl),
    );
  }
}

/// Network image with loading and error states
class _NetworkImage extends StatelessWidget {
  final String url;

  const _NetworkImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _LoadingIndicator(progress: loadingProgress);
      },
      errorBuilder: (_, __, ___) => const _ImageErrorPlaceholder(),
    );
  }
}

/// Local file image with error handling
class _LocalImage extends StatelessWidget {
  final String path;

  const _LocalImage({required this.path});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: File(path).exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _LoadingIndicator();
        }

        if (snapshot.hasData && snapshot.data == true) {
          return Image.file(
            File(path),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _ImageErrorPlaceholder(),
          );
        }

        return const _ImageErrorPlaceholder(message: 'Image expired');
      },
    );
  }
}

/// Loading indicator for images
class _LoadingIndicator extends StatelessWidget {
  final ImageChunkEvent? progress;

  const _LoadingIndicator({this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: CircularProgressIndicator(
          value: progress != null && progress!.expectedTotalBytes != null
              ? progress!.cumulativeBytesLoaded / progress!.expectedTotalBytes!
              : null,
          color: AppColors.buttonprimary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

/// Error placeholder for failed images
class _ImageErrorPlaceholder extends StatelessWidget {
  final String message;

  const _ImageErrorPlaceholder({this.message = 'Image unavailable'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTypography.small.copyWith(
              color: AppColors.neutral500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

//   CHOICES WIDGETS

/// Message choices/suggestions
class _ChoicesWidget extends StatelessWidget {
  final List<String> choices;

  const _ChoicesWidget({required this.choices});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 8, bottom: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: choices.map((choice) => _ChoiceChip(choice: choice)).toList(),
      ),
    );
  }
}

/// Individual choice chip button
class _ChoiceChip extends StatelessWidget {
  final String choice;

  const _ChoiceChip({required this.choice});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ChatController>();

    return GestureDetector(
      onTap: () => controller.sendMessage(choice),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.sky200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.sky300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          choice,
          style: AppTypography.small.copyWith(
            color: AppColors.sky700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
