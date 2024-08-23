import 'package:flutter/material.dart';

import 'my_buttons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff0076FF).withOpacity(0.87),
      content: SizedBox(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //textfield
            TextField(
              controller: controller,
              decoration:  InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            //save and cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Cancel task
                MyButtons(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
                const SizedBox(
                  width: 8,
                ),
                //Save task
                MyButtons(
                  text: 'Save',
                  onPressed: (){
                    if(controller.text.isEmpty){
                      Navigator.pop(context);
                    }else{
                      onSave();
                    }
                  } ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogBox2 extends StatelessWidget {
  final onCancelRetrieval;
  final onSaveRetrieval;

   const DialogBox2({super.key,required this.onCancelRetrieval,required this.onSaveRetrieval});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 140,
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //text asking if the user really want to retrieve any deleted task
           const Text('Do you want to retrieve your deleted tasks??'),

            //buttons to ask yes or no
            //yes button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtons(text: 'Yes', onPressed:onSaveRetrieval),

                const SizedBox(width: 12,),

                // No button
                MyButtons(text: 'No', onPressed: onCancelRetrieval)

              ],
            )
          ],

        ),
      ),
    );
  }
}

