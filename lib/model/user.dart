import 'package:admin/routes/roles.dart';

import '../utils.dart';

class User {
  String organization;
  // 2do: Давайте переназвемо поле accountType в role?
  Roles accountType;
  // 2do: У нас є код документа. Дублюємо в id. Подумати, може прибрати це поле?..
  String id;
  String firstName;
  String lastName;
  String password;
  String preferredOTP;
  String language;
  String country;
  String timeZone;
  String streetAddress1;
  String streetAddress2;
  String city;
  String state;
  String postCode;
  String email;
  String mobile;
  String tags;
  String liquidatorId;
  DateTime? lastSignInTime;
  DateTime? lastAccessToFirebase;

  User({
    this.organization = '',
    this.accountType = Roles.NEW_USER,
    required this.id,
    this.firstName = '',
    this.lastName = '',
    this.password = '',
    this.preferredOTP = '',
    this.language = '',
    this.country = '',
    this.timeZone = '',
    this.streetAddress1 = '',
    this.streetAddress2 = '',
    this.city = '',
    this.state = '',
    this.postCode = '',
    this.email = '',
    this.mobile = '',
    this.tags = '',
    this.liquidatorId = '',
    required this.lastSignInTime,
    required this.lastAccessToFirebase,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        organization: json['organization'],
        accountType: Roles.values.firstWhere(
            (e) => e.name == json['accountType'],
            orElse: () => Roles.ROLE_NOT_FOUND),
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        password: json['password'],
        preferredOTP: json['preferredOTP'],
        language: json['language'],
        country: json['country'],
        timeZone: json['timeZone'],
        streetAddress1: json['streetAddress1'],
        streetAddress2: json['streetAddress2'],
        city: json['city'],
        state: json['state'],
        postCode: json['postCode'],
        email: json['email'],
        mobile: json['mobile'],
        tags: json['tags'],
        liquidatorId: json['liquidatorId'],
        lastSignInTime: Utils.toDateTime(json['lastSignInTime']),
        lastAccessToFirebase: Utils.toDateTime(json['lastAccessToFirebase']),
      );

  Map<String, dynamic> toJson() => {
        'organization': organization,
        'accountType': accountType.name,
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'preferredOTP': preferredOTP,
        'language': language,
        'country': country,
        'timeZone': timeZone,
        'streetAddress1': streetAddress1,
        'streetAddress2': streetAddress2,
        'city': city,
        'state': state,
        'postCode': postCode,
        'email': email,
        'mobile': mobile,
        'tags': tags,
        'liquidatorId': liquidatorId,
        'lastSignInTime': Utils.fromDateTimeToJson(lastSignInTime),
        'lastAccessToFirebase': Utils.fromDateTimeToJson(lastAccessToFirebase),
      };
}
