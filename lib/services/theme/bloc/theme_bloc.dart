import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:random_job/services/theme/light_mode.dart';
import 'package:random_job/services/theme/theme_provider.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final Themes _themeService;

  ThemeBloc(Themes themeService)
      : _themeService = themeService,
        super(
          ThemeState(
            currentStatus: lightModeString,
            mode: lightMode,
            isDarkModel: false,
          ),
        ) {
    on<InitialThemeEvent>(_init);
    on<ToggleThemeEvent>(_toggle);
  }
  _toggle(ToggleThemeEvent event, Emitter emit) async {
    await _themeService.toggleTheme();

    // await SharedModel()
    //     .setItem(SharedModel.modeKey, _themeService.currentStatus);
    emit(state.fromMap(
      mode: _themeService.currentTheme,
      isDarkModel: _themeService.isDarkModel,
      currentStatus: _themeService.currentStatus,
    ));
  }

  _init(InitialThemeEvent evvent, Emitter emit) async {
    await _themeService.init();
    emit(state.fromMap(
      mode: _themeService.currentTheme,
      isDarkModel: _themeService.isDarkModel,
      currentStatus: _themeService.currentStatus,
    ));
  }
}
