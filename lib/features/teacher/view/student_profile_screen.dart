import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/section_header.dart';
import 'package:edutech_app/core/common/widgets/generic_loading_state.dart';
import 'package:edutech_app/core/common/widgets/generic_error_state.dart';
import 'package:edutech_app/core/common/widgets/generic_empty_state.dart';
import 'package:edutech_app/features/teacher/controller/teacher_student_profile_controller.dart';
import 'package:edutech_app/features/teacher/model/student_profile_response.dart';
import 'package:edutech_app/features/teacher/view/widgets/student_info_card.dart';
import 'package:edutech_app/features/teacher/view/widgets/subject_progress_card.dart';
import 'package:edutech_app/features/teacher/view/widgets/activity_card.dart';
import 'package:edutech_app/features/teacher/view/widgets/strengths_focus_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatelessWidget {
  final String studentId;
  final String studentName;

  const StudentProfileScreen({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  Color _getSubjectColor(String subject) {
    switch (subject.toLowerCase()) {
      case 'english':
        return AppColors.funsky;
      case 'math':
      case 'mathematics':
        return AppColors.funmint;
      case 'science':
        return AppColors.funcoral;
      default:
        return AppColors.funlavender;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TeacherStudentProfileController>();
    final profile = controller.studentProfile;
    final studentIdInt = int.tryParse(studentId);

    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: CustomAppbar.witharrow(
          pageTitle: 'Back',
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: controller.loading
            ? const GenericLoadingState(message: 'Loading student profile...')
            : controller.error != null
            ? GenericErrorState(
                error: controller.error!,
                onRetry: studentIdInt != null
                    ? () => controller.refreshProfile(studentIdInt)
                    : null,
              )
            : profile == null
            ? const GenericEmptyState(
                icon: Icons.person_outline,
                title: 'No Profile Found',
                message: 'Unable to load student profile',
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.spacing24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Student Info Card
                    StudentInfoCard(
                      studentName: profile.fullName,
                      grade: profile.grade,
                      profileImageUrl: profile.profileImageUrl,
                      completedLessons: profile.completedLessons,
                      totalLessons: profile.totalLessons,
                      weeklyProgress: profile.weeklyAttendance,
                    ),
                    const SizedBox(height: 36),

                    // Subject Progress Section
                    if (profile.subjectProgress.isNotEmpty)
                      SectionHeader(
                        title: 'Subject Progress',
                        child: Column(
                          children: profile.subjectProgress
                              .map(
                                (subject) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SubjectProgressCard(
                                    subjectName: subject.subject,
                                    completedLessons: subject.completedLessons,
                                    progressPercentage: subject
                                        .progressPercentage
                                        .toInt(),
                                    subjectColor: _getSubjectColor(
                                      subject.subject,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    if (profile.subjectProgress.isNotEmpty)
                      const SizedBox(height: 36),

                    // Recent Activity Section
                    SectionHeader(
                      title: 'Recent Activity',
                      child: profile.recentActivity.isEmpty
                          ? const GenericEmptyState(
                              icon: Icons.history_outlined,
                              title: 'No Recent Activity',
                              message: 'Activity history will appear here',
                            )
                          : Column(
                              children: profile.recentActivity
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            entry.key <
                                                profile.recentActivity.length -
                                                    1
                                            ? 16
                                            : 0,
                                      ),
                                      child: _buildActivityCard(entry.value),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                    const SizedBox(height: 36),

                    // Strengths & Focus On Section - Placeholder for now
                    const StrengthsFocusSection(strengths: [], focusAreas: []),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildActivityCard(RecentActivity activity) {
    // Since RecentActivity is just a wrapper, access the data map
    final data = activity.data;
    return ActivityCard(
      lessonTitle:
          data['lessonTitle'] ??
          data['title'] ??
          data['lessonName'] ??
          'Activity',
      timeAgo:
          data['timeAgo'] ??
          data['timestamp'] ??
          data['time'] ??
          data['date'] ??
          'Recently',
      score: (data['score'] ?? data['points'] ?? 0) as int,
    );
  }
}
