import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/features/roadmap/controller/lesson_provider.dart';
import 'package:edutech_app/features/roadmap/views/widgets/lesson_node.dart';
import 'package:edutech_app/features/roadmap/views/widgets/lesson_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RoadmapScreen extends StatelessWidget {
  final String subjectName;
  const RoadmapScreen({super.key, this.subjectName = 'math'});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.witharrow(
          onBackPressed: () => Get.back(),
          pageTitle: subjectName,
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Consumer<LessonProvider>(
              builder: (consumerContext, provider, child) {
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  itemCount: provider.lessons.length,
                  itemBuilder: (itemBuilderContext, index) {
                    final lesson = provider.lessons[index];

                    return LessonNode(
                      lesson: lesson,
                      index: index,
                      onTap: () {
                        if (lesson.isActive && !lesson.isCompleted) {
                          showLessonOverlay(consumerContext, lesson);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
