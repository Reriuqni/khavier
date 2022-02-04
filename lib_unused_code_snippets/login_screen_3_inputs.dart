import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/header.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String? _userUid;
  String? _userPhone;

  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // SharedPreferences.getInstance().then((prefs) => {
    //   setState(() {
    //     _userUid = prefs.getString('auth_uid') ?? "";
    //     _userPhone = prefs.getString('user_phone')!;
    //     // prefs.remove('user_phone');
    //   })
    // });

    _userPhone = '1';
    _userUid = '2';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('userUid: $_userUid');
    print('userPhone: $_userPhone');
    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child:
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Регистрация',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Имя и фамилия *',
                        hintText: 'Иван Иванов',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff000000),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff000000),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _nameController.clear();
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: Color(0xff000000),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      onSaved: (value) => null,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Электронная почта *',
                        hintText: 'example-mail@mail.com',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff000000),
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Color(0xff000000),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _emailController.clear();
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: Color(0xff000000),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePass,
                      decoration: InputDecoration(
                        labelText: 'Пароль*',
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Color(0xff000000),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Color(0xff000000),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePass ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xff000000),
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        // _submitForm();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Зарегестрироваться',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _submitForm() {
    // return users
    //     .doc(_userUid)
    //     .set({
    //   'name': _nameController.text,
    //   'phone': '+$_userPhone',
    //   'email': _emailController.text != null ? _emailController.text : '',
    //   'password': _passwordController.text,
    //   'uid': _userUid,
    //   'data': '{json}',
    // })
    //     .then((value) => Navigator.pushNamed(context, '/home'))
    //     .catchError((error) => print('Failed to add user: $error'));
  // }
}
