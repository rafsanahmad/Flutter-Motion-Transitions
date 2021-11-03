/*
 * *
 *  * Created by Rafsan Ahmad on 11/3/21, 1:43 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';

enum SlowMotionSpeedSetting { normal, slow, slower, slowest }

extension AnimationSpeedSettingExtension on SlowMotionSpeedSetting {
  double get value {
    switch (this) {
      case SlowMotionSpeedSetting.normal:
        return 1.0;
      case SlowMotionSpeedSetting.slow:
        return 5.0;
      case SlowMotionSpeedSetting.slower:
        return 10.0;
      case SlowMotionSpeedSetting.slowest:
        return 15.0;
    }
  }
}

extension ThemeModeExtension on ThemeMode {
  String get name {
    switch (this) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
