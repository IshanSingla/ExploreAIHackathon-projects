// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/background.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  Home createState() => Home();
}

class Home extends State<MainPage> {
  // data declaration
  int _selectedIndex = 1;
  List<Widget> screenParts = const [
    Text('Database',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Tree Classifier',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Tree Detector',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
  ];
  Home() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
  // dynamic _image() async {
  //   final XFile? pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (pickedFile == null) return null;
  //   return pickedFile;
  // }

  // ignore: non_constant_identifier_names
  BottomNavigationBar BotomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dataset),
          label: 'DataBase',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_location_outlined),
          label: 'Tree Classifier',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.linked_camera),
          label: 'Tree Detector',
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 37, 135, 37),
      unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final myFruit = screenParts[_selectedIndex];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: myFruit,
          backgroundColor: Colors.white,
          toolbarHeight: 60,
        ),
        body: BackgroundChager(
            particleColor:
                const Color.fromARGB(255, 128, 128, 128).withAlpha(150),
            randColorList: const Color.fromARGB(255, 105, 105, 105),
            widget: Center(child: myFruit)),
        bottomNavigationBar: BotomBar());
  }
}
