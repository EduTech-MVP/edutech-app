import 'package:edutech_app/core/common/widgets/ai_tutor.dart';
import 'package:edutech_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AiAssistantCard extends StatelessWidget {
  const AiAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AiTutorCard(
      headerText: 'AI Assistant',
      contentText: 'Get insights about your children\'s learning progress!',
      buttonText: 'View Insights',
      onButtonPressed: () {
        Navigator.pushNamed(context, AppRoutes.childInsights);
      },
    );
  }
}
