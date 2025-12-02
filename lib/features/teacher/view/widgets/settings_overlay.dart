import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/view/widgets/lesson_input_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void showSettingsOverlay({
  required BuildContext context,
  required bool hasVideoUrl,
  required String? videoUrl,
  required Function(String) onVideoUrlUpdate,
}) {
  Get.dialog(
    SettingsOverlay(
      hasVideoUrl: hasVideoUrl,
      videoUrl: videoUrl,
      onVideoUrlUpdate: onVideoUrlUpdate,
    ),
    barrierDismissible: true,
  );
}

class SettingsOverlay extends StatelessWidget {
  final bool hasVideoUrl;
  final String? videoUrl;
  final Function(String) onVideoUrlUpdate;

  const SettingsOverlay({
    super.key,
    required this.hasVideoUrl,
    this.videoUrl,
    required this.onVideoUrlUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderMedium, width: 1),
          boxShadow: [AppColors.shadowMedium],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Settings', style: AppTypography.heading2),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/close.svg',
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          AppColors.foreground,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Video URL option with differentiated color
              Container(
                decoration: BoxDecoration(
                  color: AppColors
                      .background, // A light blue background for prominence
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: SvgPicture.asset(
                    'assets/icons/play.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.foreground, // Make the icon blue for visibility
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    hasVideoUrl ? 'Edit Video URL' : 'Add Video URL',
                    style: AppTypography.paragrah.copyWith(
                      color: AppColors.foreground, // Make the text blue as well
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    showLessonInputOverlay(
                      context: context,
                      type: hasVideoUrl
                          ? LessonInputType.editVideoUrl
                          : LessonInputType.addVideoUrl,
                      initialValue: videoUrl,
                      onSave: onVideoUrlUpdate,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
