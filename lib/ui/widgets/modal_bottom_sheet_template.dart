import "package:flutter/material.dart";
import "package:modal_bottom_sheet/modal_bottom_sheet.dart";
import "package:my_app/styles/app_colors.dart";

Future<T?> showMyCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissable = true,
  bool fullHeight = false,
  bool? reverse,
  String? header,
  String? subheader,
  double? padding,
}) =>
    showCupertinoModalBottomSheet<T>(
      context: context,
      expand: fullHeight,
      builder: (BuildContext context) => Material(
        child: ColoredBox(
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    physics: const ClampingScrollPhysics(),
                    reverse: reverse ?? false,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          builder(context),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 38,
                  width: double.infinity,
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.containerColor,
                        ),
                        width: 140,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      elevation: 18,
      clipBehavior: Clip.antiAlias,
      topRadius: const Radius.circular(24),
      isDismissible: isDismissable,
      enableDrag: isDismissable,
      useRootNavigator: true,
    );
