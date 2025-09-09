import 'package:edutech_app/core/common/widgets/subject_card_widget.dart';
import 'package:flutter/material.dart';

class SubjectListPage extends StatelessWidget {
  const SubjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Subject> subjects = [
      Subject(
        image: 'assets/images/math.svg',
        title: 'Math',
        subTitle: 'Class B -',
        lessonsCompleted: 'Completed 8 lessons',
      ),
      Subject(
        image: 'assets/images/science.svg',
        title: 'Science',
        subTitle: 'Class A - Metro Boomin',
        lessonsCompleted: 'Completed 12 lessons',
      ),
      Subject(
        image: 'assets/images/english.svg',
        title: 'English',
        subTitle: 'Class M - Kendrick Lamar',
        lessonsCompleted: 'Completed 10 lessons',
      ),
      Subject(
        image: 'assets/images/arabic.svg',
        title: 'Arabic',
        subTitle: 'Class C - DJ Khalid',
        lessonsCompleted: 'Completed 7 lessons',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: SizedBox(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              //  childAspectRatio: 0.8,
              children: subjects.map((subject) {
                return SubjectCard(subject: subject);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
