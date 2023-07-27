// ignore_for_file: prefer_const_constructors
// bis abschluss von screen1 möchten wir nicht auf fehlende "const" hingewiesen werden.
// am ende sollte das ignore aufgehoben werden.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  // -------------- variables --------------
  // Instanzieren der Shared Preferences
  final Future<SharedPreferences> meinSpeicher =
      SharedPreferences.getInstance();
  // Variable für den textfield-controller
  final _textEingabeController = TextEditingController();

  // Variable als zwischenspeicher für ausgelesenen future-string
  late String localPassword;

  // -------------- methods --------------
  // Funktion zum abspeichern des Passwortes im local storage
  Future<void> setPassword() async {
    // Variable für die Eingabe aus dem Textfield
    String newPassword = _textEingabeController.text;
    // Variable für den Speicher
    SharedPreferences speicher = await meinSpeicher;
    // Anlegen des key-value pairs im local storage
    speicher.setString("password", newPassword);
  }

  // Funktion zum abrufen des Passwortes aus dem local storage
  Future<void> getPassword() async {
    // den Eintrag aus dem local storage packen wir in unsere Variable
    localPassword = await meinSpeicher.then((value) {
      // ?? -> wenn kein wert vorhanden, dann leerer String ("") <- leerer String
      return value.getString("password") ?? "";
    });
  }

  // Bereich für Initialisierungen beim Instanzieren des Widgets
  @override
  void initState() {
    super.initState();
    // nachfolgende Aktionen geschehen, wenn der Screen aufgebaut wurde
    getPassword();
    print("Objekt erstellt");
  }

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
                // übergangsweise testen, ob speicherung im local storage funktioniert hat
                print(localPassword);
              },
              child: Text("get password"),
            ),
          ],
        ),
      ),
    );
  }
}
