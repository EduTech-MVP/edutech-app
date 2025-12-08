import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MessageInputField extends StatelessWidget {
  final Function(String) onSend;
  final bool isLoading;

  const MessageInputField({
    super.key,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return _MessageInputContent(onSend: onSend, isLoading: isLoading);
  }
}

class _MessageInputContent extends StatefulWidget {
  final Function(String) onSend;
  final bool isLoading;

  const _MessageInputContent({required this.onSend, required this.isLoading});

  @override
  State<_MessageInputContent> createState() => _MessageInputContentState();
}

class _MessageInputContentState extends State<_MessageInputContent> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (_hasText != hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.isLoading) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  void _handleCamera() {
    _showImageSourceBottomSheet(context);
  }

  void _handleRecord() {
    // TODO: Implement voice recording
    debugPrint('Voice recording tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !widget.isLoading,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              cursorHeight: 18,
              cursorColor: AppColors.neutral500,
              style: AppTypography.bodymedium,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintStyle: AppTypography.bodymedium.copyWith(
                  color: AppColors.neutral500,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                hintText: "Type a message...",

                border: _buildBorder(),
                enabledBorder: _buildBorder(),
                focusedBorder: _buildBorder(),
                suffixIcon: !_hasText
                    ? _CameraButton(onTap: _handleCamera)
                    : null,
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          const SizedBox(width: 8),
          _SendButton(
            hasText: _hasText,
            onTap: _hasText ? _handleSend : _handleRecord,
          ),
        ],
      ),
    );
  }

  static OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      borderSide: BorderSide(
        width: AppSpacing.radiusXS * 0.1,
        color: AppColors.neutral300,
      ),
    );
  }
}

/// Camera button widget
class _CameraButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CameraButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/cam.svg',
        color: AppColors.neutral500,
        width: 12,
        height: 12,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}

/// Send/Record button widget
class _SendButton extends StatelessWidget {
  final bool hasText;
  final VoidCallback onTap;

  const _SendButton({required this.hasText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.buttonprimary,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: hasText
            ? SvgPicture.asset(
                'assets/icons/send.svg',
                height: 32,
                width: 32,
                fit: BoxFit.scaleDown,
              )
            : SvgPicture.asset(
                'assets/icons/recored.svg',
                height: 40,
                width: 40,
                fit: BoxFit.scaleDown,
              ),
      ),
    );
  }
}

/// Show image source bottom sheet
void _showImageSourceBottomSheet(BuildContext context) {
  final controller = context.read<ChatController>();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _ImageSourceTile(
              icon: 'assets/icons/cam.svg',
              title: 'Take Photo',
              onTap: () {
                Navigator.pop(context);
                controller.takePhotoForPreview();
              },
            ),
            const Divider(height: 1),
            _ImageSourceTile(
              icon: 'assets/icons/star.svg',
              title: 'Choose from Gallery',
              onTap: () {
                Navigator.pop(context);
                controller.pickImageForPreview();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

/// Image source tile widget
class _ImageSourceTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const _ImageSourceTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon, color: AppColors.primary),
      title: Text(
        title,
        style: AppTypography.bodyxs.copyWith(
          fontSize: 16,
          color: AppColors.primary,
        ),
      ),
      onTap: onTap,
    );
  }
}
