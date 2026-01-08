import 'package:edutech_app/features/parent/controller/add_child_controller.dart';

/// Form validators for add child form
class AddChildFormValidators {
  static String? Function(String?) fullName(AddChildController controller) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your child\'s full name';
      }
      return null;
    };
  }

  static String? Function(String?) username(AddChildController controller) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please choose a username';
      }
      return null;
    };
  }

  static String? Function(String?) password(AddChildController controller) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please create a password';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    };
  }

  static String? Function(String?) confirmPassword(
    AddChildController controller,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm the password';
      }
      if (value != controller.passwordController.text) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  static String? Function(String?) dateOfBirth(AddChildController controller) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Required';
      }
      return null;
    };
  }
}
