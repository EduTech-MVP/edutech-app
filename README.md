# EduTech App

A comprehensive Flutter-based educational technology application designed to provide an interactive learning experience for students, teachers, and parents. The app follows modern Flutter development practices with a clean MVC architecture and beautiful UI design.

## 🚀 Features

### Core Features

- **Multi-Role Support**: Separate interfaces for Students, Teachers, and Parents
- **Modern UI/UX**: Beautiful, responsive design with custom components
- **Authentication System**: Secure sign-up and sign-in functionality
- **Onboarding Experience**: Smooth user introduction and role selection
- **Cross-Platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux

### Student Features

- Interactive learning modules
- Progress tracking and achievements
- Subject-based learning paths
- Task management and completion tracking

### Teacher Features

- Class management and student oversight
- Lesson creation and content management
- Student progress monitoring
- Assignment and grading tools

### Parent Features

- Child progress monitoring
- Achievement tracking
- Communication with teachers
- Learning analytics and insights

## 🏗️ Architecture

The app follows the **MVC (Model-View-Controller)** architectural pattern:

```
lib/
├── core/                    # Core functionality and shared resources
│   ├── common/widgets/      # Reusable UI components
│   ├── constants/           # App constants
│   ├── routes/              # Navigation and routing
│   └── theme/               # Design system (colors, typography, spacing)
├── features/                # Feature-based modules
│   ├── auth/                # Authentication feature
│   ├── onboarding/          # User onboarding
│   └── welcome/             # Welcome screens
├── providers/               # State management
└── main.dart               # App entry point
```

### Design System

- **Colors**: Sky-themed color palette with semantic color naming
- **Typography**: Fredoka font family with multiple weights
- **Spacing**: Consistent spacing system using predefined values
- **Components**: Reusable widgets following design principles

## 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1+
- **Language**: Dart
- **State Management**: Provider
- **UI Components**: Material Design with custom theming
- **Icons**: Font Awesome Flutter, Custom SVG icons
- **Environment**: Flutter Dotenv for configuration
- **Vector Graphics**: Flutter SVG for scalable icons

## 📱 Screenshots

The app features a modern, intuitive interface with:

- Gradient backgrounds and smooth animations
- Custom cards and interactive elements
- Role-based navigation and content
- Responsive design for all screen sizes

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/edutech_app.git
   cd edutech_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Enable Flutter Web** (if developing for web)

   ```bash
   flutter config --enable-web
   ```

2. **Run on specific platforms**

   ```bash
   # Android
   flutter run -d android

   # iOS
   flutter run -d ios

   # Web
   flutter run -d web

   # Desktop
   flutter run -d windows
   flutter run -d macos
   flutter run -d linux
   ```

## 📁 Project Structure

### Core Components

- **CustomAppbar**: Reusable app bar with different variants
- **GradientScaffold**: Background scaffold with gradient support
- **CustomElevatedButton**: Styled button component
- **CustomTextFormField**: Consistent form input styling
- **SectionHeader**: Reusable section headers with actions
- **ProfileAchievementsCard**: Achievement display component

### Theme System

- **AppColors**: Comprehensive color palette
- **AppTypography**: Text styling system
- **AppSpacing**: Consistent spacing values
- **AppGradients**: Predefined gradient styles

## 🎨 Design Principles

- **Consistency**: Unified design language across all screens
- **Accessibility**: High contrast ratios and readable typography
- **Responsiveness**: Adaptive layouts for different screen sizes
- **Performance**: Optimized rendering and smooth animations
- **Maintainability**: Clean code structure and reusable components

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
API_BASE_URL=your_api_url
API_KEY=your_api_key
```

### Fonts

The app uses the Fredoka font family. Ensure all font files are properly included in `pubspec.yaml`.

## 📦 Dependencies

### Main Dependencies

- `provider`: State management
- `font_awesome_flutter`: Icon library
- `flutter_svg`: SVG support
- `flutter_dotenv`: Environment configuration

### Development Dependencies

- `flutter_lints`: Code linting and analysis

## 🚀 Building for Production

### Android

```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

### Desktop

```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## 🧪 Testing

Run tests using:

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

## 📝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent indentation and formatting

## 🔮 Roadmap

- [ ] Complete authentication system
- [ ] Implement real-time features
- [ ] Add offline support
- [ ] Integrate with backend APIs
- [ ] Add push notifications
- [ ] Implement advanced analytics
- [ ] Add multi-language support

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Development**: Flutter Development Team
- **Design**: UI/UX Design Team
- **Backend**: API Development Team

## 📞 Support

For support, email support@edutech.com or join our Slack channel.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for design inspiration
- Open source community for various packages

---

**EduTech App** - Empowering education through technology 🎓✨
