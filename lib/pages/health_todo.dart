import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../components/dialogue_box.dart';
import '../components/tiles/todo_tile.dart';
import '../db/todo_database.dart';
import '../module/nameModule.dart';

class HealthTodo extends StatefulWidget {
  const HealthTodo({super.key});

  @override
  State<HealthTodo> createState() => _HealthTodoState();
}

class _HealthTodoState extends State<HealthTodo> {

  @override
  void initState() {
    // this tells the app what it should do first on this particular page
    //if first time opening the app
    if(referencebox.get('listsOfTodos') == null){
      db.createInitialData();
    }else{
      //not first time opening the app
      db.loadData();
    }
    super.initState();
  }
  final referencebox = Hive.box('my box');
  TodoDataBase db = TodoDataBase();




  final taskController = TextEditingController();

  void checkBoxChanged(bool? value, index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
  }

  void saveTask() {
    setState(() {
      db.todoList.add([taskController.text, false]);
      taskController.clear();
      Navigator.pop(context);
    });
    db.updateDataBase();

  }

  void createNewTask(){
    showDialog(
        context: context,
        builder: (content) {
          return DialogBox(
            controller: taskController,
            onCancel: () => Navigator.pop(context),
            onSave: saveTask,
          );
        });
  }


  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PreferredUserName>(builder: (context, value, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            CircleAvatar(
              radius: 30,
              backgroundImage: value.image == null
                  ? const AssetImage('lib/images/profile.png') as ImageProvider
                  : MemoryImage(value.image!),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: const Color(0xff0076FF),
              onPressed: createNewTask,
              child: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('lib/images/todoimage.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), // Adjust opacity here
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:  Colors.black.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor:  Colors.black.withOpacity(0.4),
                      filled: true,
                      hintText: 'Search',
                      hintStyle:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Health Todos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: const Color(0xff00010C).withOpacity(0.8),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: db.todoList.length,
                      itemBuilder: (context, index) {
                        return TodoTile(
                            taskName: db.todoList[index][0],
                            taskCompleted: db.todoList[index][1],
                            onChanged: (value) => checkBoxChanged(value, index),
                            deleteFunction: (context) {
                              deleteTask(index);
                            });
                      }),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
