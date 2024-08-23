import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hobi/pages/home_page.dart';
import '../components/utils.dart';

class PreferredUserName extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  final TextEditingController editPrefferedName = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  String? userEmail;

  Uint8List? image;

  PreferredUserName() {
    // Get the currently signed-in user's email
    userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userEmail != null) {
      loadProfileData(userEmail!);
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    image = img;
    notifyListeners();
  }

  Future<String> uploadImageToStorage(String path, Uint8List file) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(path);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveProfile(BuildContext context) async {
    userNameController = editPrefferedName;
    String name = editPrefferedName.text;
    String bio = bioController.text;
    notifyListeners();
    if (userEmail != null) {
      String imageUrl = await uploadImageToStorage('profile_pics/$userEmail', image!);

      await FirebaseFirestore.instance.collection('users').doc(userEmail).set({
        'name': name,
        'bio': bio,
        'imageUrl': imageUrl,
      });

      // Clear the controllers
      editPrefferedName.clear();
      bioController.clear();

      // Notify listeners after clearing the controllers
      notifyListeners();

      // Pop the screen after saving
      Navigator.pop(context);
    }
  }

  Future<void> loadProfileData(String email) async {
    DocumentSnapshot doc =
    await FirebaseFirestore.instance.collection('users').doc(email).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      editPrefferedName.text = data['name'];
      bioController.text = data['bio'];
      // Fetch the image from the URL and convert it to Uint8List if necessary
      // image = await fetchImage(data['imageUrl']);
      notifyListeners();
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController policyNumberController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Future<String> saveFormData({
    required String email,
    required String name,
    required String phone,
    required String policyNumber,
    required String type,
    required String description,
    required String reason,
  }) async {
    await FirebaseFirestore.instance.collection('insurance_forms').doc(email).set({
      'name': name,
      'email': email,
      'phone': phone,
      'policyNumber': policyNumber,
      'type': type,
      'description': description,
      'reason': reason,
    });

    return 'Success';
  }

  void submitForm(BuildContext context) async {
    // Show a loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          nameController.text.isEmpty ||
          policyNumberController.text.isEmpty ||
          typeController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          reasonController.text.isEmpty) {
        // Close the loading dialog
        Navigator.pop(context);
        showErrorMessage('All fields are required', context);
        return;
      }



      // Show success message or navigate to login/home page
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Form saved successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  // Navigate to home or login page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on Exception {
      // Close the loading dialog
      Navigator.pop(context);

      // Show error message
      showErrorMessage('An unknown error occurred', context);
    }
  }

  void showErrorMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
