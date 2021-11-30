// import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
import 'package:admin/constants.dart';
import 'package:admin/widgets/scaffold.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:admin/widgets/buttons.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OwnContainer(
      height: 56,
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
              child: Text("User Name",
              style: TextStyle(fontSize: 16, color: Colors.black54),),
            ),
          Icon(Icons.keyboard_arrow_down),
          OwnTextButton(
            onPressed: () => {
            Navigator.pushNamed(context, '/singin')
            },
            label: 'SingIn',
          ) // TextButton(onPressed: () => {
          //   Navigator.pushNamed(context, '/login')
          // }, child: Text('LogIn')),
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
      )
    );
  }
}
