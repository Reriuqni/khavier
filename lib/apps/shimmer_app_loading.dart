import 'package:admin/constants/colors.dart';
import 'package:admin/constants/texts.dart';
import 'package:admin/screens/main/components/manager_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    Key? key,
    this.text = 'Loading...',
    this.subText = '',
    this.isShimEnabled = true,
  }) : super(key: key);

  final String text;
  final String? subText;
  final bool isShimEnabled;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: PROJECT_NAME,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          // decorationStyle: TextDecorationStyle.wavy,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..color = Colors.blue[100]!,
                        ),
                      ),
                      enabled: isShimEnabled,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'uid: ' + (subText ?? 'no uid'),
                        style: TextStyle(
                          fontSize: 16,
                          // color: primaryColor,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DrawerListTile(
                      title: "SignOut",
                      svgSrc: "assets/icons/sign-out.svg",
                      press: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
