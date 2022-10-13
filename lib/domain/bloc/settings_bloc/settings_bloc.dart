import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/styles/app_theme.dart";

part "settings_event.dart";
part "settings_state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(LightSettingsState()) {
    on<SettingsEvent>(
      _changeTheme,
    );
  }

  void _changeTheme(SettingsEvent event, Emitter<SettingsState> emit) {
    if (event.darkTheme) {
      emit(DarkSettingsState());
    } else {
      emit(LightSettingsState());
    }
  }
}
