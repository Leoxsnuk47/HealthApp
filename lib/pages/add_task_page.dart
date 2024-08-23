import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobi/controller/task_controller.dart';
import 'package:hobi/model/task.dart';
import 'package:intl/intl.dart';

import '../components/my_textfield.dart';
import '../services/notifications_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  late NotifyHelper notifyHelper;


  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  String _endTime = '9:30 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedReminder = 5;
  final List<int> _selectedReminders = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = 'none';
  final List<String> _selectedRepeats = [
    'none',
    'daily',
    'Weekly',
    'Monthly',
  ];

  void getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2130),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }
  }

  _addTaskToDb() async{
   int value = await  _taskController.addTask(
        task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedReminder,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    ));
   print("My id is:" "$value");
  }

  _validateTask() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      //add task to database
      _addTaskToDb();
      Get.back();

    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'All fields Are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: const Icon(
          Icons.warning_amber,
          color: Colors.blue,
        ),
      );
    }
  }

  _getTimeFromUser({required bool isTimeStart}) async {
    var pickedTime = await _showTimePicker();
    String formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
      return;
    } else if (isTimeStart == true) {
      setState(() {
        _startTime = formatedTime;
      });
    } else if (isTimeStart == false) {
      setState(() {
        _endTime = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(' ')[0]),
      ),
    );
  }

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.grey.shade900,
                  // color: Color(0xFF0F4F64),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  // color: Color(0xFF0F4F64),
                ),
              ),
              MyTextField(
                controller: _titleController,
                hintText: 'Enter title here',
                obscureText: false,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'Note',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  // color: Color(0xFF0F4F64),
                ),
              ),
              MyTextField(
                controller: _noteController,
                hintText: 'Enter note here',
                obscureText: false,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  // color: Color(0xFF0F4F64),
                ),
              ),
              MyTextField(
                hintText: DateFormat.yMd().format(_selectedDate),
                obscureText: false,
                suffixIcon: IconButton(
                  onPressed: () {
                    getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                // color: Color(0xFF0F4F64),
                              ),
                            ),
                          ],
                        ),
                        MyTextField(
                          hintText: _startTime,
                          obscureText: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isTimeStart: true);
                            },
                            icon: const Icon(Icons.access_time),
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'End Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                // color: Color(0xFF0F4F64),
                              ),
                            ),
                          ],
                        ),
                        MyTextField(
                          hintText: _endTime,
                          obscureText: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _getTimeFromUser(
                                isTimeStart: false,
                              );
                            },
                            icon: const Icon(Icons.access_time_outlined),
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'Remind',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  // color: Color(0xFF0F4F64),
                ),
              ),
              MyTextField(
                hintText: '$_selectedReminder minutes early',
                obscureText: false,
                suffixIcon: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: _selectedReminders
                      .map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                        value: value.toString(), child: Text(value.toString()));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedReminder = int.parse(newValue!);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'Repeat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  // color: Color(0xFF0F4F64),
                ),
              ),
              MyTextField(
                hintText: _selectedRepeat,
                obscureText: false,
                suffixIcon: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: _selectedRepeats
                      .map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Wrap(
                        children: List<Widget>.generate(3, (int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: index == 0
                                    ? const Color(0xff3E44DF)
                                    : index == 1
                                        ? const Color(0xffFF3756)
                                        : const Color(0xffFFAD2A),
                                child: _selectedColor == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        _validateTask();
                        // notifyHelper.displayNotification(
                        //   title: 'H.O.B.I',
                        //   body: 'SCHEDULED BETWEEN $_startTime and $_endTime',
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 24),
                        decoration: BoxDecoration(
                            color: const Color(0xff1067F5),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          'Create Task',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
