import 'package:admin/screens/userGroups/manageUserGroups.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_groups.g.dart';

// @JsonSerializable(fieldRename:FieldRename.snake)
@JsonSerializable()
class UserGroups {
  String? id;
  // New User Groups
  String? name;
  String? subDomain;
  String? timeZone;
  // Primary Contact
  String? primaryContactName;
  String? primaryContactMobile;
  String? primaryContactEmail;
  String? primaryContactWebsite;
  // Address
  String? address1;
  String? address2;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  // Language
  String? defaultLanguage;
  bool? isShowLanguageOption;
  bool? laguageChineseSimplified;
  bool? laguageEnglishAUS;
  bool? laguageEnglishUSA;
  bool? laguageFrench;
  // Billing
  String? creditCardName;
  String? creditCardNumber;
  String? creditCardExp;
  String? creditCardCVC;
  // Branding: Login
  String? isEnableUserRegistration;
  String? loginHyperColor;
  String? loginHyperHover;
  String? loginLogo;
  String? loginImage;
  // Branding: Top Toolbar
  String? colorToolbarIcon;
  String? colorToolbarIconHover;
  String? colorToolbarHyperLink;
  String? colorToolbarHyperLinkHover;
  String? colorToolbarBackground;
  String? colorToolbarSearchText;
  String? colorToolbarSearchBorder;
  String? colorToolbarLogo;
  // Branding: Body
  String? colorBodyButton;
  String? colorBodyButtonHover;
  String? colorBodyButtonText;
  String? colorBodyButtonTextHover;
  String? colorBodyImage;
  // Admin Prising
  AdminPricing adminPrising;
  // Sub User Group Settings
  String? subUserGroupLanguge;
  String? subUserGroupBranding;
  String? subUserGroupBilling;
  // Custom
  String? acn;

  UserGroups({
    this.id,
    // New User Groups
    this.name,
    this.subDomain,
    this.timeZone,
    // Primary Contact
    this.primaryContactName,
    this.primaryContactMobile,
    this.primaryContactEmail,
    this.primaryContactWebsite,
    // Address
    this.address1,
    this.address2,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    // Language
    this.defaultLanguage,
    this.isShowLanguageOption,
    this.laguageChineseSimplified,
    this.laguageEnglishAUS,
    this.laguageEnglishUSA,
    this.laguageFrench,
    // Billing
    this.creditCardName,
    this.creditCardNumber,
    this.creditCardExp,
    this.creditCardCVC,
    // Branding: Login
    this.isEnableUserRegistration,
    this.loginHyperColor,
    this.loginHyperHover,
    this.loginLogo,
    this.loginImage,
    // Branding: Top Toolbar
    this.colorToolbarIcon,
    this.colorToolbarIconHover,
    this.colorToolbarHyperLink,
    this.colorToolbarHyperLinkHover,
    this.colorToolbarBackground,
    this.colorToolbarSearchText,
    this.colorToolbarSearchBorder,
    this.colorToolbarLogo,
    // Branding: Body
    this.colorBodyButton,
    this.colorBodyButtonHover,
    this.colorBodyButtonText,
    this.colorBodyButtonTextHover,
    this.colorBodyImage,
    // Admin Prising
    this.adminPrising = AdminPricing.Individual,
    // Sub User Group Settings
    this.subUserGroupLanguge,
    this.subUserGroupBranding,
    this.subUserGroupBilling,
    // Custom
    this.acn,
  });

  factory UserGroups.fromJson(Map<String, dynamic> json) =>
      _$UserGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$UserGroupsToJson(this);
}
