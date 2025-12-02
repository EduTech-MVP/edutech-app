import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/views/widgets/answer_option.dart';
import 'package:edutech_app/features/roadmap/views/widgets/home_work_buttons.dart';
import 'package:edutech_app/features/teacher/controller/teacher_lesson_details_controller.dart';
import 'package:edutech_app/features/teacher/model/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TeacherHomeworkScreen extends StatelessWidget {
  final TeacherLesson lesson;
  final int classId;

  const TeacherHomeworkScreen({
    super.key,
    required this.lesson,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return TeacherHomeworkView(classId: classId, lessonId: lesson.id);
  }
}

class TeacherHomeworkView extends StatefulWidget {
  final int classId;
  final int lessonId;

  const TeacherHomeworkView({
    super.key,
    required this.classId,
    required this.lessonId,
  });

  @override
  State<TeacherHomeworkView> createState() => _TeacherHomeworkViewState();
}

class _TeacherHomeworkViewState extends State<TeacherHomeworkView> {
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

  void _finishHomework(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.witharrow(
          pageTitle: 'Homework',
          onBackPressed: () => Get.back(),
        ),
      ),
      body: Consumer<TeacherLessonDetailsController>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: HomeworkShimmer());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                provider.errorMessage!,
                style: AppTypography.paragrah,
              ),
            );
          }

          if (provider.questions.isEmpty) {
            return const Center(child: Text("No homework questions found."));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress
                  const SizedBox(height: 8),
                  Text(
                    '${provider.currentQuestionIndex + 1}/${provider.totalQuestions}',
                    style: AppTypography.small.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: provider.progress,
                      backgroundColor: AppColors.background,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary500,
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Question Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [AppColors.shadowLarge],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.neutral200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.currentQuestion.text,
                          style: AppTypography.heading3.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'choose the correct answer',
                          style: AppTypography.small.copyWith(
                            color: AppColors.neutral400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Options List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      return AnswerOption(
                        option: provider.currentQuestion.options[index],
                        index: index,
                        isSelected: provider.selectedAnswer == index,
                        isCorrect:
                            index == provider.currentQuestion.correctAnswer,
                        showResult: provider.isAnswered,
                        onTap: provider.isAnswered
                            ? null
                            : () => provider.selectAnswer(index),
                      );
                    },
                  ),

                  // Buttons
                  if (!provider.isAnswered)
                    SubmitButton(
                      isEnabled: provider.selectedAnswer != null,
                      onPressed: provider.submitAnswer,
                    )
                  else if (provider.currentQuestionIndex <
                      provider.totalQuestions - 1)
                    NextButton(onPressed: provider.nextQuestion)
                  else
                    FinishButton(onPressed: () => _finishHomework(context)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
