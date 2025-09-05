# edutech_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Structure

```text
edutech_app/
  lib/
    core/
      common/
        widgets/
      constants/
      theme/
        app_colors.dart
        app_spacing.dart
        app_theme.dart
        app_typography.dart
    features/
      auth/
        controller/
        model/
        view/
      parent/
        controller/
        model/
        view/
      splash/
        view/
      teacher/
        controller/
        model/
        view/
    main.dart
```

Guidelines:

- Keep shared UI and utilities inside `lib/core/`.
- Group feature code by domain inside `lib/features/<feature>/{controller,model,view}`.
- Add new themes or design tokens under `lib/core/theme/`.
- Place assets under `assets/` and register them in `pubspec.yaml`.
