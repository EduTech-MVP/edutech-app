import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoTutorialScreen extends StatelessWidget {
  final Lesson lesson;

  const VideoTutorialScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.witharrow(
          pageTitle: 'Video Turorial',
          onBackPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock Video Player Area
              Stack(
                clipBehavior: Clip.none,

                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 265,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),

                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lesson ${lesson.id}: ${lesson.title}',
                          style: AppTypography.heading4,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Learn the fundamentals step by step',
                          style: AppTypography.paragrah,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
