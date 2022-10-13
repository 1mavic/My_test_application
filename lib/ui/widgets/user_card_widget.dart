import "package:flutter/material.dart";
import "package:my_app/domain/entity/user/user_model.dart";
import "package:my_app/navigation/routes.dart";
import "package:my_app/ui/widgets/card_widget.dart";

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key, required this.user, required this.small});
  final User user;
  final bool small;
  @override
  Widget build(BuildContext context) {
    final Widget body = Column(
      children: <Widget>[
        CardWidget(
          child: small
              ? InkWell(
                  onTap: () {
                    if (!small) {
                      return;
                    }
                    Navigator.of(context)
                        .pushNamed(AppRoutes.userInfo, arguments: user);
                  },
                  child: _SmallWidget(user: user),
                )
              : _BigWidget(
                  user: user,
                ),
        ),
        // if (!small) const PostList()
      ],
    );

    return small
        ? body
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: body,
          );
  }
}

class _SmallWidget extends StatelessWidget {
  const _SmallWidget({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("User name: ${user.userName}"),
        Text("Name: ${user.name}"),
      ],
    );
  }
}

class _BigWidget extends StatelessWidget {
  const _BigWidget({required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Name: ${user.name}"),
        Text("email: ${user.email}"),
        Text("phone: ${user.phone}"),
        Text("website: ${user.website}"),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Working company:",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text("name: ${user.company.name}"),
        Text("bs: ${user.company.bs}"),
        RichText(
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "catch phrase: ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: user.company.catchPhrase,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text("Address: ${user.address.toString()}"),
      ],
    );
  }
}
