import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/responsive.dart';
import '../../widgets/containers.dart';
import '../ticket/screen_arguments.dart';
import 'UGBranding.dart';
import 'package:admin/constants/globals.dart' as globals;


dynamic args;

double rowGap = 200;


class UserGroupsEdit extends StatefulWidget {
  const UserGroupsEdit({Key? key}) : super(key: key);
  @override
  _UserGroupsEdit createState() => _UserGroupsEdit();
}

class _UserGroupsEdit extends State<UserGroupsEdit>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController? _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController!.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 9,
      vsync: this,
    );
    _tabController!.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController!.index;
      });
    });
  }
  bool isAddUser = true;

  @override
  void dispose() {
    _tabController!.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List tabs = ['New User Groups', 'Primary Contact', 'Address', 'Language', 'Billing', 'Branding', 'Admin Prising', 'Sub User Group Settings', 'Custom'];
    args = ModalRoute.of(context)!.settings.arguments;

    if (args != 'newUser' && args != null) {
      args = args as ScreenArguments?;
      if (args.user != null) {
        isAddUser = false;
      }
    }

    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  colorFilter:
                  ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                  alignment: Responsive.isDesktop(context)
                      ? Alignment.topCenter
                      : Alignment.center,
                  fit: Responsive.isDesktop(context)
                      ? BoxFit.cover
                      : BoxFit.fitHeight,
                  image: AssetImage("assets/images/home.jpg"))),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: headerColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('User Groups'),
                          Row(
                            children: [
                              OwnButton(
                                  onPressed: () {
                                    // 2do: чи маєм право створювати порожнього юзера без прив'язки до uid FirebaseAuth?
                                    // Поки, що коментую рядок
                                    Navigator.pushNamed(context, '/');
                                  },
                                  label: 'Save')
                            ],
                          )
                        ],
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        tabs: [
                          for (final tab in tabs) Tab(text: tab),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [NewUserGroup()],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [UGPrimaryContact(),],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [UGAddress(),],
                        ),
                        UGLanguage(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [UGBilling(),],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [UGBranding(),],
                        ),
                        UGAdminPricing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SubUserGroupsSetting()],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabsMainContainer(
                              children: [
                                RowItem(text: 'ACN',)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              StackHeader()
            ],
          )),
    );
  }
}
class NewUserGroup extends StatefulWidget {

  @override
  State<NewUserGroup> createState() => _NewUserGroupState();
}

class _NewUserGroupState extends State<NewUserGroup> {

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        RowItem(
          label: 'Name',
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            RowItem(
              label: 'Sub Domain',
            ),
            SizedBox(width: rowGap,),
            // RowItem(
            //   label: 'TimeZone',
            // )
            Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
              child: OwnDropDown(
                hint: 'TimeZone',
                onChanged: (value) {},
                items: globals.timeZone, ),
            )
          ],
        )
      ],
    );
  }
}

class UGPrimaryContact extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Wrap(
          children: [
            RowItem(
              label: 'Name',
            ),
            SizedBox(width: rowGap,),
            RowItem(
              label: 'Email',
            ),
          ],
        ),
        Wrap(
          children: [
            RowItem(
              label: 'Mobile Phone',
            ),
            SizedBox(width: rowGap,),
            RowItem(
              label: 'Website',
            )
          ],
        )
      ],
    );
  }
}

class UGAddress extends StatefulWidget {

  @override
  State<UGAddress> createState() => _UGAddressState();
}

class _UGAddressState extends State<UGAddress> {
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Wrap(
          children: [
            RowItem(
              label: 'Street Address 1',
            ),
            SizedBox(width: rowGap,),
            RowItem(
              label: 'Street Address 2',
            ),
          ],
        ),
        Wrap(
          children: [
            Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
              child: Column(
                children: [
                  CountryStateCityPicker(
                    country: country,
                    state: state,
                    city: city,
                    textFieldInputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                          color: Color(0xFF009EAE),
                          width: 2.0),
                    ),
            ),
          ],
        ),
            ),
            SizedBox(width: rowGap,),
        RowItem(
          label: 'Zip/Post Code',
        )
      ],
        ),

      ],
    );
  }
}

class UGLanguage extends StatefulWidget {

  @override
  State<UGLanguage> createState() => _UGLanguageState();
}

class _UGLanguageState extends State<UGLanguage> with RestorationMixin {
  RestorableBoolN switchValue = RestorableBoolN(false);
  RestorableBoolN chinese = RestorableBoolN(false);
  RestorableBoolN englishAus = RestorableBoolN(false);
  RestorableBoolN englishUSA = RestorableBoolN(false);
  RestorableBoolN french = RestorableBoolN(false);

  @override
  String get restorationId => 'switch';

  @override
  void restoreState(restorationBucket, bool initialRestore) {
    registerForRestoration(switchValue, 'switch');
    registerForRestoration(chinese, 'chinese');
    registerForRestoration(englishAus, 'englishAus');
    registerForRestoration(englishUSA, 'englishUSA');
    registerForRestoration(french, 'french');
  }

  @override
  void dispose() {
    switchValue.dispose();
    chinese.dispose();
    englishAus.dispose();
    englishUSA.dispose();
    french.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          width: 300,
          child: OwnDropDown(
            hint: 'Default Language',
            onChanged: (value) {
              print(value);
              setState(() {
                englishAus.value = value == 'English (Aus)' ? true : false;
                englishUSA.value = value == 'English (USA)' ? true : false;
                chinese.value = value == 'Chinese (simplified)' ? true : false;
                french.value = value == 'French' ? true : false;
              });
            },
            items: [
              'English (Aus)',
              'English (USA)',
              'Chinese (simplified)',
              'French'
            ],
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Show Language Option at Login'),
            Switch(
                value: switchValue.value!,
                onChanged: (value) {
                  setState(() {
                    switchValue.value = value;
                  });
                }
            )
          ],
        ),
        SizedBox(height: 10,),
        Text('Other Language Options:'),
        SizedBox(height: 10,),
        Row(
          children: [
            Row(
              children: [
                Checkbox(
                    tristate: true,
                    value: chinese.value,
                    onChanged: (value) {
                      setState(() {
                        chinese.value = value;
                      });
                    }),
                SizedBox(width: 5,),
                Text('Chinese (simplified)')
              ],
            ),
            Row(
              children: [
                Checkbox(
                    tristate: true,
                    value: englishAus.value,
                    onChanged: (value) {
                      setState(() {
                        englishAus.value = value;
                      });
                    }),
                SizedBox(width: 5,),
                Text('English (Aus)')
              ],
            ),
            Row(
              children: [
                Checkbox(
                    tristate: true,
                    value: englishUSA.value,
                    onChanged: (value) {
                      setState(() {
                        englishUSA.value = value;
                      });
                    }),
                SizedBox(width: 5,),
                Text('English (USA)')
              ],
            ),
            Row(
              children: [
                Checkbox(
                    tristate: true,
                    value: french.value,
                    onChanged: (value) {
                      setState(() {
                        french.value = value;
                      });
                    }),
                SizedBox(width: 5,),
                Text('French')
              ],
            )
          ],
        )
      ],
    );
  }
}


class UGBilling extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Wrap(
          children: [
            RowItem(
              label: 'Credit Card Name',
            ),
            RowItem(
              label: 'Number',
            ),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            RowItem(
              label: 'Expiry (MM/YY)',
            ),
            RowItem(
              label: 'CVC',
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: OwnButton(
              label: 'Update',
              ),
            )
          ],
        ),
      ],
    );
  }
}

class UGAdminPricing extends StatefulWidget {
  @override
  _UGAdminPricing createState() => _UGAdminPricing();
}

enum AdminPricing { Individual, Business,  BusinessPlus, Enterprise, EnterprisePlus}

class _UGAdminPricing extends State<UGAdminPricing>{
  AdminPricing? _pricing = AdminPricing.Individual;

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
        children: [
          RadioRow(
              radioWidget: Text(''),
            textRadio: '',
            text0: r'# of Admins',
            text1: 'Monthly Fee (AUD)',
            text2: 'Annual Fee (AUD)',
            text3: 'Monthly Fee (HKD)',
          ),
          RadioRow(
            radioWidget: Radio<AdminPricing> (
              value: AdminPricing.Individual,
              groupValue: _pricing,
              onChanged: (value) {
                setState(() {
                  _pricing = value;
                  print(value);
                });
              },
            ),
            color: _pricing ==  AdminPricing.Individual ? secondaryColor : iconColor,
            textRadio: 'Individual',
            text0: '1-2',
            text1: r'$20.00',
            text2: r'$200.00',
            text3: r'$120.00',
          ),
          RadioRow(
            radioWidget: Radio<AdminPricing> (
              value: AdminPricing.Business,
              groupValue: _pricing,
              onChanged: (value) {
                setState(() {
                  _pricing = value;
                });
              },
            ),
            color: _pricing ==  AdminPricing.Business ? secondaryColor : iconColor,
            textRadio: 'Business',
            text0: '3-10',
            text1: r'$60.00',
            text2: r'$600.00',
            text3: r'$360.00',
          ),
          RadioRow(
            radioWidget: Radio<AdminPricing> (
              value: AdminPricing.BusinessPlus,
              groupValue: _pricing,
              onChanged: (value) {
                setState(() {
                  _pricing = value;
                });
              },
            ),
            color: _pricing ==  AdminPricing.BusinessPlus ? secondaryColor : iconColor,
            textRadio: 'Business Plus',
            text0: '11-25',
            text1: r'$100.00',
            text2: r'$1000.00',
            text3: r'$600.00',
          ),
          RadioRow(
            radioWidget: Radio<AdminPricing> (
              value: AdminPricing.Enterprise,
              groupValue: _pricing,
              onChanged: (value) {
                setState(() {
                  _pricing = value;
                });
              },
            ),
            color: _pricing ==  AdminPricing.Enterprise ? secondaryColor : iconColor,
            textRadio: 'Enterprise',
            text0: '26-50',
            text1: r'$150.00',
            text2: r'$1500.00',
            text3: r'$900.00',
          ),
          RadioRow(
            radioWidget: Radio<AdminPricing> (
              value: AdminPricing.EnterprisePlus,
              groupValue: _pricing,
              onChanged: (value) {
                setState(() {
                  _pricing = value;
                });
              },
            ),
            color: _pricing ==  AdminPricing.EnterprisePlus ? secondaryColor : iconColor,
            textRadio: 'Enterprise Plus',
            text0: '51-100',
            text1: r'$200.00',
            text2: r'$2000.00',
            text3: r'$1200.00',
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Charged to User Group`s Credit Card', style: TextStyle(fontWeight: FontWeight.w600),),
                SizedBox(width: 10,),
                OwnButton(label: 'Downgrade', onPressed: () {},),
                SizedBox(width: 10,),
                OwnButton(label: 'Upgrade', onPressed: () {},)
              ],
            ),
          )
        ],
    );
  }
}

class SubUserGroupsSetting extends StatefulWidget {
  @override
  _SubUserGroupsSetting createState() => _SubUserGroupsSetting();
}

class _SubUserGroupsSetting extends State<SubUserGroupsSetting>{

  List sUGSettings = <String> [
    'Sub-User Groups Cannot Change',
    'Sub-User Groups Must Enter Information',
    'Selected Sub-User Groups Must Enter Information'];

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Container(
          width: 460,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: OwnDropDown(
            hint: 'Language',
            items: sUGSettings,
            onChanged: (value) {},
          ),
        ),
        Container(
          width: 460,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: OwnDropDown(
            hint: 'Branding',
            items: sUGSettings,
            onChanged: (value) {},
          ),
        ),
        Container(
          width: 460,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: OwnDropDown(
            hint: 'Billing',
            items: sUGSettings,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}






