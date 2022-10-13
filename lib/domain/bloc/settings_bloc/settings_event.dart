part of "settings_bloc.dart";

@immutable
class SettingsEvent {
  final bool darkTheme;

  const SettingsEvent({
    required this.darkTheme,
  });
}
