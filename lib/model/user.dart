class UserField {
  static const date = 'date';
}

class Users {
  String? organization;
  String? accountType;
  String? userId;
  String? firstName;
  String? lastName;
  String? password;
  String? preferredOTP;
  String? language;
  String? country;
  String? timeZone;
  String? streetAddress1;
  String? streetAddress2;
  String? city;
  String? state;
  String? postCode;
  String? email;
  String? mobile;
  String? tags;
  String? liquidatorId;


  Users({
    this.organization = '',
    this.accountType = '',
    this.userId = '',
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

  });

  static Users fromJson(Map<String, dynamic> json) => Users(
      organization: json['organization'],
      accountType: json['accountType'],
      userId: json['userId'],
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
  );

  Map<String, dynamic> toJson() => {
    'organization': organization,
    'accountType': accountType,
    'userId': userId,
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
  };
}

