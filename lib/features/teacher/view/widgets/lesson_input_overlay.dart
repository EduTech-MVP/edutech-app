import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_gradient.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum LessonInputType { addTitle, editVideoUrl, addVideoUrl }

void showLessonInputOverlay({
  required BuildContext context,
  required LessonInputType type,
  String? initialValue,
  required Function(String) onSave,
}) {
  Get.dialog(
    LessonInputOverlay(type: type, initialValue: initialValue, onSave: onSave),
    barrierDismissible: true,
  );
}

class LessonInputOverlay extends StatefulWidget {
  final LessonInputType type;
  final String? initialValue;
  final Function(String) onSave;

  const LessonInputOverlay({
    super.key,
    required this.type,
    this.initialValue,
    required this.onSave,
  });

  @override
  State<LessonInputOverlay> createState() => _LessonInputOverlayState();
}

class _LessonInputOverlayState extends State<LessonInputOverlay> {
  late TextEditingController _controller;
  bool _isLoading = false;

  String get _title {
    switch (widget.type) {
      case LessonInputType.addTitle:
        return 'Add Lesson';
      case LessonInputType.editVideoUrl:
        return 'Edit Video URL';
      case LessonInputType.addVideoUrl:
        return 'Add Video URL';
    }
  }

  String get _inputLabel {
    switch (widget.type) {
      case LessonInputType.addTitle:
        return 'Lesson Title';
      case LessonInputType.editVideoUrl:
      case LessonInputType.addVideoUrl:
        return 'Video URL';
    }
  }

  String get _placeholder {
    switch (widget.type) {
      case LessonInputType.addTitle:
        return 'Enter a title for the lesson';
      case LessonInputType.editVideoUrl:
      case LessonInputType.addVideoUrl:
        return 'Enter the video URL';
    }
  }

  String get _buttonText {
    switch (widget.type) {
      case LessonInputType.addTitle:
        return 'Add Lesson';
      case LessonInputType.editVideoUrl:
        return 'Save Changes';
      case LessonInputType.addVideoUrl:
        return 'Add Video';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a value',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onSave(value);
      if (mounted) {
        Get.back();
        Get.snackbar(
          'Success',
          'Video URL ${widget.type == LessonInputType.addVideoUrl ? "added" : "updated"} successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = e is ServerException
            ? (e.errorModel.errorMessage ?? 'Failed to save')
            : 'Failed to save: ${e.toString()}';
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.borderMedium, width: 1),
      ),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(_title, style: AppTypography.heading2)),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Input field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _inputLabel,
                style: AppTypography.bodysmall.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: _controller,
                hintText: _placeholder,
                fillColor: AppColors.background,
                keyboardType: widget.type == LessonInputType.addTitle
                    ? TextInputType.text
                    : TextInputType.url,
                onChanged: (value) {
                  // Allow real-time updates if needed
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Save button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: _isLoading ? null : _handleSave,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: AppGradients.iconBlue,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [AppColors.shadowMedium],
                ),
                alignment: Alignment.center,
                child: _isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        _buttonText,
                        style: AppTypography.heading4.copyWith(
                          color: Colors.white,
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
