import 'package:get/get.dart';
import 'package:hobi/db/db_helper.dart';

import '../model/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getTasks();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //get all data from table
  void getTasks() async{
    List <Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) =>Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id)async{
    await DBHelper.update(id);
    getTasks();
  }

}
