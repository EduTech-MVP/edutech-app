import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AddStudentDialog extends StatefulWidget {
  final Function(String username) onAddStudent;

  const AddStudentDialog({super.key, required this.onAddStudent});

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                  onPressed: () => Navigator.pop(context),
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
                    'Username',
                    style: AppTypography.subtle.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing4),
                  CustomTextFormField(
                    controller: _usernameController,
                    hintText: 'Enter a student username',
                    fillColor: Colors.white,
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
              child: CustomElevatedButton(
                text: 'Add Student',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onAddStudent(_usernameController.text);
                    Navigator.pop(context);
                  }
                },
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
