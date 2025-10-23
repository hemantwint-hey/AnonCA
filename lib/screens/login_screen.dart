import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // <-- ADDED IMPORT

class LoginScreen extends StatefulWidget {
  static String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;

  // State for spinner visibility
  bool showSpinner = false; // <-- ADDED STATE VARIABLE

  late String email;
  late String password;

  // Function to show error message to the user
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // *** WRAPPER ADDED ***
      body: ModalProgressHUD(
        inAsyncCall: showSpinner, // Controls spinner visibility
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 250.0,
                    child: Image.asset('images/logo1.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress, // Best practice
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your anon email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password=value;
                },
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log in',
                colour: Colors.lightBlueAccent[400]!,
                onPressed: () async {
                  setState(() {
                    showSpinner = true; // 1. Show spinner
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } on FirebaseAuthException catch(e) {
                    // 2. Error handling and user feedback
                    print(e.message);
                    _showErrorSnackbar(e.message ?? 'Login failed. Check credentials.');
                  } catch(e){
                    print(e);
                    _showErrorSnackbar('An unexpected error occurred.');
                  } finally {
                    // 3. Hide spinner regardless of outcome
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
