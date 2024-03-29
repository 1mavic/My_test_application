import "package:flutter/cupertino.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/utils/string_extensions.dart";

Future<bool?> showIosDialog<bool>(BuildContext context) =>
    showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          context.localize(AppLocKeys.attention).firstToUpper(),
        ),
        content: Text(
          context.localize(AppLocKeys.clearData).firstToUpper(),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              context.localize(AppLocKeys.yes).firstToUpper(),
            ),
          ),
          CupertinoDialogAction(
            child: Text(
              context.localize(AppLocKeys.no).firstToUpper(),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
