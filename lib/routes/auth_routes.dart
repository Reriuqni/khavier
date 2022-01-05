import 'package:admin/auth/decorations.dart';
import 'package:admin/auth/provider_configs.dart';
import 'package:admin/constants/texts.dart';
import 'package:admin/screens/login/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

Map<String, WidgetBuilder> getAuthRoutes(BuildContext context) {
  return {
    '/': (context) {
      return SignInScreen(
        actions: [
          ForgotPasswordAction((context, email) {
            Navigator.pushNamed(
              context,
              '/forgot-password',
              arguments: {'email': email},
            );
          }),
          VerifyPhoneAction((context, _) {
            Navigator.pushNamed(context, '/phone');
          }),
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.pushReplacementNamed(context, '/profile');
          }),
          EmailLinkSignInAction((context) {
            Navigator.pushReplacementNamed(context, '/email-link-sign-in');
          }),
        ],
        headerBuilder: headerImage('assets/images/flutterfire_logo.png'),
        sideBuilder: sideImage('assets/images/flutterfire_logo.png'),
        subtitleBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              action == AuthAction.signIn
                  ? 'Welcome to $PROJECT_NAME! Please sign in to continue.'
                  : 'Welcome to $PROJECT_NAME! Please create an account to continue',
            ),
          );
        },
        footerBuilder: (context, action) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                action == AuthAction.signIn
                    ? 'By signing in, you agree to our terms and conditions.'
                    : 'By registering, you agree to our terms and conditions.',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
        providerConfigs: providerConfigs,
      );
    },
    '/phone': (context) {
      return PhoneInputScreen(
        actions: [
          SMSCodeRequestedAction((context, action, flowKey, phone) {
            Navigator.of(context).pushReplacementNamed(
              '/sms',
              arguments: {
                'action': action,
                'flowKey': flowKey,
                'phone': phone,
              },
            );
          }),
        ],
        headerBuilder: headerIcon(Icons.phone),
        sideBuilder: sideIcon(Icons.phone),
      );
    },
    '/sms': (context) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      return SMSCodeInputScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.of(context).pushReplacementNamed('/profile');
          })
        ],
        flowKey: arguments?['flowKey'],
        action: arguments?['action'],
        headerBuilder: headerIcon(Icons.sms_outlined),
        sideBuilder: sideIcon(Icons.sms_outlined),
      );
    },
    // '/profile': (context) {
    //   return ProfileScreen(
    //     providerConfigs: providerConfigs,
    //     actions: [
    //       SignedOutAction((context) {
    //         Navigator.pushReplacementNamed(context, '/');
    //       }),
    //     ],
    //   );
    // },
    '/profile': (context) => ProfilePage(),
    '/forgot-password': (context) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      return ForgotPasswordScreen(
        email: arguments?['email'],
        headerMaxExtent: 200,
        headerBuilder: headerIcon(Icons.lock),
        sideBuilder: sideIcon(Icons.lock),
      );
    },
  };
}
