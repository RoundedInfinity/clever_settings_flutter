import 'package:clever_settings/clever_settings.dart';
import 'package:clever_settings_flutter/clever_settings_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  await CleverSettingsFlutter.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class Settings {
  static final mySetting =
      DefaultSettingsValue<bool>(name: 'mySetting', defaultValue: true);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clever Settings')),
      body: Column(
        children: [
          SettingsValueBuilder(
            setting: Settings.mySetting,
            builder: (context, value, child) {
              return Text(value.toString());
            },
          ),
          FilledButton(
            onPressed: () {
              Settings.mySetting.value = !Settings.mySetting.value;
            },
            child: const Text('Change setting'),
          ),
        ],
      ),
    );
  }
}
