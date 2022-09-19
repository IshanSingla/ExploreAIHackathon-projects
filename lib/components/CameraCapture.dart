// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class CameraCapture extends StatelessWidget {
  const CameraCapture({super.key});
  dynamic _image(ImageSource imageSource, BuildContext context) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedFile == null) return null;
    // ignore: prefer_typing_uninitialized_variables
    var dataDescription;
    String imageUrl;
    try {
      TaskSnapshot task = await storageRef
          .child('images/${pickedFile.name}.png')
          .putFile(File(pickedFile.path));
      var newvar = task.ref.getDownloadURL();
      imageUrl = '$newvar';
      var response = await http.post(
        Uri.parse("http://ec2-107-23-192-152.compute-1.amazonaws.com/third"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"file": imageUrl}),
      );
      dataDescription = response.body;
      var responsecode = response.statusCode;
      dataDescription = '$dataDescription $responsecode';
    } catch (e) {
      // print(e);
      dataDescription = e;
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: Text('$dataDescription'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return pickedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              key: const Key('retake'),
              child: const Text('Photos', style: TextStyle(fontSize: 20.0)),
              onPressed: () => _image(ImageSource.gallery, context),
            )
          ]),
    );
  }
}
