import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation1;

  // UPDATED GRADIENT COLORS USING PROVIDED HEX CODES
  final Gradient logoGradient = LinearGradient(
    colors: [
      // Light color from the logo's border/highlight: #15f9fa
      Color(0xFF15F9FA),
      // Dark color from the logo's inner background: #2f3c68
      Color(0xFF2F3C68),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      // *** CHANGE 1: Increased main duration for logo/background animation ***
      duration: Duration(seconds: 3), // e.g., 3 seconds
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
   

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo1.png'),
                    height: animation.value * 100,
                  ),
                ),
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return logoGradient.createShader(bounds);
                    },
                    child: TypewriterAnimatedTextKit(
                      totalRepeatCount: 1, // Runs once
                      pause: Duration(milliseconds: 100), // Small pause after text
                      // *** CHANGE 2: Increased speed duration for slower typing ***
                      speed: Duration(milliseconds: 200), // e.g., 200ms per character
                      text: ['AnonCA'],
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                title: 'Log in',
                colour: Colors.lightBlueAccent[400]!,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
            ),

            RoundedButton(
              title: 'Register',
              colour: Colors.blue[700]!,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

