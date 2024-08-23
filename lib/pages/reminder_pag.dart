import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hobi/components/task_tile.dart';
import 'package:intl/intl.dart';

import '../controller/task_controller.dart';
import '../model/task.dart';
import '../services/notifications_services.dart';
import '../themes/class_theme.dart';
import 'add_task_page.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  final NotifyHelper notifyHelper = NotifyHelper(); // Create an instance of NotifyHelper


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Get.isDarkMode?Colors.grey.shade700:Colors.white,
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Today',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(() => const AddTaskPage());
                    _taskController.getTasks();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
                    decoration: BoxDecoration(
                        color: const Color(0xff1067F5),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      ' +Add Reminder',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color(0xff1067F5),
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                  itemCount: _taskController.taskList.length,
                  itemBuilder: (_, index) {
                    // print(_taskController.taskList.length);
                    Task task = _taskController.taskList[index];
                    if (task.repeat == 'Daily') {
                      DateTime date =DateFormat.jm().parse(task.startTime.toString());
                      var myTime =DateFormat('HH:mm').format(date);
                      notifyHelper.scheduledNotification(
                        int.parse(myTime.toString().split(':')[0]),
                        int.parse(myTime.toString().split(':')[1]),
                        task,
                      );
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskTile(task),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    if(task.date==DateFormat.yMd().format(_selectedDate)){
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskTile(task),
                                )
                              ],
                            ),
                          ),
                        ),
                      );

                    }else{
                      return Container();
                    }
                  });
            }),
          ),
        ],
      ),
    ));
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? darkGreyClr : Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18))),
      child: Column(
        children: [
          Container(
            height: 3,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[400],
            ),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: 'Task Completed',
                  color: primaryClr,
                  context: context,
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                ),
          _bottomSheetButton(
            label: 'Delete Task',
            color: Colors.red.shade300,
            context: context,
            onTap: () {
              _taskController.delete(task);
              Get.back();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: 'Close',
            color: Colors.transparent,
            isClose: true,
            context: context,
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    ));
  }
}

_bottomSheetButton({
  required String label,
  required Color color,
  void Function()? onTap,
  bool isClose = false,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: isClose == true ? Colors.transparent : color,
        border: Border.all(
          width: 1,
          color: isClose == true
              ? Get.isDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade400
              : color,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: isClose
              ? TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                )
              : const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
        ),
      ),
    ),
  );
}
