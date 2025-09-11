import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/profile_achievements_card.dart';
import 'package:edutech_app/core/common/widgets/profile_card.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/student/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationController>().onItemTapped(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80 + MediaQuery.of(context).padding.top),
        child: const CustomAppbar.home(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                children: [
                  const ProfileCard(),
                  SizedBox(height: MediaQuery.of(context).size.width * .08),
                  Row(
                    children: [
                      const ProfileAchievementsCard(
                        image: 'assets/images/book.svg',
                        num: 37,
                        acheive: 'Lessons Completed',
                      ),
                      const SizedBox(width: 10),
                      const ProfileAchievementsCard(
                        image: 'assets/icons/grad.svg',
                        num: 4,
                        acheive: 'Classes Enrolled in',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
