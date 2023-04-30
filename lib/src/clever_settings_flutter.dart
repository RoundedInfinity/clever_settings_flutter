import 'dart:async';

import 'package:clever_settings/clever_settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Class used to initiate [CleverSettings].
class CleverSettingsFlutter {
  const CleverSettingsFlutter._();

  /// Initializes `Hive` for flutter and loads the settings.
  ///
  /// Should be called one when starting the application.
  static Future<void> init() async {
    await Hive.initFlutter();
    await CleverSettings.open();
  }
}
