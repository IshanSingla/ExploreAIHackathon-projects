import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  void signInWithGoogle() async {
    final dynamic googleUser = await GoogleSignIn().signIn();
    final dynamic googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Login createState() => Login();
}

class Login extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BackgroundChager(
          particleColor:
              const Color.fromARGB(255, 128, 128, 128).withAlpha(150),
          randColorList: const Color.fromARGB(255, 105, 105, 105),
          widget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login To InducedOfficial',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      backgroundColor: Colors.lightGreen),
                ),

                Center(
                  child: SignInButton(Buttons.Google,
                      text: "SignIn with Google",
                      onPressed: () => signInWithGoogle()),
                ),
                //     ClipOval(
                //         child: ElevatedButton(
                //             // ignore: sort_child_properties_last
                //             child: const Text("Sign in with Google",
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.bold)),
                //             onPressed: () => signInWithGoogle(),
                //             style: ElevatedButton.styleFrom(
                //                 primary: const Color.fromARGB(255, 71, 205, 102),
                //                 onPrimary: Colors.black,
                //              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(1.0)
                //                 )
                //               )
                //             )
                //         ),
                // SignInButton(Buttons.Google,
                //     text: "SignIn with Google",
                //     onPressed: () => signInWithGoogle()),
              ]),
        ));
  }

  dynamic signInWithGoogle() async {
    try {
      final dynamic googleUser = await GoogleSignIn().signIn();
      final dynamic googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
    // ignore: use_build_context_synchronously
    return Navigator.pushReplacementNamed(context, '/home');
  }
}
