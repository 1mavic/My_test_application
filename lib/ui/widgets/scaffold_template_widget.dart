import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:my_app/navigation/routes.dart";

class ScaffoldBodyTemplateWidget extends StatelessWidget {
  const ScaffoldBodyTemplateWidget({
    super.key,
    required this.appBarTitle,
    required this.body,
    this.settings = true,
  });
  final String appBarTitle;
  final Widget body;
  final bool settings;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        actions: settings
            ? <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.settings);
                  },
                  icon: const Icon(
                    CupertinoIcons.settings,
                  ),
                )
              ]
            : <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: body,
      ),
    );
  }
}
