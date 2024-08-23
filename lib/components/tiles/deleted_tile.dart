import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeletedTile extends StatelessWidget {
  final String taskText;
  final bool taskBool;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunctionForever;
  Function(BuildContext)? restoreFunction;

  DeletedTile({
    super.key,
    required this.deleteFunctionForever,
    required this.restoreFunction,
    required this.taskText,
    required this.taskBool,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //button to delete forever
            SlidableAction(
              onPressed: deleteFunctionForever,
              icon: Icons.archive,
              backgroundColor: Colors.red.shade500,
              borderRadius: BorderRadius.circular(12),
            ),

            const SizedBox(
              width: 12,
            ),

            //button to retrieve the deleted task
            SlidableAction(
              onPressed: restoreFunction,
              icon: Icons.archive,
              backgroundColor: Colors.yellow.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.yellow,
          ),
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskBool,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              //TaskName to contain the todoText
              Text(
                taskText,
                style: TextStyle(
                  decoration: taskBool
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
