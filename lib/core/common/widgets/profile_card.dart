import 'package:edutech_app/core/common/widgets/rounded_container.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.usersigned?.user ?? userProvider.profile;

    return RoundedContainer(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(AppSpacing.cardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                user!.profileImageUrl != null &&
                    user.profileImageUrl!.isNotEmpty
                ? NetworkImage(user.profileImageUrl!)
                : NetworkImage(
                    'http://edutech.runasp.net/profile-images/default.jpg',
                  ),
          ),

          const SizedBox(height: 12),

          // Name
          Text(
            "${user!.firstName ?? ''} ${user.lastName ?? ''}",
            style: AppTypography.heading4,
          ),

          // Email
          Text(user.email ?? '@no-email'),

          const SizedBox(height: 20),

          // Age or grade (if you have it in UserModel)
          Text(user.userType ?? 'Unknown', style: AppTypography.small),
        ],
      ),
    );
  }
}
