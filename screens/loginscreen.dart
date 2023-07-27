// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_storage_database/screens/todoscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //region --------- Variables -----------

  // Instanzieren der Shared Preferences
  final Future<SharedPreferences> meinSpeicher =
      SharedPreferences.getInstance();
  // Variable für den textfield-controller
  final _myController = TextEditingController();
  // Hilfsvariable für das Bestimmen, ob Texteingabe sichtbar sein soll oder nicht
  bool noVisibility = true;

  // Variable als zwischenspeicher für ausgelesenen future-string
  late String localPassword;

  //endregion

  //region ----------- Methods ------------

  // Funktion zum abrufen des Passwortes aus dem local storage
  Future<void> getPassword() async {
    // den Eintrag aus dem local storage packen wir in unsere Variable
    localPassword = await meinSpeicher.then((value) {
      // ?? -> wenn kein wert vorhanden, dann leerer String ("") <- leerer String
      return value.getString("password") ?? "default";
    });
  }

  // Funktion zum Vergleichen des hinterlegten Passworts im local Storage
  // mit Inhalt des Eingabefeldes
  void login() {
    // Zwischenvariable für Inhalt der Texteingabe
    String inputText = _myController.text;

    // wenn eingabefeld einen Inhalt hat
    if (inputText.isNotEmpty) {
      // wenn texteingabe mit abgespeicherten inhalt übereinstimmt
      if (inputText == localPassword) {
        // dann weiter zum todoscreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ToDoScreen();
            },
          ),
        );
      } else {
        // temporärer Hinweis am unteren Bildschirmrand
        // wenn passwort falsch
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Passwort inkorrekt",
            ),
          ),
        );
      }
    } else {
      // temporärer Hinweis wenn nichts eingegeben wurde:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Bitte Passwort eingeben.",
          ),
        ),
      );
    }
  }

  // Bereich für Initialisierungen beim Instanzieren des Widgets
  @override
  void initState() {
    // nachfolgende Aktionen geschehen, wenn der Screen aufgebaut wurde
    getPassword();
    super.initState();
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              color: Colors.black,
              // Textfield
              child: TextField(
                obscureText: noVisibility,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                controller: _myController,
                decoration: InputDecoration(
                  labelText: "password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        // "kippschalter" für sichtbarkeit des inputs
                        if (noVisibility) {
                          noVisibility = false;
                        } else {
                          noVisibility = true;
                        }
                      });
                    },
                    icon: Icon(Icons.visibility),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            // Loginbutton
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
