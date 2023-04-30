# Clever Settings Flutter

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A flutter package that provides useful flutter utilities for [clever_settings](https://pub.dev/packages/clever_settings).

## Installation 💻

**❗ In order to start using Clever Settings Flutter you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Add `clever_settings_flutter` and `clever_settings` to your `pubspec.yaml`:

```yaml
dependencies:
  clever_settings:
  clever_settings_flutter:
```

Install it:

```sh
flutter packages get
```

---

## Initialization

Before you can start using Clever Settings, you need to initialize it first. Call the init function once at the start of your application:

```dart
await CleverSettingsFlutter.init();
```

This will initialize [Hive](https://pub.dev/packages/hive) and open the settings database.
If you want to configure Hive yourself, you can use `CleverSettings.open()` after initializing Hive.

## Usage 🚀

> This will only focus on the additional features of `clever_settings_flutter`. The readme for the basic usage of `clever_settings` can be found [here](https://pub.dev/packages/clever_settings).

### SettingsValueBuilder

The `SettingsValueBuilder` is a widget used for building other widgets that depend on a `SettingsValue` object. It rebuilds whenever the value of the setting changes.

Example usage:

```dart
class Settings {
  static const mySetting =
      SettingsValue<bool>(name: 'mySetting', defaultValue: true);
}

...

SettingsValueBuilder(
  setting: Settings.mySetting,
  builder: (context, value, child) {
    return Text(value.toString());
  },
),
```

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
