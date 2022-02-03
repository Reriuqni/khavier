import 'package:flutter/material.dart';
import '../../widgets/containers.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:admin/constants/branding.dart' as branding;

class UGBranding extends StatefulWidget {
  @override
  _UGBranding createState() => _UGBranding();
}
enum EnableUser { Yes, No}

class _UGBranding extends State<UGBranding>{
  EnableUser? _enableUser = EnableUser.Yes;
  late Color LoginHyperlink;
  late Color LoginHyperlinkHover;
  late Color TopToolbarIcon;
  late Color TopToolbarIconHover;
  late Color TopToolbarHyperlink;
  late Color TopToolbarHyperlinkHover;
  late Color TopToolbarBackground;
  late Color TopToolbarSearchText;
  late Color TopToolbarSearchTextBorder;
  late Color SideToolbarHeading;
  late Color SideToolbarSubHeading;
  late Color SideToolbarSeparationBar;
  late Color SideToolbarInformation;
  late Color SideToolbarHover;
  late Color SideToolbarBackground;
  late Color BodyButton;
  late Color BodyButtonHover;
  late Color BodyButtonText;
  late Color BodyButtonTextHover;
  late Color colorSelected;

  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  final Map<ColorSwatch<Object>, String> colorsNameMap =
  <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  @override
  void initState() {
    colorSelected = Colors.cyan;
    LoginHyperlink = branding.loginHyperlink;
    LoginHyperlinkHover = branding.loginHyperlinkHover;
    TopToolbarIcon = branding.topToolbarIcon;
    TopToolbarIconHover = branding.topToolbarIconHover;
    TopToolbarHyperlink = branding.topToolbarHyperlink;
    TopToolbarHyperlinkHover = branding.topToolbarHyperlinkHover;
    TopToolbarBackground = branding.topToolbarBackground;
    TopToolbarSearchText = branding.topToolbarSearchText;
    TopToolbarSearchTextBorder = branding.topToolbarSearchTextBorder;
    SideToolbarHeading = branding.sideToolbarHeading;
    SideToolbarSubHeading = branding.sideToolbarSubHeading;
    SideToolbarSeparationBar = branding.sideToolbarSeparationBar;
    SideToolbarInformation = branding.sideToolbarInformation;
    SideToolbarHover = branding.sideToolbarHover;
    SideToolbarBackground = branding.sideToolbarBackground;
    BodyButton = branding.bodyButton;
    BodyButtonHover = branding.bodyButtonHover;
    BodyButtonText = branding.bodyButtonText;
    BodyButtonTextHover = branding.bodyButtonTextHover;
    super.initState();
  }

  double wrapGap = 200;

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Wrap(
          children: [
            Container(
              width: 350,
              padding: EdgeInsets.only(right: 30),
              child: Text('Enable User Registrations at Login:', style: TextStyle(fontSize: 18)),
            ),
            Container(
              width: 300,
              child: Row(
                children: [
                  Radio<EnableUser> (
                    value: EnableUser.No,
                    groupValue: _enableUser,
                    onChanged: (value) {
                      setState(() {
                        _enableUser = value;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Text('No'),
                  ),
                  Radio<EnableUser> (
                    value: EnableUser.Yes,
                    groupValue: _enableUser,
                    onChanged: (value) {
                      setState(() {
                        _enableUser = value;
                        print(value);
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Text('Yes'),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,),
          child: Text('Login', style: TextStyle(fontSize: 18)),
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            ColorPickerItem(
              title: 'Hyperlink (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: LoginHyperlink,
              onSelect: () {
                colorOnSelect('LoginHyperlink');
              }
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Hyperlink Hover (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: LoginHyperlinkHover,
              onSelect: () => {colorOnSelect('LoginHyperlinkHover')},
            ),
          ],
        ),
        Wrap(
          children: [
            UGBrandingImage(
                onPressed: () {},
                image: branding.loginImage,
                text: 'Logo'
            ),
            SizedBox(width: wrapGap,),
            UGBrandingImage(
                onPressed: () {},
                image: branding.loginLogo,
                text: 'Image'
                    ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,),
          child: Text('Top Toolbar', style: TextStyle(fontSize: 18)),
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Top Toolbar Icon (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: TopToolbarIcon,
                onSelect: () => colorOnSelect('TopToolbarIcon')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Top Toolbar Icon Hover (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: TopToolbarIconHover,
              onSelect: () => colorOnSelect('TopToolbarIconHover'),
            ),
          ],
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Top Toolbar Hyperlink (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: TopToolbarHyperlink,
                onSelect: () => colorOnSelect('TopToolbarIcon')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Top Toolbar Hyperlink Hover (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: TopToolbarHyperlinkHover,
              onSelect: () => colorOnSelect('TopToolbarHyperlinkHover'),
            ),
          ],
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Top Toolbar Background (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: TopToolbarBackground,
                onSelect: () => colorOnSelect('TopToolbarBackground')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Top Toolbar Search Text (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: TopToolbarSearchText,
              onSelect: () => colorOnSelect('TopToolbarSearchText'),
            ),
          ],
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Top Toolbar Search Text Border (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: TopToolbarSearchTextBorder,
                onSelect: () => colorOnSelect('TopToolbarSearchTextBorder')
            ),
            SizedBox(width: wrapGap,),
            UGBrandingImage(
                onPressed: () {},
                image: branding.topToolbarLogo,
                text: 'Logo'
                  ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,),
          child: Text('Side Toolbar', style: TextStyle(fontSize: 18)),
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Side Toolbar Heading (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: SideToolbarHeading,
                onSelect: () => colorOnSelect('SideToolbarHeading')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Side Toolbar Sub Heading (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: SideToolbarSubHeading,
              onSelect: () => colorOnSelect('SideToolbarSubHeading'),
            ),
          ],
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Side Toolbar Separation Bar (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: SideToolbarSeparationBar,
                onSelect: () => colorOnSelect('SideToolbarSeparationBar')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Side Toolbar Information (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: SideToolbarInformation,
              onSelect: () => colorOnSelect('SideToolbarInformation'),
            ),
          ],
        ),
        Wrap(
          children: [
        ColorPickerItem(
          title: 'Side Toolbar Background (color)',
          colorsNameMap: colorsNameMap,
          colorVariable: SideToolbarBackground,
          onSelect: () => colorOnSelect('SideToolbarBackground'),
        ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Side Toolbar Hover (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: SideToolbarHover,
              onSelect: () => colorOnSelect('SideToolbarHover'),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,),
          child: Text('Body', style: TextStyle(fontSize: 20)),
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Body Button (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: BodyButton,
                onSelect: () => colorOnSelect('BodyButton')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Body Button Hover (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: BodyButtonHover,
              onSelect: () => colorOnSelect('BodyButtonHover'),
            ),
          ],
        ),
        Wrap(
          children: [
            ColorPickerItem(
                title: 'Body Button Text (color)',
                colorsNameMap: colorsNameMap,
                colorVariable: BodyButtonText,
                onSelect: () => colorOnSelect('BodyButtonText')
            ),
            SizedBox(width: wrapGap,),
            ColorPickerItem(
              title: 'Body Button Text Hover (color)',
              colorsNameMap: colorsNameMap,
              colorVariable: BodyButtonTextHover,
              onSelect: () => colorOnSelect('BodyButtonTextHover'),
            ),
          ],
        ),
        UGBrandingImage(
            onPressed: () {},
            image: branding.bodyBackgroundImage,
            text: 'Image'
        ),
      ],
    );
  }

  void colorOnSelect (variable) async {
    // Store current color before we open the dialog.
    final Color colorBeforeDialog = colorSelected;
    // Wait for the picker to close, if dialog was dismissed,
    // then restore the color we had before it was opened.
    if (!(await colorPickerDialog(variable))) {
      setState(() {
        colorSelected = colorBeforeDialog;
      });
    }
  }

  Future<bool> colorPickerDialog(variable) async {
    return ColorPicker(
      enableOpacity: true,
      color: colorSelected,
      onColorChanged: (Color color) =>
      {setState(() => {
        colorSelected = color,
        setStateColorsItems(variable, colorSelected)
      }),
        print(colorSelected),
        print(308)
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
      colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      constraints:
      const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
  setStateColorsItems (variable, colorSelected) {
    if (variable == "LoginHyperlink") {
      LoginHyperlink = colorSelected;
    }
    if (variable == "LoginHyperlinkHover") {
      LoginHyperlinkHover = colorSelected;
    }
    if (variable == "TopToolbarIcon") {
      TopToolbarIcon = colorSelected;
    }
    if (variable == "TopToolbarIconHover") {
      TopToolbarIconHover = colorSelected;
    }
    if (variable == "TopToolbarHyperlink") {
      TopToolbarHyperlink = colorSelected;
    }
    if (variable == "TopToolbarHyperlinkHover") {
      TopToolbarHyperlinkHover = colorSelected;
    }
    if (variable == "TopToolbarBackground") {
      TopToolbarBackground = colorSelected;
    }
    if (variable == "TopToolbarSearchText") {
      TopToolbarSearchText = colorSelected;
    }
    if (variable == "TopToolbarSearchTextBorder") {
      TopToolbarSearchTextBorder = colorSelected;
    }
    if (variable == "SideToolbarHeading") {
      SideToolbarHeading = colorSelected;
    }
    if (variable == "SideToolbarSubHeading") {
      SideToolbarSubHeading = colorSelected;
    }
    if (variable == "SideToolbarSeparationBar") {
      SideToolbarSeparationBar = colorSelected;
    }
    if (variable == "SideToolbarInformation") {
      SideToolbarInformation = colorSelected;
    }
    if (variable == "SideToolbarHover") {
      SideToolbarHover = colorSelected;
    }
    if (variable == "SideToolbarBackground") {
      SideToolbarBackground = colorSelected;
    }
    if (variable == "BodyButton") {
      BodyButton = colorSelected;
    }
    if (variable == "BodyButtonHover") {
      BodyButtonHover = colorSelected;
    }
    if (variable == "BodyButtonText") {
      BodyButtonText = colorSelected;
    }
    if (variable == "BodyButtonTextHover") {
      BodyButtonTextHover = colorSelected;
    }
  }
}






