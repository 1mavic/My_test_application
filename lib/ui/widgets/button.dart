import "package:flutter/material.dart";
import "package:my_app/styles/app_colors.dart";
import "package:my_app/utils/string_extensions.dart";

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
      ),
      child: Text(
        text.firstToUpper(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }
}
