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

/// {@template multi_settings_value_builder}
/// The [MultiSettingsValueBuilder] is a widget used for building widgets that depend on multiple [SettingsValue] objects.
///
/// It rebuilds when the value of any of the [settings] change.
///
/// See also:
/// - [ValueListenableBuilder]
/// - [SettingsValue]
/// {@endtemplate}
class MultiSettingsValueBuilder<T> extends StatelessWidget {
  /// Creates a [MultiSettingsValueBuilder] widget.
  ///
  /// {@macro multi_settings_value_builder}
  const MultiSettingsValueBuilder({
    required this.settings,
    required this.builder,
    this.child,
    super.key,
  });

  /// A list of [SettingsValue] objects that this widget listens to.
  final List<SettingsValue<T>> settings;

  /// A builder which builds its widget depending on the values of all [settings].
  final Widget Function(BuildContext context, Widget? child) builder;

  /// A [ValueListenable]-independent widget which is passed back to the [builder].
  ///
  /// See also:
  /// - [ValueListenableBuilder.child]
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T?>>(
      valueListenable: _combineValueListenables(),
      builder: (context, value, child) => builder(context, child),
      child: child,
    );
  }

  /// Combines the [ValueListenable] objects of all [settings] into a single [ValueListenable].
  ValueListenable<List<T?>> _combineValueListenables() {
    final listenables =
        settings.map((setting) => setting.asListenable()).toList();
    return _CombinedValueListenable(listenables);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<SettingsValue<T>>('settings', settings));
  }
}

/// A [ValueNotifier] that combines the values of multiple [ValueListenable] objects into a single list.
class _CombinedValueListenable<T> extends ValueNotifier<List<T?>> {
  _CombinedValueListenable(List<ValueListenable<T?>> listenables)
      : super(List.filled(listenables.length, null)) {
    // ignore: prefer_asserts_with_message
    assert(listenables.length == value.length);

    // Register a listener that updates the value of this [_CombinedValueListenable]
    // with the current values of all [ValueListenable] objects in [listenables].
    Listenable.merge(listenables).addListener(() {
      value = listenables.map((listenable) => listenable.value).toList();
      notifyListeners();
    });
  }
}
