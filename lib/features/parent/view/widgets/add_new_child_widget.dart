import 'package:edutech_app/core/common/widgets/custom_textformfeild.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:edutech_app/features/parent/model/add_student_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget for adding a new child account
class AddNewChildWidget extends StatefulWidget {
  final VoidCallback? onClose;
  final VoidCallback? onSuccess;

  const AddNewChildWidget({super.key, this.onClose, this.onSuccess});

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
  bool _isLoading = false;

  static const List<String> _grades = ['Grade 4', 'Grade 5', 'Grade 6'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedGrade == null) {
      _showSnackBar('Please select a grade', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userProvider = context.read<UserProvider>();
      final parentProvider = context.read<ParentProvider>();

      await userProvider.addStudent(
        AddStudentRequest(
          fullName: _fullNameController.text.trim(),
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          dateOfBirth: _dateController.text.trim(),
          grade: _mapGradeToNumber(_selectedGrade!),
        ),
      );

      // Refresh parent data after adding child
      await parentProvider.refreshAllChildren();

      if (!mounted) return;

      // Close dialog and show success
      widget.onSuccess?.call();
      _showSnackBar(
        'Child ${userProvider.student?.firstName ?? ''} added successfully!',
      );
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to create child: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : null,
      ),
    );
  }

  int _mapGradeToNumber(String grade) {
    if (grade == 'Kindergarten') return 0;
    return int.tryParse(grade.replaceAll('Grade ', '')) ?? 0;
  }

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
              _buildHeader(),
              const SizedBox(height: AppSpacing.xl),
              _buildFullNameField(),
              const SizedBox(height: AppSpacing.lg),
              _buildUsernameField(),
              const SizedBox(height: AppSpacing.lg),
              _buildPasswordField(),
              const SizedBox(height: AppSpacing.lg),
              _buildConfirmPasswordField(),
              const SizedBox(height: AppSpacing.lg),
              _buildDateAndGradeRow(),
              const SizedBox(height: AppSpacing.xxl),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
          child: const Icon(
            Icons.close,
            color: AppColors.neutral600,
            size: AppSpacing.iconMD,
          ),
        ),
      ],
    );
  }

  Widget _buildFullNameField() {
    return _buildField(
      label: 'Full Name',
      controller: _fullNameController,
      hintText: "Enter your child's full name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your child\'s full name';
        }
        return null;
      },
    );
  }

  Widget _buildUsernameField() {
    return _buildField(
      label: 'Username',
      controller: _usernameController,
      hintText: 'Choose a username',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please choose a username';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return _buildField(
      label: 'Password',
      controller: _passwordController,
      hintText: 'Create a password',
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
    );
  }

  Widget _buildConfirmPasswordField() {
    return _buildField(
      label: 'Confirm Password',
      controller: _confirmPasswordController,
      hintText: 'Confirm the password',
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
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.paragrah.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          enabled: !_isLoading,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDateAndGradeRow() {
    return Row(
      children: [
        Expanded(child: _buildDateField()),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _buildGradeField()),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
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
          hintText: 'mm/dd/yyyy',
          keyboardType: TextInputType.datetime,
          enabled: !_isLoading,
          prefixIcon: const Icon(Icons.calendar_today, size: AppSpacing.iconSM),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildGradeField() {
    return Column(
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing16,
            vertical: AppSpacing.spacing12,
          ),
          decoration: BoxDecoration(
            color: AppColors.sky50,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
            border: Border.all(
              color: AppColors.neutral300,
              width: AppSpacing.radiusXS / 2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGrade,
              hint: Text(
                'Select grade',
                style: AppTypography.subtle.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
              isExpanded: true,
              icon: const Icon(
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
              onChanged: _isLoading
                  ? null
                  : (String? newValue) {
                      setState(() => _selectedGrade = newValue);
                    },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        text: _isLoading ? '' : 'Create Account',
        onTap: _isLoading ? null : _handleSubmit,
        leadingIcon: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
