// ignore_for_file: implementation_imports

import 'package:admin/routes/custom_auth/custom_phone_input_view.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';

import 'package:flutterfire_ui/src/auth/widgets/internal/universal_page_route.dart';
import 'package:flutterfire_ui/src/auth/widgets/internal/universal_button.dart';
import 'package:flutterfire_ui/src/auth/screens/internal/responsive_page.dart';

/// A screen displaying a fully styled phone number entry screen, with a country-code
/// picker.
///
/// {@subCategory service:auth}
/// {@subCategory type:screen}
/// {@subCategory description:A screen displaying a fully styled phone number entry input with a country-code picker.}
/// {@subCategory img:https://place-hold.it/400x150}
class CustomPhoneInputScreen extends StatelessWidget {
  final AuthAction? action;
  final List<FlutterFireUIAction>? actions;
  final FirebaseAuth? auth;
  final WidgetBuilder? subtitleBuilder;
  final WidgetBuilder? footerBuilder;
  final HeaderBuilder? headerBuilder;
  final double? headerMaxExtent;
  final SideBuilder? sideBuilder;
  final TextDirection? desktopLayoutDirection;
  final String? countryCode;

  const CustomPhoneInputScreen({
    Key? key,
    this.action,
    this.actions,
    this.auth,
    this.subtitleBuilder,
    this.footerBuilder,
    this.headerBuilder,
    this.headerMaxExtent,
    this.sideBuilder,
    this.desktopLayoutDirection,
    this.countryCode,
  }) : super(key: key);

  void _next(BuildContext context, AuthAction? action, Object flowKey, _) {
    Navigator.of(context).push(
      createPageRoute(
        context: context,
        builder: (_) => FlutterFireUIActions.inherit(
          from: context,
          child: SMSCodeInputScreen(
            action: action,
            flowKey: flowKey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flowKey = Object();
    final l = FlutterFireUILocalizations.labelsOf(context);

    return FlutterFireUIActions(
      actions: actions ?? [SMSCodeRequestedAction(_next)],
      child: Scaffold(
        body: ResponsivePage(
          desktopLayoutDirection: desktopLayoutDirection,
          sideBuilder: sideBuilder,
          headerBuilder: headerBuilder,
          headerMaxExtent: headerMaxExtent,
          breakpoint: 400,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomPhoneInputView(
                  auth: auth,
                  action: action,
                  subtitleBuilder: subtitleBuilder,
                  footerBuilder: footerBuilder,
                  flowKey: flowKey,
                  countryCode: countryCode,
                ),
                UniversalButton(
                  text: l.goBackButtonLabel,
                  variant: ButtonVariant.text,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
