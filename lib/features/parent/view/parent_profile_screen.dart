import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/common/widgets/logout_bottom.dart';
import 'package:edutech_app/core/common/widgets/profile_card.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Parent profile screen showing user information
class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.screen(
          pageTitle: 'Profile',
          trailingWidget: LogoutButton(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            children: const [
              ProfileCard(),
              SizedBox(height: 64),
              // TODO: Add more profile sections here
              // - Settings
              // - Preferences
              // - Help & Support
            ],
          ),
        ),
      ),
    );
  }
}
