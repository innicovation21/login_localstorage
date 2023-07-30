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
  //region --------------- variables ------------

  // variable für die Hive-Box mit der wir arbeiten wollen
  final toDoBox = Hive.box("toDoBox");
  // Instanzierung der ToDoList()-Klasse (siehe todoliste.dart)
  ToDoList aufgaben = ToDoList();
  // controller für unser TextField im AlertDialog
  final _myController = TextEditingController();
  //endregion

  //region --------------- methods --------------

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
            height: 20.h,
            child: Column(
              children: [
                Text("Neue Aufgabe:"),
                SizedBox(
                  height: 3.h,
                ),
                TextField(
                  controller: _myController,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        saveNewTask();
                      },
                      child: Text("Speichern"),
                    ),
                    SizedBox(
                      width: 4.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Schliessen des AlertDialog-Fensters
                        Navigator.of(context).pop();
                      },
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

  // Funktion zum speichern einer neuen Aufgabe
  void saveNewTask() {
    setState(() {
      // Aktualisierung der ListView
      aufgaben.aufgabenListe.add([_myController.text, false]);
      // Textfield leeren
      _myController.clear();
    });
    // Aktualisierung der "TODOLIST" in der Hivebox
    aufgaben.updateDatabase();
    Navigator.of(context).pop();
  }

  // Funktion bei Veränderung der Checkbox
  void checkBoxChanged(bool? value, int index) {
    // Verändern der Checkbox selbst
    setState(() {
      // switch von true zu false oder false zu true
      aufgaben.aufgabenListe[index][1] = !aufgaben.aufgabenListe[index][1];
    });
    // updaten der in der Hivebox hinterlegten Liste
    aufgaben.updateDatabase();
  }

  // Funktion zum löschen einer Aufgabe
  void deleteTask(int index) {
    // Entfernen der Aufgabe aus der ListView
    setState(() {
      // Entfernen der Aufgabe an index der Aufgabenliste
      aufgaben.aufgabenListe.removeAt(index);
    });
    // aktualisieren der Hive-Box
    aufgaben.updateDatabase();
  }

  //endregion

  @override
  void initState() {
    // bevor das stateful widget erstellt wird,
    // wird unsere Funktion ausgeführt.
    checkToDos();
    super.initState();
    print("Einmalig Widget erstellt");
  }

  @override
  void dispose() {
    toDoBox.close();
    // beim Schließen der App und beim Verlassen des Widgets
    // wird dispose() ausgeführt.
    print("Widget wurde geschlossen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // nach der einmaligen Ausführung von initState()
    // wird die build-method bei der ersten Erstellung und anschließend
    // bei jedem setState() ausgeführt
    print("Widget wurde aktualisiert");
    return Scaffold(
      // FloatingActionButton ist das selbe Widget wie in der Example-Counter-App von Flutter
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 1.h,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.yellow,
                      child: Row(
                        // spaceBetween um eine Verteilung der Inhalte Text und Icons links und rechts darzustellen
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(aufgaben.aufgabenListe[index][0]),
                          Row(
                            children: [
                              Checkbox(
                                // per default (siehe saveNewTask()) ist dieser Wert "false"
                                value: aufgaben.aufgabenListe[index][1],
                                onChanged: (value) {
                                  // wechsel von checked/unchecked
                                  checkBoxChanged(value, index);
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  // Aufgabe soll gelöscht werden
                                  deleteTask(index);
                                },
                                icon: Icon(
                                  Icons.delete,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
