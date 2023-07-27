// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_storage_database/database/todoliste.dart';
import 'package:sizer/sizer.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // --------------- variables ------------

  // variable für die Hive-Box mit der wir arbeiten wollen
  final toDoBox = Hive.box("toDoBox");
  // Instanzierung der ToDoList()-Klasse (siehe todoliste.dart)
  ToDoList aufgaben = ToDoList();

  // --------------- methods --------------

  // funktion zum überprüfen ob liste vorhanden in box oder nicht
  // wenn nicht, dann erstellen
  // ansonsten abrufen
  void checkToDos() {
    // wenn kein "key" namens "TODOLIST" vorhanden
    if (toDoBox.get("TODOLIST") == null) {
      // dann erstellen wir ein key-value pair in der Box
      // mithilfe der vordefinierten Funktion(siehe todoliste.dart)
      aufgaben.createInitialData();
      // Ausgabe in der Konsole, als Hinweis für uns
      print("Datenbank erstmalig erstellt.");
    } else {
      // ansonsten ist ein key namens "TODOLIST" vorhanden und wir laden
      // den Value in Form einer Liste mit Hilfe von loadData() (siehe todoliste.dart)
      aufgaben.loadData();
      // Ausgabe in der Konsole, als Hinweis für uns
      print("Liste gefunden.");
    }
  }

  // Funktion zum Erstellen einer neuen Aufgabe
  void createNewTask() {
    // vordefinierte Funktion zum darstellen eines Dialogfensters (AlertDialog)
    showDialog(
      context: context,
      builder: (context) {
        // AlertDialog-Widget (vordefiniertes Popup von Flutter)
        return AlertDialog(
          content: SizedBox(
            height: 30.h,
            child: Column(
              children: [
                Text("alertdialog fenster"),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Speichern"),
                    ),
                    SizedBox(
                      width: 4.h,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Abbruch"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // bevor das stateful widget erstellt wird,
    // wird unsere Funktion ausgeführt.
    checkToDos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Funktion zum Erstellen einer neuen Aufgabe wird aufgerufen
          createNewTask();
        },
      ),
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text("ToDo's"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // mit dem ListView.builder, wollen wir unsere Aufgabenliste darstellen
              ListView.builder(
                shrinkWrap: true,
                itemCount: aufgaben.aufgabenListe.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.yellow,
                      child: Text(aufgaben.aufgabenListe[index][0]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
