import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/domain/bloc/settings_bloc/settings_bloc.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/styles/app_colors.dart";
import "package:my_app/ui/widgets/scaffold_template_widget.dart";
import "package:my_app/utils/string_extensions.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: context.localize(AppLocKeys.settings).firstToUpper(),
      settings: false,
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      context.localize(AppLocKeys.darkTheme).firstToUpper(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    checkColor: AppColors.white,
                    value: state is DarkSettingsState,
                    onChanged: (bool? value) {
                      if (value == null) {
                        return;
                      }
                      context.read<SettingsBloc>().add(
                            SettingsEvent(
                              darkTheme: value,
                            ),
                          );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
