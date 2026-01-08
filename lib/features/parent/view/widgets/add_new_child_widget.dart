import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/parent/controller/add_child_controller.dart';
import 'package:edutech_app/features/parent/view/widgets/add_child_form_field.dart';
import 'package:edutech_app/features/parent/view/widgets/add_child_form_validators.dart';
import 'package:edutech_app/features/parent/view/widgets/add_child_grade_dropdown.dart';
import 'package:edutech_app/features/parent/view/widgets/add_child_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget for adding a new child account
class AddNewChildWidget extends StatelessWidget {
  final VoidCallback? onClose;
  final VoidCallback? onSuccess;

  const AddNewChildWidget({super.key, this.onClose, this.onSuccess});

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : null,
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    final controller = context.read<AddChildController>();

    final success = await controller.addChild();

    if (!context.mounted) return;

    if (success) {
      onSuccess?.call();
      _showSnackBar(
        context,
        controller.successMessage ?? 'Child added successfully!',
      );
    } else {
      _showSnackBar(
        context,
        controller.error ?? 'Failed to create child',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddChildController>(
      builder: (context, controller, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXXL),
          ),
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddChildHeader(onClose: onClose),
                  const SizedBox(height: AppSpacing.xl),
                  AddChildFormField(
                    label: 'Full Name',
                    controller: controller.fullNameController,
                    hintText: "Enter your child's full name",
                    validator: AddChildFormValidators.fullName(controller),
                    enabled: !controller.isLoading,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AddChildFormField(
                    label: 'Username',
                    controller: controller.usernameController,
                    hintText: 'Choose a username',
                    validator: AddChildFormValidators.username(controller),
                    enabled: !controller.isLoading,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AddChildFormField(
                    label: 'Password',
                    controller: controller.passwordController,
                    hintText: 'Create a password',
                    obscureText: true,
                    validator: AddChildFormValidators.password(controller),
                    enabled: !controller.isLoading,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AddChildFormField(
                    label: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    hintText: 'Confirm the password',
                    obscureText: true,
                    validator: AddChildFormValidators.confirmPassword(
                      controller,
                    ),
                    enabled: !controller.isLoading,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: AddChildFormField(
                          label: 'Date of Birth',
                          controller: controller.dateController,
                          hintText: 'mm/dd/yyyy',
                          keyboardType: TextInputType.datetime,
                          enabled: !controller.isLoading,
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            size: AppSpacing.iconSM,
                          ),
                          validator: AddChildFormValidators.dateOfBirth(
                            controller,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      const Expanded(child: AddChildGradeDropdown()),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: controller.isLoading ? '' : 'Create Account',
                      onTap: controller.isLoading
                          ? null
                          : () => _handleSubmit(context),
                      leadingIcon: controller.isLoading
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
