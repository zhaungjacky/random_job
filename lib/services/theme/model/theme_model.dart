import 'package:flutter/material.dart';

class ThemeModel {
  final ThemeData mode;
  final bool isDarkModel;
  final String currentStatus;
  const ThemeModel({
    required this.mode,
    required this.isDarkModel,
    required this.currentStatus,
  });
  factory ThemeModel.fromJson(
    ThemeData mode,
    bool isDarkModel,
    String currentStatus,
  ) {
    return ThemeModel(
      mode: mode,
      isDarkModel: isDarkModel,
      currentStatus: currentStatus,
    );
  }
}
