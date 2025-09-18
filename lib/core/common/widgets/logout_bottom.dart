import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/auth/controllers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        "Logout",
        style: AppTypography.large.copyWith(color: AppColors.sky300),
      ),
      onTap: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Logout", textAlign: TextAlign.center),

            contentTextStyle: AppTypography.tableItem,
            content: Text("Are you sure you want to logout?"),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              ),
            ],
          ),
        );

        if (confirmed != null && confirmed) {
          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.signIn,
            (route) => false,
          );
          await userProvider.logout();
        }
      },
    );
  }
}
