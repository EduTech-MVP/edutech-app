import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  const CustomAppbar({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .09,
      decoration: BoxDecoration(
        color: AppColors.sky50,
        boxShadow: [AppColors.defaultShadow.copyWith(offset: Offset(0, 0))],
      ),
      child: ListTile(
        leading: leading,
        title: title,
        titleTextStyle: titleTextStyle,
        subtitle: subtitle,
        subtitleTextStyle: subtitleTextStyle,
        trailing: trailing,
      ),
    );
  }
}
