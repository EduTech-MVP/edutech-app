import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/controller/teacher_classes_controller.dart';
import 'package:edutech_app/features/teacher/model/create_class_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClassDialog extends StatefulWidget {
  const AddClassDialog({super.key});

  @override
  State<AddClassDialog> createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<AddClassDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedSubject = 'English';
  String _selectedGrade = '4';

  final List<String> _subjects = ['English', 'Math', 'Science', 'Arabic'];
  final List<String> _grades = ['4', '5', '6', '7'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateClass() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<TeacherClassesController>();

    final request = CreateClassRequest(
      className: _nameController.text.trim(),
      subject: _selectedSubject,
      grade: int.parse(_selectedGrade),
    );

    final success = await controller.createClass(request);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.lastCreatedClass?.message ??
                'Class created successfully!',
          ),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.error ?? 'Failed to create class'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherClassesController>(
      builder: (context, controller, _) {
        final isLoading = controller.creatingClass;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.sky50,
          child: SingleChildScrollView(
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
                        'Create New Class',
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
                        // Class Name
                        _buildTextField(
                          controller: _nameController,
                          label: 'Class Name',
                          hint: 'e.g., Class A',
                        ),

                        const SizedBox(height: AppSpacing.spacing12),
                        Row(
                          children: [
                            // Subject Dropdown
                            Expanded(
                              child: _buildDropdown(
                                label: 'Subject',
                                value: _selectedSubject,
                                items: _subjects,
                                onChanged: isLoading
                                    ? null
                                    : (value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedSubject = value;
                                          });
                                        }
                                      },
                              ),
                            ),

                            const SizedBox(width: AppSpacing.spacing16),

                            // Grade Dropdown
                            Expanded(
                              child: _buildDropdown(
                                label: 'Grade',
                                value: _selectedGrade,
                                items: _grades,
                                onChanged: isLoading
                                    ? null
                                    : (value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedGrade = value;
                                          });
                                        }
                                      },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.spacing24),

                  // Create Button
                  SizedBox(
                    width: double.infinity,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary500,
                            ),
                          )
                        : CustomElevatedButton(
                            text: 'Create Class',
                            onTap: _handleCreateClass,
                            width: double.infinity,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.subtle.copyWith(color: AppColors.neutral600),
        ),
        const SizedBox(height: AppSpacing.spacing4),
        CustomTextFormField(
          controller: controller,
          hintText: hint,
          fillColor: Colors.white,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.subtle.copyWith(color: AppColors.neutral600),
        ),
        const SizedBox(height: AppSpacing.spacing4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.neutral100),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing8,
                vertical: AppSpacing.spacing8,
              ),
            ),
            style: AppTypography.subtle.copyWith(color: AppColors.neutral600),
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
