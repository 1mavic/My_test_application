import "package:flutter/material.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";
import "package:flutter_test_application/ui/widgets/user_card_widget.dart";

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: user.userName,
      body: UserCardWidget(
        user: user,
        small: false,
      ),
    );
  }
}
