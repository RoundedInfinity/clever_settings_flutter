// ignore_for_file: lines_longer_than_80_chars

import 'package:clever_settings/clever_settings.dart';
import 'package:clever_settings_flutter/clever_settings_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// {@template settings_value_builder}
/// The [SettingsValueBuilder] is widget used for building widgets that depend on a [SettingsValue] object.
///
/// It rebuilds when the value of [setting] changes.
///
/// See also:
/// - [ValueListenableBuilder]
/// - [SettingsValue]
/// {@endtemplate}
class SettingsValueBuilder<T> extends StatelessWidget {
  /// {@macro settings_value_builder}
  const SettingsValueBuilder({
    required this.setting,
    required this.builder,
    this.child,
    super.key,
  });

  /// The setting that this widget listens to.
  final SettingsValue<T> setting;

  /// A [ValueListenable]-independent widget which is passed back to the [builder].
  ///
  /// See also:
  /// - [ValueListenableBuilder.child]
  final Widget? child;

  /// A builder which builds its widget depending on the value of [setting].
  ///
  /// When `setting.defaultValue` is set, `value` is never null.
  final Widget Function(BuildContext context, T? value, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T?>(
      valueListenable: setting.asListenable(),
      builder: builder,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SettingsValue<T>>('setting', setting));
  }
}

/// {@template settings_switch}
/// A [Switch.adaptive] that is driven by a settings value.
///
/// The [setting] must be of type `bool` and cannot be `null`.
/// {@endtemplate}
class SettingsSwitch extends StatelessWidget {
  /// {@macro settings_switch}
  const SettingsSwitch({
    required this.setting,
    super.key,
  });

  /// The [SettingsValue] used to control this switch.
  final SettingsValue<bool> setting;

  @override
  Widget build(BuildContext context) {
    return SettingsValueBuilder(
      setting: setting,
      builder: (context, value, child) {
        assert(
          value != null,
          '${setting.name} must have a value for the switch to work. Consider setting a defaultValue.',
        );

        return Switch.adaptive(
          value: setting.value!,
          onChanged: (value) {
            setting.value = value;
          },
        );
      },
    );
  }
}
