import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  XFile? _imageFile;
  String? _downloadURL;
  String imageName = "";
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _uploadImageToFirebase() async {
    if (_imageFile == null) return;

    final imageBytes = await _imageFile!.readAsBytes();
    final imageName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

    try {
      final ref = _storage.ref().child("images/$imageName");
      await ref.putData(imageBytes);
      final downloadURL = await ref.getDownloadURL();
      setState(() {
        _downloadURL = downloadURL;
      });
    } on FirebaseException catch (e) {
      print("Error uploading image: ${e.message}");
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
                height: 200,
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Choose Image"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadImageToFirebase,
              child: Text("Upload Image"),
            ),
            SizedBox(height: 16),
            if (_downloadURL != null) Text("Download URL: $_downloadURL"),
          ],
        ),
      ),
    );
  }
}
