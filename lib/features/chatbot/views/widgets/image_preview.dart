import 'dart:io';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pendingImage = context.select<ChatController, XFile?>(
      (c) => c.pendingImage,
    );

    if (pendingImage == null) return const SizedBox.shrink();

    return _ImagePreviewContent(image: pendingImage);
  }
}

class _ImagePreviewContent extends StatefulWidget {
  final XFile image;
  const _ImagePreviewContent({required this.image});

  @override
  State<_ImagePreviewContent> createState() => _ImagePreviewContentState();
}

class _ImagePreviewContentState extends State<_ImagePreviewContent> {
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final controller = context.read<ChatController>();
    controller.sendImageMessage(_captionController.text);
    _captionController.clear();
  }

  void _handleCancel() {
    context.read<ChatController>().cancelImagePreview();
    _captionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [AppColors.shadowLarge],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Send Image",
                  style: AppTypography.heading4.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _handleCancel,
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// ⭐ Scrollable area when keyboard shows
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _DynamicImagePreview(
                      imagePath: widget.image.path,
                      keyboardVisible: keyboardVisible,
                    ),

                    const SizedBox(height: 12),

                    /// Caption input
                    TextField(
                      controller: _captionController,
                      maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Add a caption...",
                        hintStyle: AppTypography.small.copyWith(
                          color: AppColors.neutral500,
                        ),
                        filled: true,
                        fillColor: AppColors.neutral100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      style: AppTypography.small,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            /// Fixed bottom send button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonprimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Send Image",
                      style: AppTypography.small.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dynamic preview that shrinks when keyboard appears
class _DynamicImagePreview extends StatelessWidget {
  final String imagePath;
  final bool keyboardVisible;

  const _DynamicImagePreview({
    required this.imagePath,
    required this.keyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final maxHeight = keyboardVisible
        ? screenHeight * 0.18
        : screenHeight * 0.38;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight, minHeight: 80),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(imagePath),
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
