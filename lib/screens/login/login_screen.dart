import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                fit: BoxFit.cover,
                image: Image.asset("images/login_screen/login.jpg").image)),
                // image: Image.asset("images/login_screen/login.png").image)),
        // Image.asset("./assets/images/login_screen/login.jpg").image)),
        // image: NetworkImage("assets/assets/images/team.jpg"))),  // цей варіант працює лише тоді, коли в картинка є в білд папці build\web\assets\assets\images
        child: Center(
            child: LoginForm(
          width: 500,
          height: 300,
        )),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  final double width;
  final double height;
  LoginForm({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.black54.withOpacity(0.6)),
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // B Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo_white.png",
                      width: 200,
                      height: 50,
                    ),
                  ],
                ),
                // E Logo
                // SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.teal,
                    label: Text('User ID / Email',
                        style: TextStyle(color: Colors.black87)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text('Password',
                        style: TextStyle(color: Colors.black87)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forgot password',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/main");
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.teal),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              // EdgeInsets.all(20))),
                              EdgeInsets.fromLTRB(30, 15, 30, 15))),
                              
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
