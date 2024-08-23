import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  void Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;


  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withOpacity(0.4),
          ),
          child: Padding(
            padding:  const EdgeInsets.all(25.0),
            child: Row(
              children: [
                //check box
                Checkbox(
                  value: taskCompleted,
                  onChanged:onChanged,
                  activeColor: const Color(0xff0076FF),
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xff0076FF),),
                ),

                //text or taskName
                Text(taskName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  decoration: taskCompleted? TextDecoration.lineThrough: TextDecoration.none,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
