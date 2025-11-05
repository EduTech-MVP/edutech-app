import 'package:edutech_app/core/common/widgets/custom_appbar.dart';
import 'package:edutech_app/core/common/widgets/elevated_bottom.dart';
import 'package:edutech_app/core/common/widgets/gradient_background.dart';
import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_spacing.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/parent/controller/parent_controller.dart';
import 'package:edutech_app/features/parent/view/widgets/add_child_dialog.dart';
import 'package:edutech_app/features/parent/view/widgets/child_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

/// Screen showing all children with management options
class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  void _loadChildren() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParentProvider>().fetchAllChildren();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<ParentProvider>().refreshAllChildren();
  }

  void _showAddChildDialog() {
    AddChildDialog.show(context).then((_) {
      // Refresh children list after adding
      context.read<ParentProvider>().refreshAllChildren();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold.main(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top * 2.5,
        ),
        child: const CustomAppbar.screen(pageTitle: "Children"),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppSpacing.xl),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/profile.svg',
              height: AppSpacing.iconLG,
              colorFilter: const ColorFilter.mode(
                AppColors.sky500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Manage Children',
              style: AppTypography.heading3.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        CustomElevatedButton(
          text: 'Add Child',
          width: 122,
          onTap: _showAddChildDialog,
          leadingIcon: const Icon(
            Icons.add,
            color: Colors.white,
            size: AppSpacing.iconSM,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Consumer<ParentProvider>(
      builder: (context, provider, _) {
        if (provider.loadingAllChildren) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.childrenError != null) {
          return _buildErrorState(provider);
        }

        if (provider.allChildren.isEmpty) {
          return _buildEmptyState();
        }

        return _buildChildrenList(provider);
      },
    );
  }

  Widget _buildChildrenList(ParentProvider provider) {
    return ListView.builder(
      itemCount: provider.allChildren.length,
      itemBuilder: (context, index) {
        final student = provider.allChildren[index];
        return ChildCard(
          studentId: student.studentId,
          name: student.fullName,
          username: student.firstName,
          grade: student.grade,
          profileImage: student.profilePicture,
        );
      },
    );
  }

  Widget _buildErrorState(ParentProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: AppColors.error),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Failed to load children',
            style: AppTypography.heading4.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            provider.childrenError ?? 'Unknown error',
            style: AppTypography.subtle.copyWith(color: AppColors.neutral500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(onPressed: _onRefresh, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.family_restroom,
            size: 80,
            color: AppColors.neutral400,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No children added yet',
            style: AppTypography.heading4.copyWith(color: AppColors.neutral600),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap the "Add Child" button to add your child',
            style: AppTypography.subtle.copyWith(color: AppColors.neutral500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
