import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:my_app/domain/data_providers/local_storage/local_data_provider.dart';
import "package:my_app/styles/app_theme.dart";

part "settings_event.dart";
part "settings_state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LocalDataProvider _dataProvider;
  SettingsBloc(
    super.initialState,
    this._dataProvider,
  ) {
    on<SettingsEvent>(
      _changeTheme,
    );
  }

  void _changeTheme(SettingsEvent event, Emitter<SettingsState> emit) {
    if (event.darkTheme) {
      emit(DarkSettingsState());
      _dataProvider.saveTheme(isDark: true);
    } else {
      emit(LightSettingsState());
      _dataProvider.saveTheme(isDark: false);
    }
  }
}
