import 'package:face_diseases_app/Pages/setting/settingpage.dart';
import 'package:face_diseases_app/Pages/setting/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: MaterialApp(
        title: 'Face Diseases App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: SettingsPage(),
      ),
    );
  }
}
