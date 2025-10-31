import 'package:edutech_app/features/parent/view/widgets/add_new_child_widget.dart';
import 'package:flutter/material.dart';

class AddChildDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: AddNewChildWidget(
            onClose: () => Navigator.of(context).pop(),
            onSuccess: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
