class Parent {
  final String fullName;
  final String profileImageUrl;
  final int numberOfChildren;
  final int numberOfClasses;
  final List<Child> children;

  Parent({
    required this.fullName,
    required this.profileImageUrl,
    required this.numberOfChildren,
    required this.numberOfClasses,
    required this.children,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    // Handle profile image path - convert relative to absolute URL
    String? profileImage = json['profileImageUrl'];
    if (profileImage != null && profileImage.isNotEmpty) {
      // Convert relative path to absolute URL
      if (profileImage.startsWith('/') && !profileImage.startsWith('//')) {
        profileImage = 'http://edutech.runasp.net$profileImage';
      }
      // If it's already a full URL or empty, keep it as is
    } else {
      profileImage = null; // Set to null if empty
    }

    return Parent(
      fullName: json['fullName'] ?? '',
      profileImageUrl: profileImage ?? '',
      numberOfChildren: json['numberOfChildren'] ?? 0,
      numberOfClasses: json['numberOfClasses'] ?? 0,
      children:
          (json['children'] as List<dynamic>?)
              ?.map((child) => Child.fromJson(child))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'profileImageUrl': profileImageUrl,
      'numberOfChildren': numberOfChildren,
      'numberOfClasses': numberOfClasses,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }
}

class Child {
  final int childId;
  final String childName;
  final String profileImageUrl;
  final int completedLessons;
  final int points;

  Child({
    required this.childId,
    required this.childName,
    required this.profileImageUrl,
    required this.completedLessons,
    required this.points,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    // Handle profile image path - convert relative to absolute URL
    String? profileImage = json['profileImageUrl'];
    if (profileImage != null && profileImage.isNotEmpty) {
      // Convert relative path to absolute URL
      if (profileImage.startsWith('/') && !profileImage.startsWith('//')) {
        profileImage = 'http://edutech.runasp.net$profileImage';
      }
      // If it's already a full URL, keep it as is
    } else {
      profileImage = null; // Set to null if empty
    }

    return Child(
      childId: json['childId'] ?? 0,
      childName: json['childName'] ?? '',
      profileImageUrl: profileImage ?? '',
      completedLessons: json['completedLessons'] ?? 0,
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'childId': childId,
      'childName': childName,
      'profileImageUrl': profileImageUrl,
      'completedLessons': completedLessons,
      'points': points,
    };
  }
}
