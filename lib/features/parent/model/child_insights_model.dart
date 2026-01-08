import 'package:edutech_app/core/models/ai_evaluation_model.dart';
import 'package:edutech_app/core/utils/ai_evaluation_generator.dart';

enum ActivityType {
  lessonCompleted,
  quizCompleted,
  dailyLogin,
  achievementUnlocked,
}

class ChildInsights {
  final int childId;
  final String childName;
  final String? profileImageUrl;
  final int completedLessons;
  final int totalLessons;
  final List<Activity> recentActivities;
  final AIEvaluation? aiEvaluation;

  ChildInsights({
    required this.childId,
    required this.childName,
    this.profileImageUrl,
    required this.completedLessons,
    required this.totalLessons,
    required this.recentActivities,
    this.aiEvaluation,
  });

  double get progressPercentage {
    if (totalLessons == 0) return 0.0;
    return (completedLessons / totalLessons) * 100;
  }
}

class Activity {
  final ActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  Activity({
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.metadata,
  });

  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class MockInsightsGenerator {
  static ChildInsights generateMockInsights(int childId, String childName) {
    // Different mock data sets for different children
    final activities = _generateMockActivities(childId);

    // Calculate completed lessons from activities
    final completedLessons = activities
        .where((a) => a.type == ActivityType.lessonCompleted)
        .length;

    return ChildInsights(
      childId: childId,
      childName: childName,
      profileImageUrl: null,
      completedLessons: completedLessons,
      totalLessons: 20, // Mock total lessons
      recentActivities: activities,
      aiEvaluation: _generateAIEvaluation(childId, childName, completedLessons),
    );
  }

  static List<Activity> _generateMockActivities(int childId) {
    final now = DateTime.now();
    final activities = <Activity>[];

    // Different activity sets based on childId
    if (childId == 1) {
      // Child 1: Active learner with many activities
      activities.addAll([
        Activity(
          type: ActivityType.lessonCompleted,
          title: 'Lesson Completed',
          description: 'Completed lesson: Introduction to Mathematics',
          timestamp: now.subtract(const Duration(minutes: 30)),
          metadata: {'lessonId': 101, 'subject': 'Mathematics'},
        ),
        Activity(
          type: ActivityType.quizCompleted,
          title: 'Quiz Completed',
          description: 'Scored 92% on Algebra Basics Quiz',
          timestamp: now.subtract(const Duration(hours: 2)),
          metadata: {'quizId': 201, 'score': 92, 'maxScore': 100},
        ),
        Activity(
          type: ActivityType.dailyLogin,
          title: 'Daily Practice',
          description: 'Logged in and practiced for 45 minutes',
          timestamp: now.subtract(const Duration(hours: 3)),
        ),
        Activity(
          type: ActivityType.lessonCompleted,
          title: 'Lesson Completed',
          description: 'Completed lesson: Basic Geometry',
          timestamp: now.subtract(const Duration(hours: 5)),
          metadata: {'lessonId': 102, 'subject': 'Mathematics'},
        ),
        Activity(
          type: ActivityType.achievementUnlocked,
          title: 'Achievement Unlocked',
          description: 'Unlocked achievement: Math Master',
          timestamp: now.subtract(const Duration(days: 1)),
          metadata: {'achievementId': 301},
        ),
        Activity(
          type: ActivityType.quizCompleted,
          title: 'Quiz Completed',
          description: 'Scored 88% on Geometry Quiz',
          timestamp: now.subtract(const Duration(days: 1, hours: 2)),
          metadata: {'quizId': 202, 'score': 88, 'maxScore': 100},
        ),
        Activity(
          type: ActivityType.lessonCompleted,
          title: 'Lesson Completed',
          description: 'Completed lesson: Introduction to Science',
          timestamp: now.subtract(const Duration(days: 2)),
          metadata: {'lessonId': 201, 'subject': 'Science'},
        ),
        Activity(
          type: ActivityType.dailyLogin,
          title: 'Daily Practice',
          description: 'Logged in and practiced for 30 minutes',
          timestamp: now.subtract(const Duration(days: 2, hours: 3)),
        ),
      ]);
    } else if (childId == 2) {
      // Child 2: Moderate activity
      activities.addAll([
        Activity(
          type: ActivityType.lessonCompleted,
          title: 'Lesson Completed',
          description: 'Completed lesson: English Grammar Basics',
          timestamp: now.subtract(const Duration(hours: 1)),
          metadata: {'lessonId': 301, 'subject': 'English'},
        ),
        Activity(
          type: ActivityType.quizCompleted,
          title: 'Quiz Completed',
          description: 'Scored 85% on Vocabulary Quiz',
          timestamp: now.subtract(const Duration(hours: 4)),
          metadata: {'quizId': 301, 'score': 85, 'maxScore': 100},
        ),
        Activity(
          type: ActivityType.dailyLogin,
          title: 'Daily Practice',
          description: 'Logged in and practiced for 25 minutes',
          timestamp: now.subtract(const Duration(days: 1)),
        ),
        Activity(
          type: ActivityType.lessonCompleted,
          title: 'Lesson Completed',
          description: 'Completed lesson: Reading Comprehension',
          timestamp: now.subtract(const Duration(days: 1, hours: 5)),
          metadata: {'lessonId': 302, 'subject': 'English'},
        ),
        Activity(
          type: ActivityType.achievementUnlocked,
          title: 'Achievement Unlocked',
          description: 'Unlocked achievement: Reading Star',
          timestamp: now.subtract(const Duration(days: 3)),
          metadata: {'achievementId': 401},
        ),
      ]);
    } else {
      // Default: Recent activities for other children
      activities.addAll([
        Activity(
          type: ActivityType.lessonCompleted,
          title: 'Lesson Completed',
          description: 'Completed lesson: General Knowledge',
          timestamp: now.subtract(const Duration(hours: 2)),
          metadata: {'lessonId': 401, 'subject': 'General'},
        ),
        Activity(
          type: ActivityType.dailyLogin,
          title: 'Daily Practice',
          description: 'Logged in and practiced for 20 minutes',
          timestamp: now.subtract(const Duration(days: 1)),
        ),
        Activity(
          type: ActivityType.quizCompleted,
          title: 'Quiz Completed',
          description: 'Scored 78% on General Knowledge Quiz',
          timestamp: now.subtract(const Duration(days: 2)),
          metadata: {'quizId': 401, 'score': 78, 'maxScore': 100},
        ),
      ]);
    }

    // Sort by timestamp (newest first)
    activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return activities;
  }

  static AIEvaluation _generateAIEvaluation(
    int childId,
    String childName,
    int completedLessons,
  ) {
    return AIEvaluationGenerator.generateEvaluation(
      studentId: childId,
      studentName: childName,
      completedLessons: completedLessons,
      totalLessons: 20, // Mock total lessons
    );
  }
}
