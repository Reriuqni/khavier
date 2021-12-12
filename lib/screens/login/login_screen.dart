import 'dart:ui';

import 'package:admin/constants.dart';
import 'package:admin/provider/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                fit: BoxFit.cover,
                image: NetworkImage("assets/assets/images/team.jpg"))),
        child: Center(
            child: LoginForm(
          width: 600,
          height: 300,
        )),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  final double width;
  final double height;
  String email = '';
  String password = '';
  UserProvider userProvider;

  LoginForm({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);

    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.black54.withOpacity(0.6)),
        child: Center(
          child: Container(
            width: 300,
            height: 220,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/logo2.png",
                      width: 200,
                      height: 50,
                    ),
                  ],
                ),
                // SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.teal,
                    label: Text('User ID / Email',
                        style: TextStyle(color: Colors.teal)),
                  ),
                  onChanged: (_) => email = _,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label:
                        Text('Password', style: TextStyle(color: Colors.teal)),
                  ),
                  onChanged: (_) => password = _,
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
                      onPressed: () async {
                        await userProvider.signInWithEmail(
                            email: email, password: password);
                        if (userProvider.isSigned) {
                          Navigator.pushNamed(context, "/main");
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(secondaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
