import 'package:edutech_app/features/auth/controllers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<AuthProvider>().logout();
                Navigator.pushReplacementNamed(context, '/signup');
              },

              child: Text('logsout'),
            ),
            Text('Teacher home'),
          ],
        ),
      ),
    );
  }
}
