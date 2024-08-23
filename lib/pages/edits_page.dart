import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobi/components/my_textfield.dart';
import 'package:provider/provider.dart';

import '../module/nameModule.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferredUserName>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 68,
                    backgroundImage: value.image == null
                        ? const AssetImage('lib/images/profile.png')
                    as ImageProvider
                        : MemoryImage(value.image!),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: 110,
                  child: IconButton(
                    onPressed: value.selectImage,
                    icon: const Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyTextField(
                controller: value.editPrefferedName,
                hintText: 'Enter Name',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyTextField(
                  controller: value.bioController,
                  hintText: 'Enter Bio',
                  obscureText: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(9)]
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff0076FF),
                    borderRadius: BorderRadius.circular(4)),
                child: TextButton(
                  onPressed: (){
                    value.saveProfile(context);
                    // Pop the screen after saving
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
