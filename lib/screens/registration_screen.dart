import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // Import for spinner

class RegistrationScreen extends StatefulWidget {
  static String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String password;

  // Function to show error message to the user (Best Practice from previous steps)
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                keyboardType: TextInputType.emailAddress, // Added keyboard type hint
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your unique email'),
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
                title: 'Register', // Corrected button title
                colour: Colors.blue[700]!, // Consistent color with Log In
                onPressed: () async {
                  setState(() {
                    showSpinner=true;
                  });
                  try{
                    final newUser= await _auth.createUserWithEmailAndPassword(email: email,
                        password: password);
                    if(newUser!=null){
                      // Navigate to chat screen upon success (assuming ChatScreen.id is correct)
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } on FirebaseAuthException catch (e) { // Use specific exception handling
                    print(e.message);
                    _showErrorSnackbar(e.message ?? 'Registration failed.'); // Provide user feedback
                  } catch(e){
                    print(e);
                    _showErrorSnackbar('An unexpected error occurred.');
                  } finally {
                    // *** FIX: HIDE SPINNER HERE IN FINALLY BLOCK ***
                    setState(() {
                      showSpinner=false;
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
