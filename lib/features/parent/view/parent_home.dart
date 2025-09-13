import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/parent/view/widgets/ai_assistant.dart';
import 'package:edutech_app/features/parent/view/widgets/family_progress.dart';
import 'package:edutech_app/features/parent/view/widgets/your_children_card.dart';
import 'package:flutter/material.dart';

class ParentHome extends StatefulWidget {
  const ParentHome({super.key});

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80 + MediaQuery.of(context).padding.top),
        child: const CustomAppbar.home(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            children: [
              AiAssistantCard(),
              FamilyProgressCard(),
              YourChildrenCard(),
            ],
          ),
        ),
      ),
    );
  }
}
