import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/config/flavor_banner.dart";
import "package:my_app/domain/bloc/error_bloc/error_bloc.dart";
import "package:my_app/domain/bloc/error_bloc/error_bloc_state.dart";
import "package:my_app/domain/bloc/user_bloc/user_bloc.dart";
import "package:my_app/domain/bloc/user_bloc/user_state.dart";
import "package:my_app/domain/entity/user/user_model.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/main.dart";
import "package:my_app/ui/widgets/scaffold_template_widget.dart";
import "package:my_app/ui/widgets/user_card_widget.dart";
import "package:my_app/utils/cupertino_dialog.dart";
import "package:my_app/utils/string_extensions.dart";

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: BlocListener<ErrorBloc, ErrorState>(
        listener: (BuildContext context, ErrorState state) {
          if (state is ErrorShowState) {
            scaffoldMessengerState.currentState?.showSnackBar(
              SnackBar(
                content: Text(
                  state.error.error,
                ),
              ),
            );
          }
        },
        child: ScaffoldBodyTemplateWidget(
          appBarTitle: context.localize(AppLocKeys.userList).firstToUpper(),
          body: BlocBuilder<UserBloc, UserScreenState>(
            builder: (BuildContext context, UserScreenState state) {
              switch (state.runtimeType) {
                case UserLoadingState:
                  final UserLoadingState currentState =
                      state as UserLoadingState;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          currentState.message,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const CircularProgressIndicator.adaptive()
                      ],
                    ),
                  );
                case UserErrorState:
                  final UserErrorState currentState = state as UserErrorState;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          currentState.error,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                case UserListObtainedState:
                  return const _UserListWidget();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _UserListWidget extends StatefulWidget {
  const _UserListWidget();

  @override
  State<_UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<_UserListWidget> {
  @override
  Widget build(BuildContext context) {
    final List<User> users = context.watch<UserBloc>().users;
    return RefreshIndicator(
      onRefresh: () async {
        final bool? result = await showIosDialog<bool>(context);
        if (!mounted) {
          return;
        }
        if (result == true) {
          context.read<UserBloc>().add(GetUsersAndClearCache());
        }
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemBuilder: (BuildContext context, int index) => UserCardWidget(
          user: users[index],
          small: true,
        ),
        separatorBuilder: (_, __) => const SizedBox(
          height: 10,
        ),
        itemCount: users.length,
      ),
    );
  }
}
