import "package:flutter/material.dart";

class ScaffoldBodyTemplateWidget extends StatelessWidget {
  const ScaffoldBodyTemplateWidget(
      {Key? key, required this.appBarTitle, required this.body})
      : super(key: key);
  final String appBarTitle;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: body,
      ),
    );
  }
}
