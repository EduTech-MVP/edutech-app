import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_lesson_details_controller.dart';
import 'package:edutech_app/features/teacher/model/lesson_model.dart';
import 'package:edutech_app/features/teacher/view/widgets/settings_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TeacherVideoTutorialScreen extends StatelessWidget {
  final TeacherLesson lesson;
  final int classId;

  const TeacherVideoTutorialScreen({
    super.key,
    required this.lesson,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return TeacherVideoTutorialView(
      classId: classId,
      lessonId: lesson.id,
      lesson: lesson,
    );
  }
}

class TeacherVideoTutorialView extends StatefulWidget {
  final int classId;
  final int lessonId;
  final TeacherLesson lesson;

  const TeacherVideoTutorialView({
    super.key,
    required this.classId,
    required this.lessonId,
    required this.lesson,
  });

  @override
  State<TeacherVideoTutorialView> createState() =>
      _TeacherVideoTutorialViewState();
}

class _TeacherVideoTutorialViewState extends State<TeacherVideoTutorialView> {
  YoutubePlayerController? _controller;
  bool _isClosing = false;

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleBack() {
    setState(() {
      _isClosing = true;
    });
    _controller?.pause();

    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) Get.back();
    });
  }

  void _showSettingsMenu() {
    final provider = context.read<TeacherLessonDetailsController>();
    final hasVideoUrl =
        provider.videoUrl != null && provider.videoUrl!.isNotEmpty;

    showSettingsOverlay(
      context: context,
      hasVideoUrl: hasVideoUrl,
      videoUrl: provider.videoUrl,
      onVideoUrlUpdate: (url) async {
        await provider.updateVideoUrl(url);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeacherLessonDetailsController>().loadLessonDetails(
        widget.classId,
        widget.lessonId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack();
      },
      child: GradientScaffold.main(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).padding.top * 2.5,
          ),
          child: CustomAppbar.witharrow(
            pageTitle: 'Video Tutorial',
            onBackPressed: _handleBack,
            trailingWidget: GestureDetector(
              onTap: _showSettingsMenu,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderMedium, width: 1),
                  boxShadow: [AppColors.shadowMedium],
                ),
                child: Center(
                  child: Icon(
                    Icons.settings,
                    color: AppColors.foreground,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Consumer<TeacherLessonDetailsController>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: VideoTutorialShimmer());
            }

            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }

            if (provider.videoUrl == null || provider.videoUrl!.isEmpty) {
              return const Center(
                child: Text("No video available for this lesson"),
              );
            }

            if (_controller == null) {
              final videoId =
                  YoutubePlayer.convertUrlToId(provider.videoUrl!) ?? '';
              _controller = YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                  enableCaption: true,
                  controlsVisibleAtStart: true,
                  forceHD: false,
                ),
              );
            }

            final lessonTitle =
                'Lesson ${widget.lessonId}: ${widget.lesson.title}';

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.borderMedium,
                          width: 1,
                        ),
                        boxShadow: [AppColors.shadowLarge],
                      ),
                      child: Column(
                        children: [
                          // Video Player Widget
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            child: _isClosing
                                ? Container(
                                    width: double.infinity,
                                    height: 261,
                                    color: const Color(0xFF18181B),
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    height: 261,
                                    child: YoutubePlayer(
                                      controller: _controller!,
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: const Color(
                                        0xFF28B0F4,
                                      ),
                                    ),
                                  ),
                          ),

                          // Text Content
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lessonTitle,
                                  style: AppTypography.heading3,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Learn the fundamentals step by step',
                                  style: AppTypography.bodysmall.copyWith(
                                    color: AppColors.neutral400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
