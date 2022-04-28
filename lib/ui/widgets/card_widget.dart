import "package:flutter/material.dart";
import "package:flutter_test_application/styles/app_colors.dart";

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
