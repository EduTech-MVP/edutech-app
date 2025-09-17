// ignore_for_file: use_build_context_synchronously

import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:edutech_app/features/parent/model/add_student_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewChildWidget extends StatefulWidget {
  final VoidCallback? onClose;
  final VoidCallback? onCreateAccount;

  const AddNewChildWidget({super.key, this.onClose, this.onCreateAccount});

  @override
  State<AddNewChildWidget> createState() => _AddNewChildWidgetState();
}

class _AddNewChildWidgetState extends State<AddNewChildWidget> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateController = TextEditingController();

  String? _selectedGrade;
  final List<String> _grades = ['Grade 4', 'Grade 5', 'Grade 6'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Child',
                    style: AppTypography.heading3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onClose ?? () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.neutral600,
                      size: AppSpacing.iconMD,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // Full Name
              Text(
                'Full Name',
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomTextFormField(
                controller: _fullNameController,
                hintText: "Enter your child's full name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your child\'s full name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              // Username
              Text(
                'Username',
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomTextFormField(
                controller: _usernameController,
                hintText: "Choose a username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose a username';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              // Password
              Text(
                'Password',
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomTextFormField(
                controller: _passwordController,
                hintText: "Create a password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please create a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              // Confirm Password
              Text(
                'Confirm Password',
                style: AppTypography.paragrah.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomTextFormField(
                controller: _confirmPasswordController,
                hintText: "Confirm the password",
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm the password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              // Date of Birth and Grade Row
              Row(
                children: [
                  // Date of Birth
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date of Birth',
                          style: AppTypography.paragrah.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        CustomTextFormField(
                          controller: _dateController,
                          hintText: "mm/dd/yyyy",
                          keyboardType: TextInputType.datetime,
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            size: AppSpacing.iconSM,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter date of birth';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  // Grade
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grade',
                          style: AppTypography.paragrah.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          height: 55,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing16,
                            vertical: AppSpacing.spacing12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.sky50,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusXXL,
                            ),
                            border: Border.all(
                              color: AppColors.neutral300,
                              width: AppSpacing.radiusXS / 2,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedGrade,
                              hint: Text(
                                'Select a grade',
                                style: AppTypography.subtle.copyWith(
                                  color: AppColors.neutral500,
                                ),
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.neutral500,
                              ),
                              items: _grades.map((String grade) {
                                return DropdownMenuItem<String>(
                                  value: grade,
                                  child: Text(
                                    grade,
                                    style: AppTypography.paragrah.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGrade = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: 'Create Account',
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        _selectedGrade != null) {
                      try {
                        await Provider.of<UserProvider>(
                          context,
                          listen: false,
                        ).addStudent(
                          AddStudentRequest(
                            fullName: _fullNameController.text,
                            username: _usernameController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                            dateOfBirth: _dateController.text,
                            grade: _mapGradeToNumber(_selectedGrade!),
                          ),
                        );

                        // Close dialog
                        widget.onCreateAccount?.call();

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Child ${Provider.of<UserProvider>(context, listen: false).student!.firstName} account created successfully!',
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to create child: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else if (_selectedGrade == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a grade'),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _mapGradeToNumber(String grade) {
    if (grade == 'Kindergarten') return 0;
    return int.tryParse(grade.replaceAll('Grade ', '')) ?? 0;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
