// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Instanzierung der Shared Preferences (damit wir das Package hier nutzen können)
  final Future<SharedPreferences> meinLokalerSpeicher =
      SharedPreferences.getInstance();

  late Future<String> savedInfo;

  // Future-Funktion zum einsetzen eines key-value-pairs im local storage (shared preferences)
  Future<void> setInfo() async {
    // ZwischenVariable für meinLokalerSpeicher
    final SharedPreferences speicher = await meinLokalerSpeicher;
    // Anlegen eines Key-Value pairs im lokalen Speicher
    // key MUSS immer ein String sein
    speicher.setString("testInfo", "geht immer noch");
    
    // wir müssen mit setState() darüber informieren, dass sich die Variable, 
    // welche im Text-Widget dargestellt wird, verändert hat
    setState(() {
      // der Einfachheit halber, nehmen wir die Initialisierung aus der initState()-Funktionen
      savedInfo = meinLokalerSpeicher.then((SharedPreferences value) {
        // ?? "" <- wenn nichts vorhanden, dann leeren String wiedergeben
        return value.getString("testInfo") ?? "";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // unserer Hilfsvariable wird der Value aus unserem key-value pair im lokalen Speicher zugewiesen

    savedInfo = meinLokalerSpeicher.then((SharedPreferences value) {
      // ?? "" <- wenn nichts vorhanden, dann leeren String wiedergeben
      return value.getString("testInfo") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            //FUTUREBUILDER
            FutureBuilder<String>(
                future: savedInfo, //Quelle aus der heraus gebaut werden soll)
                builder: ((context, snapshot) {
                  // snapshot = daten aus dem FutureBuilder-Attribut: 'future'
                  if (snapshot.data != "") {
                    // wenn Daten vorhande, dann die Daten in einem Text-Widget ausgeben
                    return Text(snapshot.data.toString());
                  } else {
                    // wenn Daten noch nicht vorhanden, dann folgendes als Ersatz
                    return Text("keine Informationen vorhanden");
                  }
                })),
            SizedBox(
              height: 5.h,
            ),
            ElevatedButton(onPressed: setInfo, child: Text("set info")),
          ],
        ),
      ),
    );
  }
}
