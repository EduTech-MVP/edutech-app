import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_students_controller.dart';
import 'package:edutech_app/features/teacher/model/add_student_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStudentDialog extends StatefulWidget {
  final int classId;

  const AddStudentDialog({super.key, required this.classId});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleAddStudent() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<TeacherStudentsController>();

    final request = AddStudentRequest(
      username: _usernameController.text.trim(),
      classId: widget.classId,
    );

    final success = await controller.addStudentToClass(request);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.error ?? 'Failed to add student'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherStudentsController>(
      builder: (context, controller, _) {
        final isLoading = controller.addingStudent;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.sky50,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.spacing24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Student',
                      style: AppTypography.heading4.copyWith(
                        color: AppColors.neutral800,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: isLoading
                          ? null
                          : () => Navigator.pop(context),
                      color: AppColors.neutral800,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.spacing16),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Username',
                        style: AppTypography.subtle.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacing4),
                      CustomTextFormField(
                        controller: _usernameController,
                        hintText: 'Enter student username',
                        fillColor: Colors.white,
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.spacing24),

                // Add Button
                SizedBox(
                  width: double.infinity,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary500,
                          ),
                        )
                      : CustomElevatedButton(
                          text: 'Add Student',
                          onTap: _handleAddStudent,
                          width: double.infinity,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
