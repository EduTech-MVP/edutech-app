import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/logout_bottom.dart';
import 'package:edutech_app/core/common/widgets/profile_achievements_card.dart';
import 'package:edutech_app/core/common/widgets/profile_card.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.page(
          pageTitle: "Profile",
          trailingWidget: LogoutButton(),
        ),
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
                        image: 'assets/icons/book.svg',
                        num: 37,
                        acheive: 'Lessons Completed',
                      ),
                      const SizedBox(width: 10),
                      const ProfileAchievementsCard(
                        image: 'assets/icons/grad_cap.svg',
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
