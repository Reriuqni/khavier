// import 'package:admin/controllers/MenuController.dart';
import 'package:admin/provider/UserProvider.dart';
import 'package:admin/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'package:admin/widgets/scaffold.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      color: secondaryColor,
      child: Row(
      children: [
        // if (!Responsive.isDesktop(context))
        //   IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: context.read<MenuController>().controlMenu,
        //   ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
      )
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserPovider>(context);
    User user = userProvider.auth.currentUser;

    /// Якщо є ім'я, показуємо. Якщо немає імені, перевіряємо поле телефон. Є - показуємо, ні - 'Anonymous'.
    /// Якщо авторизація по телефону, displayName може бути null
    /// Якщо авторизація через Google, phoneNumber може буте null.
    String userName = user?.displayName ?? (user?.phoneNumber ?? 'Anonymous');

    return OwnContainer(
      height: 58,
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                userName,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          Icon(Icons.keyboard_arrow_down),
          OwnTextButton(
            onPressed: () {
              if (userProvider.isSigned) userProvider.signOut();
              Navigator.pushNamed(context, '/singin');
            },
            label: userProvider.isSigned ? 'Sing Out' : 'Sing In',
          ) 
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OwnTextFieldWithIcons(
        hintText: "Search",
        suffixIcon: OwnButtonICon(
          icon: Icons.search_sharp,
          onPressed: () {},
        ));
  }
}


/* 
// Спробував отримати картинку користувача з Гугл профайлу. На localhost видає 404
// user.photoURL                                          // 404
// userProvider.uc.additionalUserInfo.profile['picture']  // 404
// https://lh3.googleusercontent.com/a/AATXAJw932APxDbN4L1gzo_VWv_5d5SkIQACq5cHSe-r=s96-c
Container getPicture1(photoURL) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(photoURL), // localhost -> 404
      ),
    ),
  );
}
 */