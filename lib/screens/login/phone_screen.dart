// import 'package:admin/model/model.dart';
// import 'package:admin/provider/UserProvider.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/responsive.dart';
import '../dashboard/components/header.dart';
import 'package:admin/constants.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  // Model model;
  // late UserProvider userProvider;

  ConfirmationResult? confirmationResult;
  bool _codeInput = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // model = Provider.of<Model>(context, listen: false);
    // userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      key: _scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0),
                      child: Header(),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    //Logo(),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Text(
                                        "Sign In", //S.of(context).login_register,
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 400,
                                      child: OwnTextFieldWithIcons(
                                        controller: _phoneController,
                                        labelText: "phone number", //S.of(context).hint_phone_number,
                                        hintText: '+38 123 456 6789',
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _phoneController.clear();
                                          },
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: iconColor,
                                          ),
                                        ),
                                        prefixIcon: Icons.call,
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),
                                    if (_codeInput)
                                      Container(
                                        margin: EdgeInsets.only(bottom: 15.0),
                                        width: 400,
                                        child: OwnTextFieldWithIcons(
                                          controller: _codeController,
                                          labelText: "verification code", //S.of(context).verification_code,
                                          hintText: 'XXXXXX',
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              _phoneController.clear();
                                            },
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: iconColor,
                                            ),
                                          ),
                                          prefixIcon: Icons.call,
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),

                                    OwnButton(
                                      onPressed: () {
                                        if (!_codeInput) {
                                          submitFormNumber();
                                        } else {
                                          signInWithPhoneNumber();
                                        }
                                      },
                                      label: _codeInput
                                          ? "confirm" //S.of(context).confirm
                                          : "send code",
                                    ), // SizedBox(height: 15),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    OwnButton(
                                        onPressed: () async {
                                          // UserCredential uc = await userProvider.signInWithGoogle();
                                          // if (uc != null) Navigator.pushNamed(context, '/main');
                                          //
                                          // await userProvider.signInWithGoogle();
                                          // if (userProvider.auth.currentUser != null)
                                          //   Navigator.pushNamed(context, '/main');
                                        },
                                        label: "Google Sign In"), // SizedBox(height: 15),
                                    //   InkWell(
                                    //     onTap: () {
                                    //       if (!_codeInput) {
                                    //         submitFormNumber();
                                    //       } else {
                                    //         signInWithPhoneNumber();
                                    //       }
                                    //     },
                                    //     child: Container(
                                    //       padding: EdgeInsets.all(5),
                                    //       decoration: BoxDecoration(
                                    //         border: Border.all(
                                    //           color: Colors.black54,
                                    //           width: 2,
                                    //         ),
                                    //         borderRadius: BorderRadius.circular(10),
                                    //       ),
                                    //       child: Text(
                                    //         _codeInput
                                    //             ? "confirm" //S.of(context).confirm
                                    //             : "send code", //S.of(context).send_code,
                                    //         style: TextStyle(
                                    //           color: Colors.black54,
                                    //           fontSize: 24,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void submitFormNumber() {
    if (_phoneController.text.startsWith("+")) {
      _phoneController.text = _phoneController.text.substring(1);
      print(_phoneController.text);
    }
    bool validateResult = _validatePhoneNumber(_phoneController.text);

    if (validateResult) {
      verifyPhoneNumber();
    } else {
      showSnackbar("invalid phone number"); //S.of(context).invalid_phone_number
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: Duration(seconds: 5)));
    print(message);
  }

  void verifyPhoneNumber() async {
    try {
      setState(() {
        _codeInput = true;
      });
      // confirmationResult = await  model.db.auth.signInWithPhoneNumber('+${_phoneController.text}');
      // confirmationResult = await userProvider.auth.signInWithPhoneNumber('+${_phoneController.text}');

      // await model.db.auth.verifyPhoneNumber(
      //   phoneNumber: '+${_phoneController.text}',
      //   timeout: Duration(seconds: 60),
      //   verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
      //     await model.db.auth.signInWithCredential(phoneAuthCredential);
      //     showSnackbar("auto varified"); //S.of(context).automatic_varified
      //
      //     await addPlayer(model.db.auth.currentUser!.uid);
      //     Navigator.pushNamed(context, '/home');
      //   },
      //   verificationFailed: (FirebaseAuthException authException) {
      //     showSnackbar("verification error: " + authException.message! ); //S.of(context).verification_error(authException.code, authException.message!)
      //   },
      //   codeSent: (String verificationId, int? forceResendingToken) async {
      //     showSnackbar("Code was sent"); //S.of(context).code_sent_message
      //     _verificationId = verificationId;
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {
      //     _verificationId = verificationId;
      //   },
      // );
    } catch (e) {
      showSnackbar("verification failed"); //S.of(context).verification_failed(e)
      print(e);
    }
  }

  void signInWithPhoneNumber() async {
    try {
      showSnackbar("login successful"); //S.of(context).login_successful
      //await addPlayer(user!.uid);
      Navigator.pushNamed(context, '/main');
    } catch (e) {
      showSnackbar("login failed"); //S.of(context).login_failed(e)
    }
  }

  Future<void> addPlayer(String uid) async {
    // model.db.connect();
    //
    // model.player = await model.db.getPlayer(uid);
    //
    // if (model.player == null) {
    //   model.player = Player();
    //   model.player.id = uid;
    //   model.player.uid = uid;
    //   model.player.phone = _phoneController.text;
    //   await model.db.setPlayer(model.player);
    // }
    // model.setStoredData('player', json.encode(model.player.toMap()));
  }

  bool _validatePhoneNumber(String value) {
    final _phoneExp = RegExp(r'^[0-9]{12}$');
    return _phoneExp.hasMatch(value);
  }
}
