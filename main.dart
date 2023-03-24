// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:login_localstorage/screens/loginscreen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          theme: ThemeData.light(),
          home: LoginScreen(),
        );
      },
    );
  }
}
