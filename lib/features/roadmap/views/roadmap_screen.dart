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
    return Scaffold(
      backgroundColor: Color(0xffF1FcFD),
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4FC3F7)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          subjectName,
          style: TextStyle(
            color: Color(0xFF4FC3F7),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF5F9FC),
              child: Consumer<LessonProvider>(
                // Renaming context to consumerContext to clearly indicate it has the provider
                builder: (consumerContext, provider, child) {
                  return ListView.builder(
                    reverse:
                        true, // Scroll from bottom to top (Lesson 1 is at bottom)
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    itemCount: provider.lessons.length,
                    itemBuilder: (itemBuilderContext, index) {
                      final lesson = provider.lessons[index];

                      return LessonNode(
                        lesson: lesson,
                        index: index,
                        totalLessons: provider.lessons.length,
                        onTap: () {
                          if (lesson.isActive && !lesson.isCompleted) {
                            // FIX: Pass the consumerContext which is guaranteed
                            // to have the LessonProvider registered above it for context.read().
                            showLessonOverlay(consumerContext, lesson);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
