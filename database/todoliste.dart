import 'package:hive_flutter/hive_flutter.dart';

class ToDoList {
  // --------- variables ---------
  List aufgabenListe = [];

  // wir erstellen einen Verweis zu unserer Hive-Box,
  // welche wir in der main.dart geöffnet haben
  final myToDoBox = Hive.box("toDoBox");

  // --------- methods ---------

  // Funktion zum ersten Befüllen der Aufgabenliste, bei Erststart der App
  void createInitialData() {
    aufgabenListe = [
      ["Platzhaler Aufgabe", false],
      ["Aufgabe 2", false]
    ];
  }

  // Funktion zum Befüllen der Aufgaben-Liste aus der ToDoBox
  void loadData() {
    aufgabenListe = myToDoBox.get("TODOLIST");
  }

  // Funktion zum aktualisieren der Box
  void updateDatabase() {
    myToDoBox.put("TODOLIST", aufgabenListe);
  }
}
