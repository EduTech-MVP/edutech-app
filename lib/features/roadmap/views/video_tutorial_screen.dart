import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoTutorialScreen extends StatelessWidget {
  final Lesson lesson;

  const VideoTutorialScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1FCFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary400),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Video Tutorial',
          style: AppTypography.heading3.copyWith(color: AppColors.primary400),
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
                    // padding: const EdgeInsets.all(20),
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

                  // const SizedBox(height: 20),
                  // Lesson Description Card
                ],
              ),
            ],
          ),
        ),
      ),
      //  bottomNavigationBar: const BottomNavBar(),
    );
  }
}
