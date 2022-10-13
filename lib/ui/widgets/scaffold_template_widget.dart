import "package:flutter/material.dart";

class ScaffoldBodyTemplateWidget extends StatelessWidget {
  const ScaffoldBodyTemplateWidget({
    super.key,
    required this.appBarTitle,
    required this.body,
  });
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: body,
      ),
    );
  }
}
