import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  // Database list before opening the app
  List<List<dynamic>> todoList = [];

  // Reference to the box
  late final Box referenceBox;

  // Constructor to initialize the database box
  TodoDataBase() {
    // Initialize Hive box
    referenceBox = Hive.box('my box');

    // If not the first time opening the app, load existing data
    if (referenceBox.get('listsOfTodos') != null) {
      loadData();
    } else {
      // If it's the first time opening the app, create initial data
      createInitialData();
    }
  }

  // Create initial data
  void createInitialData() {
    todoList = [
      ['Drink 8 Glasses of Water Daily:', false],
      ['Exercise for 30 Minutes Daily', false],
      ['Sleep 7-9 Hours Each Night', false],
    ];

    // Update the database with the initial data
    updateDataBase();
  }

  // Load data from the database
  void loadData() {
    todoList = referenceBox.get('listsOfTodos') ?? [];
  }

  // Update the database with the current todoList
  void updateDataBase() {
    referenceBox.put('listsOfTodos', todoList);
  }
}
