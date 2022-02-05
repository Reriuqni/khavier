// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGroups _$UserGroupsFromJson(Map<String, dynamic> json) => UserGroups(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      isDdeleteAvailable: json['isDdeleteAvailable'] as bool? ?? true,
      name: json['name'] as String?,
      subDomain: json['subDomain'] as String?,
      timeZone: json['timeZone'] as String?,
      primaryContactName: json['primaryContactName'] as String?,
      primaryContactMobile: json['primaryContactMobile'] as String?,
      primaryContactEmail: json['primaryContactEmail'] as String?,
      primaryContactWebsite: json['primaryContactWebsite'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      zipCode: json['zipCode'] as String?,
      defaultLanguage: json['defaultLanguage'] as String?,
      isShowLanguageOption: json['isShowLanguageOption'] as bool?,
      laguageChineseSimplified: json['laguageChineseSimplified'] as bool?,
      laguageEnglishAUS: json['laguageEnglishAUS'] as bool?,
      laguageEnglishUSA: json['laguageEnglishUSA'] as bool?,
      laguageFrench: json['laguageFrench'] as bool?,
      creditCardName: json['creditCardName'] as String?,
      creditCardNumber: json['creditCardNumber'] as String?,
      creditCardExp: json['creditCardExp'] as String?,
      creditCardCVC: json['creditCardCVC'] as String?,
      isEnableUserRegistration: json['isEnableUserRegistration'] as String?,
      loginHyperColor: json['loginHyperColor'] as String?,
      loginHyperHover: json['loginHyperHover'] as String?,
      loginLogo: json['loginLogo'] as String?,
      loginImage: json['loginImage'] as String?,
      colorToolbarIcon: json['colorToolbarIcon'] as String?,
      colorToolbarIconHover: json['colorToolbarIconHover'] as String?,
      colorToolbarHyperLink: json['colorToolbarHyperLink'] as String?,
      colorToolbarHyperLinkHover: json['colorToolbarHyperLinkHover'] as String?,
      colorToolbarBackground: json['colorToolbarBackground'] as String?,
      colorToolbarSearchText: json['colorToolbarSearchText'] as String?,
      colorToolbarSearchBorder: json['colorToolbarSearchBorder'] as String?,
      colorToolbarLogo: json['colorToolbarLogo'] as String?,
      colorBodyButton: json['colorBodyButton'] as String?,
      colorBodyButtonHover: json['colorBodyButtonHover'] as String?,
      colorBodyButtonText: json['colorBodyButtonText'] as String?,
      colorBodyButtonTextHover: json['colorBodyButtonTextHover'] as String?,
      colorBodyImage: json['colorBodyImage'] as String?,
      adminPrising:
          $enumDecodeNullable(_$AdminPricingEnumMap, json['adminPrising']) ??
              AdminPricing.Individual,
      subUserGroupLanguge: json['subUserGroupLanguge'] as String?,
      subUserGroupBranding: json['subUserGroupBranding'] as String?,
      subUserGroupBilling: json['subUserGroupBilling'] as String?,
      acn: json['acn'] as String?,
    );

Map<String, dynamic> _$UserGroupsToJson(UserGroups instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'isDdeleteAvailable': instance.isDdeleteAvailable,
      'name': instance.name,
      'subDomain': instance.subDomain,
      'timeZone': instance.timeZone,
      'primaryContactName': instance.primaryContactName,
      'primaryContactMobile': instance.primaryContactMobile,
      'primaryContactEmail': instance.primaryContactEmail,
      'primaryContactWebsite': instance.primaryContactWebsite,
      'address1': instance.address1,
      'address2': instance.address2,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'defaultLanguage': instance.defaultLanguage,
      'isShowLanguageOption': instance.isShowLanguageOption,
      'laguageChineseSimplified': instance.laguageChineseSimplified,
      'laguageEnglishAUS': instance.laguageEnglishAUS,
      'laguageEnglishUSA': instance.laguageEnglishUSA,
      'laguageFrench': instance.laguageFrench,
      'creditCardName': instance.creditCardName,
      'creditCardNumber': instance.creditCardNumber,
      'creditCardExp': instance.creditCardExp,
      'creditCardCVC': instance.creditCardCVC,
      'isEnableUserRegistration': instance.isEnableUserRegistration,
      'loginHyperColor': instance.loginHyperColor,
      'loginHyperHover': instance.loginHyperHover,
      'loginLogo': instance.loginLogo,
      'loginImage': instance.loginImage,
      'colorToolbarIcon': instance.colorToolbarIcon,
      'colorToolbarIconHover': instance.colorToolbarIconHover,
      'colorToolbarHyperLink': instance.colorToolbarHyperLink,
      'colorToolbarHyperLinkHover': instance.colorToolbarHyperLinkHover,
      'colorToolbarBackground': instance.colorToolbarBackground,
      'colorToolbarSearchText': instance.colorToolbarSearchText,
      'colorToolbarSearchBorder': instance.colorToolbarSearchBorder,
      'colorToolbarLogo': instance.colorToolbarLogo,
      'colorBodyButton': instance.colorBodyButton,
      'colorBodyButtonHover': instance.colorBodyButtonHover,
      'colorBodyButtonText': instance.colorBodyButtonText,
      'colorBodyButtonTextHover': instance.colorBodyButtonTextHover,
      'colorBodyImage': instance.colorBodyImage,
      'adminPrising': _$AdminPricingEnumMap[instance.adminPrising],
      'subUserGroupLanguge': instance.subUserGroupLanguge,
      'subUserGroupBranding': instance.subUserGroupBranding,
      'subUserGroupBilling': instance.subUserGroupBilling,
      'acn': instance.acn,
    };

const _$AdminPricingEnumMap = {
  AdminPricing.Individual: 'Individual',
  AdminPricing.Business: 'Business',
  AdminPricing.BusinessPlus: 'BusinessPlus',
  AdminPricing.Enterprise: 'Enterprise',
  AdminPricing.EnterprisePlus: 'EnterprisePlus',
};