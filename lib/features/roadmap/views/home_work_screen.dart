import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/roadmap/controller/homework_provider.dart';
import 'package:edutech_app/features/roadmap/models/lesson_ui_model.dart';
import 'package:edutech_app/features/roadmap/views/widgets/answer_option.dart';
import 'package:edutech_app/features/roadmap/views/widgets/home_work_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeworkScreen extends StatelessWidget {
  final Lesson lesson;
  final Function(int)? onComplete;

  const HomeworkScreen({super.key, required this.lesson, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeworkProvider(lesson),
      child: HomeworkView(onComplete: onComplete),
    );
  }
}

class HomeworkView extends StatelessWidget {
  final Function(int)? onComplete;

  const HomeworkView({super.key, this.onComplete});

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
      body: Consumer<HomeworkProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress indicator
                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      '${provider.currentQuestionIndex + 1}/${provider.totalQuestions}',
                      style: AppTypography.small.copyWith(
                        color: AppColors.neutral400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(24),
                    value: provider.progress,
                    backgroundColor: AppColors.background,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary500,
                    ),
                    minHeight: 8,
                  ),
                ),

                const SizedBox(height: 16),

                // Question card
                Stack(
                  children: [
                    //background shadow
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.neutral200,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const SizedBox(width: double.infinity, height: 50),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.neutral300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.currentQuestion.text,
                            style: AppTypography.heading3.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Choose the correct answer',
                            style: AppTypography.small.copyWith(
                              color: AppColors.neutral400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Answer options
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                ),

                // Action buttons
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
                    onPressed: () =>
                        provider.finishHomework(context, onComplete),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
