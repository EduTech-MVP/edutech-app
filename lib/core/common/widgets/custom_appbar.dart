import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .09,
      decoration: BoxDecoration(
        color: AppColors.sky50,
        boxShadow: [AppColors.defaultShadow.copyWith(offset: Offset(0, 0))],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          // backgroundImage: ,
          maxRadius: MediaQuery.of(context).size.width * .06,
        ),
        title: Text('Good morning!'),
        titleTextStyle: TextStyle(color: AppColors.neutral700),
        subtitle: Text("Maryam Abdallah"),
        subtitleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        trailing: Container(
          width: AppSpacing.xxxxl,
          height: AppSpacing.xxxxl,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Center(child: Icon(Icons.notifications_none)),
              Positioned(
                top: AppSpacing.md,
                right: 10,
                child: Container(
                  width: AppSpacing.md,
                  height: AppSpacing.md,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.error,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
