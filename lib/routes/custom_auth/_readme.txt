flutterfire_ui: ^0.3.0 does not support localization so that the country code of the soaking phone number can be set.
Thats way we needed copy code from library and set countryCod.

Changed file: custom_phone_input_view.dart
Added code line: final countryCode = 'AU';