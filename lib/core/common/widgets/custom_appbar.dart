import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .09,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
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
        trailing: Icon(
          color: Colors.black,
          size: AppSpacing.iconMD,
          FontAwesomeIcons.bell,
        ),
      ),
    );
  }
}
