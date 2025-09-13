import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/teacher/model/class_model.dart';
import 'package:flutter/material.dart';

class AddClassDialog extends StatefulWidget {
  final Function(ClassModel classModel) onAddClass;

  const AddClassDialog({super.key, required this.onAddClass});

  @override
  State<AddClassDialog> createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<AddClassDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedSubject = 'English';
  String _selectedGrade = '4th grade';

  final List<String> _subjects = ['English', 'Math', 'Science', 'Arabic'];
  final List<String> _grades = ['4th grade'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                            onChanged: (value) {
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
                            onChanged: (value) {
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
                child: CustomElevatedButton(
                  text: 'Create Class',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final newClass = ClassModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _nameController.text,
                        subject: _selectedSubject,
                        grade: _selectedGrade,
                        lessonCount: 0,
                        studentCount: 0,
                      );
                      widget.onAddClass(newClass);
                      Navigator.pop(context);
                    }
                  },
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
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
    required ValueChanged<String?> onChanged,
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
