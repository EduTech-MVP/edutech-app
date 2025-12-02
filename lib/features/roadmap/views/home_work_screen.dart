import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/shimmer_loader_helper.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/views/chat_screen.dart';
import 'package:edutech_app/features/roadmap/controller/lesson_details_provider.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:edutech_app/features/roadmap/views/widgets/answer_option.dart';
import 'package:edutech_app/features/roadmap/views/widgets/home_work_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeworkScreen extends StatelessWidget {
  final Lesson lesson;
  final int classId;
  final Function(int)? onComplete;

  const HomeworkScreen({
    super.key,
    required this.lesson,
    required this.classId,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LessonDetailsProvider(apiConsumer: DioConsumer(dio: Dio()))
            ..loadLessonDetails(classId, lesson.id),
      child: HomeworkView(onComplete: onComplete, lessonId: lesson.id),
    );
  }
}

class HomeworkView extends StatelessWidget {
  final Function(int)? onComplete;
  final int lessonId;

  const HomeworkView({super.key, this.onComplete, required this.lessonId});

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
      body: Consumer<LessonDetailsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: HomeworkShimmer());
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
                        SizedBox(height: 4),
                        Text(
                          'chosse the correct answer',
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
                    FinishButton(
                      onPressed: () => provider.finishHomework(
                        context,
                        onComplete,
                        lessonId,
                      ),
                    ),
                  SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        final controller = context.read<ChatController>();
                        controller.createNewSession();
                        Get.to(() => const ChatScreen());
                      },
                      child: Text(
                        'Ask Ai Tutor',
                        style: AppTypography.heading3.copyWith(
                          color: AppColors.primary400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
