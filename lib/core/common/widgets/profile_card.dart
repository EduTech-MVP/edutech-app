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
    final user = userProvider.profile;

    // Handle loading state
    if (userProvider.loading) {
      return RoundedContainer(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(AppSpacing.cardPadding),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // Handle no user data
    if (user == null) {
      return RoundedContainer(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(AppSpacing.cardPadding),
        child: Center(
          child: Text('No user data available', style: AppTypography.small),
        ),
      );
    }

    return RoundedContainer(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(AppSpacing.cardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundImage:
                user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty
                ? NetworkImage(user.profileImageUrl!)
                : const NetworkImage(
                    'http://edutech.runasp.net/profile-images/default.jpg',
                  ),
            child: user.profileImageUrl == null || user.profileImageUrl!.isEmpty
                ? Text(
                    user.firstName?.isNotEmpty == true
                        ? user.firstName![0].toUpperCase()
                        : 'U',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  )
                : null,
          ),

          const SizedBox(height: 12),

          // Name
          Text(
            "${user.firstName ?? ''} ${user.lastName ?? ''}".trim(),
            style: AppTypography.heading4,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Email
          Text(
            user.email ?? 'No email',
            style: AppTypography.small.copyWith(color: Colors.grey[600]),
          ),

          const SizedBox(height: 16),

          // User Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getUserTypeColor(user.userType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getUserTypeColor(user.userType),
                width: 1,
              ),
            ),
            child: Text(
              user.userType?.toUpperCase() ?? 'UNKNOWN',
              style: AppTypography.small.copyWith(
                color: _getUserTypeColor(user.userType),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get color based on user type
  Color _getUserTypeColor(String? userType) {
    switch (userType?.toLowerCase()) {
      case 'student':
        return Colors.blue;
      case 'teacher':
        return Colors.green;
      case 'parent':
        return Colors.orange;
      case 'admin':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
