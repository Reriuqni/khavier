import 'package:admin/constants/texts.dart';
import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  const Preloader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: PROJECT_NAME,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                SizedBox(
                    width: 300,
                    child: Image.asset('images/preloader_logo.png')),
                // Padding
                Padding(padding: const EdgeInsets.only(top: 20)),
                // Cirecle
                CircularProgressIndicator(),
              ],
            ),
          ),
        ));
  }
}
