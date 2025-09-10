import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AppbarTrallingIcon extends StatelessWidget {
  final void Function()? onTap;
  final ImageProvider<Object>? image;
  const AppbarTrallingIcon({
    super.key,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSpacing.xxxxl,
        height: AppSpacing.xxxxl,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Align(
          alignment: Alignment.center,
          child: Image(
            fit: BoxFit.contain,
            width: 20,
            height: 20,
            image: image!,
          ),
        ),
      ),
    );
  }
}
