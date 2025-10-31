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
    return Parent(
      fullName: json['fullName'],
      profileImageUrl: json['profileImageUrl'],
      numberOfChildren: json['numberOfChildren'],
      numberOfClasses: json['numberOfClasses'],
      children: (json['children'] as List<dynamic>)
          .map((child) => Child.fromJson(child))
          .toList(),
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
    return Child(
      childId: json['childId'],
      childName: json['childName'],
      profileImageUrl: json['profileImageUrl'],
      completedLessons: json['completedLessons'],
      points: json['points'],
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
