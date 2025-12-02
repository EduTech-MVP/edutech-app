import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: _TypingIndicatorContent(),
    );
  }
}

class _TypingIndicatorContent extends StatefulWidget {
  const _TypingIndicatorContent();

  @override
  State<_TypingIndicatorContent> createState() =>
      _TypingIndicatorContentState();
}

class _TypingIndicatorContentState extends State<_TypingIndicatorContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AnimatedDot(controller: _controller, delay: 0),
          const SizedBox(width: 4),
          _AnimatedDot(controller: _controller, delay: 0.2),
          const SizedBox(width: 4),
          _AnimatedDot(controller: _controller, delay: 0.4),
        ],
      ),
    );
  }
}

class _AnimatedDot extends StatelessWidget {
  final AnimationController controller;
  final double delay;

  const _AnimatedDot({required this.controller, required this.delay});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = (controller.value - delay) % 1.0;
        final opacity = value < 0.5
            ? (value * 2).clamp(0.3, 1.0)
            : ((1 - value) * 2).clamp(0.3, 1.0);

        return Opacity(
          opacity: opacity,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.neutral600,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
