import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // <<< ADDED

// The main function must be asynchronous to c/all Firebase.initializeApp()
void main() async { // <<< MODIFIE
  // Ensure that the widgets binding is initialized, which is necessary before async calls
  WidgetsFlutterBinding.ensureInitialized(); // <<< ADDED

  // Initialize Firebase core
  await Firebase.initializeApp(); // <<< ADDED

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
      },
    );
  }
}
