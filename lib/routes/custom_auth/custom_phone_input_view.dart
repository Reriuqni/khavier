// ignore_for_file: implementation_imports

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart' hide Title;
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:flutterfire_ui/src/auth/widgets/internal/universal_button.dart';
import 'package:flutterfire_ui/src/auth/widgets/internal/title.dart';

typedef SMSCodeRequestedCallback = void Function(
  BuildContext context,
  AuthAction? action,
  Object flowKey,
  String phoneNumber,
);

typedef PhoneNumberSubmitCallback = void Function(String phoneNumber);

/// flutterfire_ui: ^0.3.0 does not support localization so that the country code of the soaking phone number can be set.
/// Thats way we needed override library`s code 'PhoneInputView' by add param 'countryCode'
class CustomPhoneInputView extends StatefulWidget {
  final FirebaseAuth? auth;
  final AuthAction? action;
  final Object flowKey;
  final SMSCodeRequestedCallback? onSMSCodeRequested;
  final PhoneNumberSubmitCallback? onSubmit;
  final WidgetBuilder? subtitleBuilder;
  final WidgetBuilder? footerBuilder;
  final String? countryCode;

  const CustomPhoneInputView({
    Key? key,
    required this.flowKey,
    this.onSMSCodeRequested,
    this.auth,
    this.action,
    this.onSubmit,
    this.subtitleBuilder,
    this.footerBuilder,
    this.countryCode,
  }) : super(key: key);

  @override
  State<CustomPhoneInputView> createState() => _CustomPhoneInputViewState();
}

class _CustomPhoneInputViewState extends State<CustomPhoneInputView> {
  final phoneInputKey = GlobalKey<PhoneInputState>();

  PhoneNumberSubmitCallback onSubmit(PhoneAuthController ctrl) =>
      (String phoneNumber) {
        if (widget.onSubmit != null) {
          widget.onSubmit!(phoneNumber);
        } else {
          ctrl.acceptPhoneNumber(phoneNumber);
        }
      };

  void _next(PhoneAuthController ctrl) {
    final number = PhoneInput.getPhoneNumber(phoneInputKey);
    if (number != null) {
      onSubmit(ctrl)(number);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = FlutterFireUILocalizations.labelsOf(context);
    final _countryCode = (widget.countryCode != null)
        ? widget.countryCode
        : Localizations.localeOf(context).countryCode;

    return AuthFlowBuilder<PhoneAuthController>(
      flowKey: widget.flowKey,
      action: widget.action,
      auth: widget.auth,
      listener: (oldState, newState, controller) {
        if (newState is SMSCodeRequested) {
          final cb = widget.onSMSCodeRequested ??
              FlutterFireUIAction.ofType<SMSCodeRequestedAction>(context)
                  ?.callback;

          cb?.call(
            context,
            widget.action,
            widget.flowKey,
            PhoneInput.getPhoneNumber(phoneInputKey)!,
          );
        }
      },
      builder: (context, state, ctrl, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Title(text: l.phoneVerificationViewTitleText),
            const SizedBox(height: 32),
            if (widget.subtitleBuilder != null)
              widget.subtitleBuilder!(context),
            if (state is AwaitingPhoneNumber || state is SMSCodeRequested) ...[
              PhoneInput(
                initialCountryCode: _countryCode!,
                onSubmit: onSubmit(ctrl),
                key: phoneInputKey,
              ),
              const SizedBox(height: 16),
              UniversalButton(
                text: l.verifyPhoneNumberButtonText,
                onPressed: () => _next(ctrl),
              ),
            ],
            if (state is AuthFailed) ...[
              const SizedBox(height: 8),
              ErrorText(exception: state.exception),
              const SizedBox(height: 8),
            ],
            if (widget.footerBuilder != null) widget.footerBuilder!(context),
          ],
        );
      },
    );
  }
}
