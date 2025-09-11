import 'package:edutech_app/core/common/widgets/appbar_tralling_icon.dart';
import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StudentAppbar extends StatelessWidget {
  const StudentAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppbar.home(
      // leading: CircleAvatar(
      //   backgroundColor: Colors.grey,
      //   // backgroundImage: ,
      //   maxRadius: MediaQuery.of(context).size.width * .06,
      // ),
      // title: Text('Good morning!'),
      // titleTextStyle: TextStyle(color: AppColors.neutral700),
      // subtitle: Text('Maryam Abdallah'),
      // subtitleTextStyle: TextStyle(
      //   color: Colors.black,
      //   fontWeight: FontWeight.bold,
      // ),
      // trailing: AppbarTrallingIcon(
      //   onTap: () {},
      //   image: AssetImage('assets/icons/notifications.svg'),
      // ),

      //  Container(
      //   width: AppSpacing.xxxxl,
      //   height: AppSpacing.xxxxl,
      //   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      //   child: Stack(
      //     children: [
      //       Center(child: Icon(Icons.notifications_none)),
      //       Positioned(
      //         top: AppSpacing.md,
      //         right: 10,
      //         child: Container(
      //           width: AppSpacing.md,
      //           height: AppSpacing.md,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             color: AppColors.error,
      //             border: Border.all(color: Colors.white, width: 2),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
