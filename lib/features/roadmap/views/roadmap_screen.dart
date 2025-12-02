import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/features/roadmap/controller/lessons_provider.dart';
import 'package:edutech_app/features/roadmap/views/widgets/lesson_node.dart';
import 'package:edutech_app/features/roadmap/views/widgets/lesson_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';

class RoadmapScreen extends StatelessWidget {
  final String subjectName;
  final int classId;

  const RoadmapScreen({
    super.key,
    this.subjectName = 'Subject',
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = LessonProvider(apiConsumer: DioConsumer(dio: Dio()));
        controller.loadLessons(6);
        return controller;
      },
      child: GradientScaffold.main(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).padding.top * 2.5,
          ),
          child: CustomAppbar.witharrow(
            onBackPressed: () => Get.back(),
            pageTitle: subjectName,
          ),
        ),
        body: Consumer<LessonProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const RoadmapShimmer();
            }

            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 40),
              itemCount: provider.lessons.length,
              itemBuilder: (context, index) {
                final lesson = provider.lessons[index];

                return LessonNode(
                  lesson: lesson,
                  index: index,
                  onTap: () {
                    if (!lesson.isLocked) {
                      showLessonOverlay(context, lesson, classId);
                    } else {
                      Get.snackbar("Locked", "Complete previous lessons first");
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
