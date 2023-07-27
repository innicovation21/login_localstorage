// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_storage_database/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  //region -------------- variables --------------

  // Instanzieren der Shared Preferences
  final Future<SharedPreferences> meinSpeicher =
      SharedPreferences.getInstance();
  // Variable für den textfield-controller
  final _textEingabeController = TextEditingController();
  //endregion

  //region -------------- methods --------------

  // Funktion zum abspeichern des Passwortes im local storage
  Future<void> setPassword() async {
    // Variable für die Eingabe aus dem Textfield
    String newPassword = _textEingabeController.text;
    // Variable für den Speicher
    SharedPreferences speicher = await meinSpeicher;
    // Anlegen des key-value pairs im local storage
    speicher.setString("password", newPassword);
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text("Create Password"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // nachdem das Textfield in einer SizedBox gewrapped wurde,
            // können wir mit deren Hilfe die Breite des Textfields manipulieren
            SizedBox(
              width: 50.w,
              // Textfield -> Texteingabefeld
              child: TextField(
                // hier controller für das Textfield angeben
                controller: _textEingabeController,
                // decoration: InputDecoration() -> Vergleichbar mit decoration beim Container
                decoration: InputDecoration(
                  hintText: "dein Passwort",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 3,
                    ),
                  ),
                  labelText: "create password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
              onPressed: () {
                // aufrufen der funktion zum speichern des passwortes im local storage
                setPassword();
              },
              child: const Text("create password"),
            ),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: Text("zum Login"),
            ),
          ],
        ),
      ),
    );
  }
}
