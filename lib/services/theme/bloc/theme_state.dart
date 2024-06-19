part of 'theme_bloc.dart';

enum EnumThemeStatus { darkMode, lightMode }

@freezed
class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState({
    required ThemeData mode,
    required bool isDarkModel,
    required String currentStatus,
  }) = _ThemeState;

  ThemeState fromMap({
    required ThemeData mode,
    required bool isDarkModel,
    required String currentStatus,
  }) {
    return ThemeState(
      mode: mode,
      isDarkModel: isDarkModel,
      currentStatus: currentStatus,
    );
  }

  List<Object?> get props => [
        mode,
        isDarkModel,
        currentStatus,
      ];
}
