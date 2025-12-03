import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/section_header.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/generic_empty_state.dart';
import 'package:edutech_app/core/common/widgets/generic_error_state.dart';
import 'package:edutech_app/core/common/widgets/generic_loading_state.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:edutech_app/features/teacher/view/widgets/add_class_dialog.dart';
import 'package:edutech_app/features/teacher/view/widgets/classes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeacherClassesScreen extends StatelessWidget {
  const TeacherClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.screen(pageTitle: 'Classes'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.spacing24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Classes Section
                      _buildClassesSection(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesSection(BuildContext context) {
    final classesController = context.watch<TeacherClassesController>();

    return SectionHeader(
      title: 'Manage Classes',
      icon: SvgPicture.asset(
        'assets/icons/grad_cap.svg',
        width: 36,
        height: 36,
        colorFilter: ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
      ),
      actionButtonText: 'Create Class',
      onActionPressed: () => _showAddClassDialog(context),
      useElevatedButton: true,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.spacing16),
        child: _buildContent(classesController),
      ),
    );
  }

  Widget _buildContent(TeacherClassesController controller) {
    if (controller.loading) {
      return const GenericLoadingState(message: 'Loading classes...');
    }

    if (controller.error != null) {
      return GenericErrorState(
        error: controller.error!,
        onRetry: controller.fetchClasses,
      );
    }

    if (controller.classes.isEmpty) {
      return const GenericEmptyState(
        icon: Icons.school_outlined,
        title: 'No Classes Yet',
        message: 'Create your first class to get started',
      );
    }

    return ClassesList(classes: controller.classes);
  }

  void _showAddClassDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AddClassDialog());
  }
}
