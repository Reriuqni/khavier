import 'package:admin/auth/config.dart';
import 'package:flutterfire_ui/auth.dart';

final providerConfigs = [
  const EmailProviderConfiguration(),
  const PhoneProviderConfiguration(),
  const GoogleProviderConfiguration(clientId: GOOGLE_CLIENT_ID),
  const AppleProviderConfiguration(),
];