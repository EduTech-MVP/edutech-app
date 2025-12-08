import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/controller/lesson_details_provider.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTutorialScreen extends StatelessWidget {
  final Lesson lesson;
  final int classId;

  const VideoTutorialScreen({
    super.key,
    required this.lesson,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LessonDetailsProvider(apiConsumer: DioConsumer(dio: Dio()))
            ..loadLessonDetails(classId, lesson.id),
      child: const VideoTutorialView(),
    );
  }
}

class VideoTutorialView extends StatefulWidget {
  const VideoTutorialView({super.key});

  @override
  State<VideoTutorialView> createState() => _VideoTutorialViewState();
}

class _VideoTutorialViewState extends State<VideoTutorialView> {
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
          ),
        ),
        body: Consumer<LessonDetailsProvider>(
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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Background Card
                        Container(
                          padding: const EdgeInsets.only(
                            top: 220,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [AppColors.shadowLarge],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Watch Lesson',
                                style: AppTypography.heading3,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Learn the fundamentals step by step',
                                style: AppTypography.bodysmall.copyWith(
                                  color: AppColors.mutedforeground,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Video Player Widget
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _isClosing
                              ? Container(
                                  height: 200,
                                  color: Colors.black,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                )
                              : YoutubePlayer(
                                  controller: _controller!,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: const Color(
                                    0xFF28B0F4,
                                  ),
                                ),
                        ),
                      ],
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
