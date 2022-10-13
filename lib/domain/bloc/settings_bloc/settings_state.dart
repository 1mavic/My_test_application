part of "settings_bloc.dart";

@immutable
abstract class SettingsState extends Equatable {
  final ThemeData theme;
  const SettingsState(this.theme);
}

class DarkSettingsState extends SettingsState {
  DarkSettingsState() : super(darkTheme);
  @override
  List<Object> get props => <Object>[theme];
}

class LightSettingsState extends SettingsState {
  LightSettingsState() : super(lightTheme);
  @override
  List<Object> get props => <Object>[theme];
}
