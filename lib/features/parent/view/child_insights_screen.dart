import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/features/parent/view/widgets/child_insights_section.dart';
import 'package:flutter/material.dart';

class ChildInsightsScreen extends StatelessWidget {
  const ChildInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: CustomAppbar.witharrow(
          pageTitle: 'Activity Insights',
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.pagePadding,
            vertical: AppSpacing.baseUnit,
          ),
          child: const ChildInsightsSection(),
        ),
      ),
    );
  }
}
