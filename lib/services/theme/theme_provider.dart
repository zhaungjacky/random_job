import "package:flutter/material.dart";
import "package:random_job/services/services.dart";
import "package:random_job/services/theme/theme.dart";

const String lightModeString = "Light Mode";
const String darkModeString = "Dark Mode";

abstract interface class Themes {
  bool get isDarkModel;
  ThemeData get currentTheme;
  String get currentStatus;
  Future<void> init();
  Future<void> toggleTheme();
}

class ThemeService implements Themes {
  ThemeData _currentTheme = darkMode;
  bool _isDarkModel = false;
  String _currentStatus = darkModeString;
  @override
  bool get isDarkModel => _isDarkModel;
  @override
  ThemeData get currentTheme => _currentTheme;
  @override
  String get currentStatus => _currentStatus;
  final sharedModel = SharedModel();
  @override
  Future<void> init() async {
    final res = await sharedModel.getItem(SharedModel.modeKey());
    // print("current_mode: $res");
    if (res == null) {
      await sharedModel.setItem(SharedModel.modeKey(), lightModeString);
      // }
      _currentTheme = lightMode;
      _isDarkModel = false;
      _currentStatus = lightModeString;
      return;
    }
    _currentStatus = res == darkModeString ? darkModeString : lightModeString;
    _currentTheme = res == darkModeString ? darkMode : lightMode;
    _isDarkModel = res == darkModeString ? true : false;
  }

  @override
  Future<void> toggleTheme() async {
    // init();
    if (_currentTheme == darkMode) {
      // final res = await sharedModel.removeItem(SharedModel.modeKey);
      // if (res) {
      await sharedModel.setItem(SharedModel.modeKey(), lightModeString);
      // }
      _currentTheme = lightMode;
      _isDarkModel = false;
      _currentStatus = lightModeString;
    } else {
      // final res = await sharedModel.removeItem(SharedModel.modeKey());
      // if (res) {
      await sharedModel.setItem(SharedModel.modeKey(), darkModeString);
      // }
      _currentTheme = darkMode;
      _isDarkModel = true;
      _currentStatus = darkModeString;
    }
  }
}

// @riverpod
// class ThemeService extends _$ThemeService {
//   ThemeData _currentTheme = darkMode;
//   bool _isDarkModel = false;
//   String _currentStatus = darkModeString;
//   bool get isDarkModel => _isDarkModel;
//   ThemeData get currentTheme => _currentTheme;
//   String get currentStatus => _currentStatus;
//   final sharedModel = SharedModel();

//   @override
//   ThemeModel build() {
//     init();
//     return ThemeModel.fromJson(
//       _currentTheme,
//       _isDarkModel,
//       _currentStatus,
//     );
//   }

//   init() async {
//     final res = await sharedModel.getItem(SharedModel.modeKey);
//     // if (res == null) {
//     //   state = ThemeModel.fromJson(_currentTheme, _isDarkModel, _currentStatus,);
//     //   return;}
//     _currentStatus = res == darkModeString ? darkModeString : lightModeString;
//     _currentTheme = res == darkModeString ? darkMode : lightMode;
//     _isDarkModel = res == darkModeString ? true : false;
//     state = ThemeModel.fromJson(
//       _currentTheme,
//       _isDarkModel,
//       _currentStatus,
//     );
//   }

//   toggleTheme() async {
//     if (state.mode == darkMode) {
//       final res = await sharedModel.removeItem(SharedModel.modeKey);
//       if (res) {
//         await sharedModel.setItem(SharedModel.modeKey, lightModeString);
//       }
//       state = ThemeModel(
//         mode: lightMode,
//         isDarkModel: false,
//         currentStatus: lightModeString,
//       );
//     } else {
//       final res = await sharedModel.removeItem(SharedModel.modeKey);
//       if (res) {
//         await sharedModel.setItem(SharedModel.modeKey, darkModeString);
//       }
//       state = ThemeModel(
//         mode: darkMode,
//         isDarkModel: true,
//         currentStatus: darkModeString,
//       );
//     }
//   }
// }
