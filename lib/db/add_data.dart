import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> saveData({
    required String email,
    required String name,
    required String bio,
    required Uint8List file,
  }) async {
    String imageUrl = await uploadImageToStorage('profile_pics/$email', file);  // Save images in a folder named after the email

    await _firestore.collection('users').doc(email).set({
      'name': name,
      'bio': bio,
      'imageUrl': imageUrl,
    });

    return 'Success';
  }

  Future<String> uploadImageToStorage(String path, Uint8List file) async {
    Reference ref = _storage.ref().child(path);  // Ensure path is unique per user
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
