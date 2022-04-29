import "package:flutter/cupertino.dart";

Future<bool?> showIosDialog<bool>(BuildContext context) =>
    showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Внимание"),
        content: const Text("Вы хотите очистить локальные данные?"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Да"),
          ),
          CupertinoDialogAction(
            child: const Text("Нет"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
