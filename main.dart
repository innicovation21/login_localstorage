import 'package:flutter/material.dart';
import 'package:login_storage_database/screens/screen1.dart';
import 'package:sizer/sizer.dart';

void main() {
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
          // Startscreen: Screen1()
          home: const Screen1(),
        );
      },
    );
  }
}
