import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CameraCapture extends StatelessWidget {
  var userDetails = FirebaseAuth.instance.currentUser;
  // ignore: use_key_in_widget_constructors
  CameraCapture() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        userDetails ??= user;
      }
      
      
    });
  }

  dynamic _image(ImageSource imageSource, BuildContext context) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: imageSource);
    final File imagefile = File(pickedFile!.path);
    // ignore: unnecessary_null_comparison
    if (imagefile == null) return null;
    // ignore: prefer_typing_uninitialized_variables
    var imageIcon = const Icon(Icons.image);

    // ignore: prefer_typing_uninitialized_variables
    var dataDescription;
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('http://ec2-107-23-192-152.compute-1.amazonaws.com'),
    );
    request.fields['uid'] = userDetails!.uid;

    request.files.add(http.MultipartFile(
        'file', imagefile.openRead(), await imagefile.length(),
        filename: p.basename(imagefile.path)));
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) async {
        var dataJson = await json.decode(value);
        if (value.contains("error")) {
          imageIcon = const Icon(Icons.backspace_outlined, color: Colors.blue);
          dataDescription = dataJson.error;
        } else {
          dataDescription = '\n\nisTree: ${dataJson["result"]}';
          dataJson["result"]
              ? imageIcon = const Icon(Icons.assignment_turned_in_outlined,
                  color: Colors.green)
              : imageIcon = const Icon(Icons.assignment_turned_in_outlined,
                  color: Colors.red);
        }
      });
    }).catchError((e) {
      dataDescription = (e);
      imageIcon = const Icon(Icons.backspace_outlined, color: Colors.red);
    });
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: imageIcon,
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(imagefile, width: 200, height: 200, fit: BoxFit.cover),
          Text('$dataDescription')
        ]),
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
    
    if (userDetails == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }

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
