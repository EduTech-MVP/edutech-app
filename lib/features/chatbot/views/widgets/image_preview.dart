import 'dart:io';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

    // Show full-screen preview
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => _FullScreenImagePreview(image: pendingImage),
        ),
      );
    });

    return const SizedBox.shrink();
  }
}

class _FullScreenImagePreview extends StatefulWidget {
  final XFile image;
  const _FullScreenImagePreview({required this.image});

  @override
  State<_FullScreenImagePreview> createState() =>
      _FullScreenImagePreviewState();
}

class _FullScreenImagePreviewState extends State<_FullScreenImagePreview> {
  final TextEditingController _captionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _captionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    final controller = context.read<ChatController>();
    controller.sendImageMessage(_captionController.text);
    _captionController.clear();
    Navigator.of(context).pop();
  }

  void _handleCancel() {
    context.read<ChatController>().cancelImagePreview();
    _captionController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full-screen image
          Positioned.fill(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: Image.file(File(widget.image.path), fit: BoxFit.contain),
              ),
            ),
          ),

          // Top bar with close button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _handleCancel,
                    ),
                    const Spacer(),
                    // Optional: Add more actions here (crop, edit, etc.)
                  ],
                ),
              ),
            ),
          ),

          // Bottom bar with caption and send button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Caption input
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _captionController,
                            focusNode: _focusNode,
                            maxLines: 4,
                            minLines: 1,
                            style: const TextStyle(
                              color: AppColors.onBackground,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: "Add a caption...",
                              hintStyle: TextStyle(
                                color: AppColors.neutral900,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Send button
                      GestureDetector(
                        onTap: _handleSend,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.buttonprimary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.buttonprimary.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
