import 'dart:async';

import 'package:clever_settings/clever_settings.dart';
import 'package:flutter/foundation.dart';

/// Extension to SettingsValue for additional functionality in flutter.
extension SettingsValueFlutter<T> on SettingsValue<T> {
  /// Returns a [ValueListenable] that notifies when the settings value changes.
  ValueListenable<T?> asListenable() => _SettingsValueListenable(this);
}

class _SettingsValueListenable<T> extends ChangeNotifier
    implements ValueListenable<T?> {
  _SettingsValueListenable(this.setting);

  final List<VoidCallback> _listeners = [];
  StreamSubscription<T?>? _subscription;

  final SettingsValue<T> setting;

  @override
  void addListener(VoidCallback listener) {
    _subscription = setting.watch().listen((_) {
      for (final listener in _listeners) {
        listener();
      }
    });

    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);

    if (_listeners.isEmpty) {
      _subscription?.cancel();
      _subscription = null;
    }
  }

  @override
  T? get value => setting.value;
}
