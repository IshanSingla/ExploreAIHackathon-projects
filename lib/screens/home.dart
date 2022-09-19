import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/background.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  Home createState() => Home();
}

class Home extends State<MainPage> {
  int _selectedIndex = 1;
  List<Widget> screenParts = const [
    Text('Index 0: Home',
        style: TextStyle(
          color: Colors.white,
        )),
    Text('Index 1: Business',
        style: TextStyle(
          color: Colors.white,
        )),
    Text('Index 2: School',
        style: TextStyle(
          color: Colors.white,
        )),
  ];

  dynamic _image() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) return null;
    return pickedFile;
  }

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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      selectedItemColor: const Color.fromARGB(255, 119, 255, 0),
      unselectedItemColor: const Color.fromARGB(255, 49, 127, 0),
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "CodaHolic",
            style:
                TextStyle(color: Color.fromARGB(255, 49, 127, 0), fontSize: 30),
          ),
          backgroundColor: Colors.black,
        ),
        body: BackgroundChnger(widget: Center(child: myFruit)),
        bottomNavigationBar: BotomBar());
  }
}
