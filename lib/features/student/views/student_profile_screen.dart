import 'package:edutech_app/core/common/widgets/appbar_tralling_icon.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/profile_achievements_card.dart';
import 'package:edutech_app/core/common/widgets/profile_card.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.sky50,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar(
                title: Text('Profile'),
                titleTextStyle: AppTypography.heading4,
                trailing: AppbarTrallingIcon(
                  onTap: () {},
                  image: AssetImage('assets/icons/settings.svg'),
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.all(AppSpacing.pagePadding),
                child: Column(
                  children: [
                    ProfileCard(),
                    SizedBox(height: MediaQuery.of(context).size.width * .08),
                    Row(
                      children: [
                        ProfileAchievementsCard(
                          image: 'assets/images/book.svg',
                          num: 37,
                          acheive: 'Lessons Completed',
                        ),
                        SizedBox(width: 10),
                        ProfileAchievementsCard(
                          image: 'assets/icons/grad.svg',
                          num: 4,
                          acheive: 'Classes Enrolled in',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
