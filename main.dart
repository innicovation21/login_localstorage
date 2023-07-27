// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_storage_database/screens/loginscreen.dart';
import 'package:login_storage_database/screens/screen1.dart';
import 'package:login_storage_database/screens/todoscreen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  // Initialisierung von Hive
  await Hive.initFlutter(); // Hive_flutter importieren

  // wir öffnen/erstellen eine Hive-Box, in welche wir unsere Daten ablegen können
  // (Es sind beliebig viele Boxen möglich)
  var meineHiveBox = await Hive.openBox(
      "toDoBox"); // sonst können wir nicht auf Inhalt zugreifen

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanzieren des Sizer-Packages
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          // ausblenden des debug-banners
          debugShowCheckedModeBanner: false,
          title: 'future & local storage',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ToDoScreen(),
        );
      },
    );
  }
}
