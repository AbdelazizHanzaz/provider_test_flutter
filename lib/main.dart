import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/provider/dark_notifier.dart';
import 'package:provider_app/provider/settings.dart';
import 'package:provider_app/screens/home_screen.dart';
import 'package:provider_app/screens/settings_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SettingsNotifier()),
      ChangeNotifierProvider(create: (_) => DarkNotifier())
    ],
    child: const MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      routes: {
        '/' : (context) => const HomeScreen(title: "Home"),
        SettingScreen.routeName : (context) => const SettingScreen(title: "Settings")
      },
      initialRoute: '/',
    );
  }
}

