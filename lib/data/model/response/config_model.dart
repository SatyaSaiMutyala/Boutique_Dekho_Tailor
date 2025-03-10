class ConfigModel {
  String? responseCode;
  String? message;
  Content? content;


  ConfigModel({String? responseCode, String? message, Content? content, List<void>? errors}) {
    if (responseCode != null) {
      responseCode = responseCode;
    }
    if (message != null) {
      message = message;
    }
    if (content != null) {
      content = content;
    }

  }
  ConfigModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? Content.fromJson(json['content']) : null;

  }
}

class Content {
  int? _commissionBasePlan;
  int? _subscriptionBasePlan;
  int? _subscriptionFreeTrial;
  int? _subscriptionFreeTrailPeriod;
  String? _subscriptionFreeTrailType;
  int? _subscriptionDeadlineWarning;
  int? _providerCanCancelBooking;
  int? _providerCanEditBooking;
  String? _currencySymbolPosition;
  int? _providerSelfRegistration;
  String? _businessName;
  String? _logo;
  String? _logoFullPath;
  String? _favicon;
  String? _faviconFullPath;
  String? _countryCode;
  String? _businessAddress;
  String? _businessPhone;
  String? _businessEmail;
  String? _baseUrl;
  String? _currencyCode;
  String? _aboutUs;
  String? _privacyPolicy;
  String? _termsAndConditions;
  String? _refundPolicy;
  String? _returnPolicy;
  String? _cancellationPolicy;
  DefaultLocation? _defaultLocation;
  String? _appUrlAndroid;
  String? _appUrlIos;
  //String? _imageBaseUrl;
  int? _paginationLimit;
  String? _timeFormat;
  String? _currencyDecimalPoint;
  String? _defaultCommission;
  AdminDetails? _adminDetails;
  String? _footerText;
  MinimumVersion? _minimumVersion;
  double? _minimumWithdrawAmount;
  double? _minimumPayableAmount;
  double? _maximumWithdrawAmount;
  int? _showPhoneNumber;
  int? _bidOfferVisibilityForProvider;
  int? _biddingStatus;
  int? _emailVerification;
  int? _phoneVerification;
  int? _sendOtpTimer;
  String? _forgetPasswordVerificationMethod;
  int? _bookingOtpVerification;
  int? _bookingImageVerification;
  String? _additionalChargeLabelName;
  int? _providerServicemanCanCancelBooking;
  int? _providerServicemanCanEditBooking;
  int? _providerSelfDelete;
  double? _maxCashInHandLimit;
  int? _suspendOnCashInHandLimit;
  String? _currencySymbol;
  List<DigitalPaymentMethod>? _paymentMethodList;
  List<Language>? _languageList;


  Content({
    int? commissionBasePlan,
    int? subscriptionBasePlan,
    int? subscriptionFreeTrial,
    int? subscriptionFreeTrailPeriod,
    String? subscriptionFreeTrailType,
    int? subscriptionDeadlineWarning,
    int? providerCanCancelBooking,
    int? providerCanEditBooking,
    String? currencySymbolPosition,
    int? providerSelfRegistration,
    String? businessName,
    String? logo,
    String? logoFullPath,
    String? favicon,
    String? faviconFullPath,
    String? countryCode,
    String? businessAddress,
    String? businessPhone,
    String? businessEmail,
    String? baseUrl,
    String? currencyCode,
    String? aboutUs,
    String? privacyPolicy,
    String? termsAndConditions,
    String? refundPolicy,
    String? returnPolicy,
    String? cancellationPolicy,
    DefaultLocation? defaultLocation,
    String? appUrlAndroid,
    String? appUrlIos,
    int? emailVerification,
    int? phoneVerification,
    //String? imageBaseUrl,
    int? paginationLimit,
    String? timeFormat,
    String? currencyDecimalPoint,
    String? defaultCommission,
    AdminDetails? adminDetails,
    String? footerText,
    MinimumVersion? minimumVersion,
    double? minimumWithdrawAmount,
    double? minimumPayableAmount,
    double? maximumWithdrawAmount,
    int? showPhoneNumber,
    int? bidOfferVisibilityForProvider,
    int? biddingStatus,
    int? sendOtpTimer,
    String? forgetPasswordVerificationMethod,
    int? bookingOtpVerification,
    int? bookingImageVerification,
    String? additionalChargeLabelName,
    int? providerServicemanCanCancelBooking,
    int? providerServicemanCanEditBooking,
    int? providerSelfDelete,
    double? maxCashInHandLimit,
    int? suspendOnCashInHandLimit,
    String? currencySymbol,
    List<DigitalPaymentMethod>? paymentMethodList,
    List<Language>? languageList,
  }) {
    if (commissionBasePlan != null) {
      _commissionBasePlan = commissionBasePlan;
    }
    if (subscriptionBasePlan != null) {
      _subscriptionBasePlan= subscriptionBasePlan;
    }

    if (subscriptionFreeTrial != null) {
      _subscriptionFreeTrial = subscriptionFreeTrial;
    }
    if (subscriptionFreeTrailPeriod != null) {
      _subscriptionFreeTrailPeriod = subscriptionFreeTrailPeriod;
    }
    if (subscriptionFreeTrailType != null) {
      _subscriptionFreeTrailType = subscriptionFreeTrailType;
    }
    if (subscriptionDeadlineWarning != null) {
      _subscriptionDeadlineWarning = subscriptionDeadlineWarning;
    }
    if (providerCanCancelBooking != null) {
      _providerCanCancelBooking = providerCanCancelBooking;
    }
    if (providerCanCancelBooking != null) {
      _providerCanEditBooking = providerCanEditBooking;
    }
    if (currencySymbolPosition != null) {
      _currencySymbolPosition = currencySymbolPosition;
    }
    if (providerSelfRegistration != null) {
      _providerSelfRegistration = providerSelfRegistration;
    }
    if (businessName != null) {
      _businessName = businessName;
    }
    if (logo != null) {
      _logo = logo;
    }
    if (logoFullPath != null) {
      _logoFullPath = logoFullPath;
    }
    if (favicon != null) {
      _favicon = favicon;
    }
    if (faviconFullPath != null) {
      _faviconFullPath = faviconFullPath;
    }
    if (countryCode != null) {
      _countryCode = countryCode;
    }
    if (businessAddress != null) {
      _businessAddress = businessAddress;
    }
    if (businessPhone != null) {
      _businessPhone = businessPhone;
    }
    if (businessPhone != null) {
      _businessEmail = businessEmail;
    }
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }
    if (currencyCode != null) {
      _currencyCode = currencyCode;
    }
    if (aboutUs != null) {
      _aboutUs = aboutUs;
    }
    if (privacyPolicy != null) {
      _privacyPolicy = privacyPolicy;
    }
    if (termsAndConditions != null) {
      _termsAndConditions = termsAndConditions;
    }
    if (refundPolicy != null) {
      _refundPolicy = refundPolicy;
    }
    if (returnPolicy != null) {
      _returnPolicy = returnPolicy;
    }
    if (cancellationPolicy != null) {
      _cancellationPolicy = cancellationPolicy;
    }
    if (defaultLocation != null) {
      _defaultLocation = defaultLocation;
    }
    if (appUrlAndroid != null) {
      _appUrlAndroid = appUrlAndroid;
    }
    if (appUrlIos != null) {
      _appUrlIos = appUrlIos;
    }
    if (emailVerification != null) {
      _emailVerification = emailVerification;
    }
    if (phoneVerification != null) {
      _phoneVerification = phoneVerification;
    }
    // if (imageBaseUrl != null) {
    //   _imageBaseUrl = imageBaseUrl;
    // }
    if (paginationLimit != null) {
      _paginationLimit = paginationLimit;
    }

    if (timeFormat != null){
      _timeFormat = timeFormat;
    }

    if (currencyDecimalPoint != null) {
      _currencyDecimalPoint = currencyDecimalPoint;
    }

    if (defaultCommission != null) {
      _defaultCommission = defaultCommission;
    }

    if (adminDetails != null) {
      _adminDetails = adminDetails;
    }

    if (minimumVersion != null) {
      _minimumVersion = minimumVersion;
    }

    if (footerText != null) {
      _footerText = footerText;
    }

    if (minimumWithdrawAmount != null) {
      _minimumWithdrawAmount = minimumWithdrawAmount;
    }
    if (minimumPayableAmount != null) {
      _minimumPayableAmount = minimumPayableAmount;
    }
    if (maximumWithdrawAmount != null) {
      _maximumWithdrawAmount = maximumWithdrawAmount;
    }
    if (showPhoneNumber != null) {
      _showPhoneNumber = showPhoneNumber;
    }

    if (bidOfferVisibilityForProvider != null) {
      _bidOfferVisibilityForProvider = bidOfferVisibilityForProvider;
    }
    if (biddingStatus != null) {
      _biddingStatus = biddingStatus;
    }

    if (sendOtpTimer != null) {
      _sendOtpTimer = sendOtpTimer;
    }
    if (forgetPasswordVerificationMethod != null) {
      _forgetPasswordVerificationMethod = forgetPasswordVerificationMethod;
    }

    if (bookingOtpVerification != null) {
      _bookingOtpVerification = bookingOtpVerification;
    }

    if (bookingImageVerification != null) {
      _bookingImageVerification = bookingImageVerification;
    }
    if (additionalChargeLabelName!= null) {
      _additionalChargeLabelName = additionalChargeLabelName;
    }

    if (providerServicemanCanCancelBooking != null) {
      _providerServicemanCanCancelBooking = providerServicemanCanCancelBooking;
    }

    if (_providerServicemanCanEditBooking != null) {
      _providerServicemanCanEditBooking = providerServicemanCanEditBooking;
    }
    if (_providerSelfDelete != null) {
      _providerSelfDelete = providerSelfDelete;
    }
     if(maxCashInHandLimit != null) {
       _maxCashInHandLimit = maxCashInHandLimit;
     }
     if(suspendOnCashInHandLimit != null) {
       _suspendOnCashInHandLimit = suspendOnCashInHandLimit;
     }
    if(currencySymbol != null) {
      _currencySymbol = currencySymbol;
    }

    if ( paymentMethodList!= null) {
      _paymentMethodList = paymentMethodList;
    }
    if ( languageList != null) {
      _languageList = languageList;
    }

  }
  int? get commissionBasePlan => _commissionBasePlan;
  int? get subscriptionBasePlan => _subscriptionBasePlan;
  int? get subscriptionFreeTrail => _subscriptionFreeTrial;
  int? get subscriptionFreeTrailPeriod => _subscriptionFreeTrailPeriod;
  String ? get subscriptionFreeTrailType => _subscriptionFreeTrailType;
  int? get subscriptionDeadlineWarning => _subscriptionDeadlineWarning;
  int? get providerCanCancelBooking => _providerCanCancelBooking;
  int? get providerCanEditBooking => _providerCanEditBooking;
  String? get currencySymbolPosition => _currencySymbolPosition;
  int? get providerSelfRegistration => _providerSelfRegistration;
  String? get businessName => _businessName;
  String? get logo => _logo;
  String? get logoFullPath => _logoFullPath;
  String? get favicon => _favicon;
  String? get faviconFullPath => _faviconFullPath;
  String? get countryCode => _countryCode;
  String? get businessAddress => _businessAddress;
  String? get businessPhone => _businessPhone;
  String? get businessEmail => _businessEmail;
  String? get baseUrl => _baseUrl;
  String? get currencyCode => _currencyCode;
  String? get aboutUs => _aboutUs;
  String? get privacyPolicy => _privacyPolicy;
  String? get termsAndConditions => _termsAndConditions;
  String? get refundPolicy => _refundPolicy;
  String? get returnPolicy => _returnPolicy;
  String? get cancellationPolicy => _cancellationPolicy;
  DefaultLocation? get defaultLocation => _defaultLocation;
  String? get appUrlAndroid => _appUrlAndroid;
  String? get appUrlIos => _appUrlIos;
  int? get emailVerification => _emailVerification;
  int? get phoneVerification => _phoneVerification;
  //String? get imageBaseUrl => _imageBaseUrl;
  int? get paginationLimit => _paginationLimit;
  String? get timeFormat => _timeFormat;
  String? get currencyDecimalPoint => _currencyDecimalPoint;
  String? get defaultCommission => _defaultCommission;
  AdminDetails? get adminDetails => _adminDetails;
  MinimumVersion? get minimumVersion => _minimumVersion;
  String? get footerText => _footerText;
  double? get minimumWithdrawAmount => _minimumWithdrawAmount;
  double? get minimumPayableAmount => _minimumPayableAmount;
  double? get maximumWithdrawAmount => _maximumWithdrawAmount;
  int? get showPhoneNumber => _showPhoneNumber;
  int? get bidOfferVisibilityForProvider => _bidOfferVisibilityForProvider;
  int? get biddingStatus => _biddingStatus;
  int? get sendOtpTimer => _sendOtpTimer;
  String? get forgetPasswordVerificationMethod => _forgetPasswordVerificationMethod;
  int? get bookingOtpVerification => _bookingOtpVerification;
  int? get bookingImageVerification => _bookingImageVerification;
  String ? get additionalChargeLabelName => _additionalChargeLabelName;
  int? get providerServicemanCanCancelBooking => _providerServicemanCanCancelBooking;
  int? get providerServicemanCanEditBooking => _providerServicemanCanEditBooking;
  int? get providerSlfDelete => _providerSelfDelete;
  double? get maxCashInHandLimit => _maxCashInHandLimit;
  int? get suspendOnCashInHandLimit => _suspendOnCashInHandLimit;
  String? get currencySymbol => _currencySymbol;
  List<DigitalPaymentMethod>? get paymentMethodList => _paymentMethodList;
  List<Language>? get languageList => _languageList;



  Content.fromJson(Map<String, dynamic> json) {
    _commissionBasePlan = int.tryParse(json['commission_base'].toString());
    _subscriptionBasePlan = int.tryParse(json['subscription_base'].toString());
    _subscriptionFreeTrial = int.tryParse(json['free_trial_status'].toString());
    _subscriptionFreeTrailPeriod = int.tryParse(json['free_trial_period'].toString());
    _subscriptionFreeTrailType = json['free_trial_type'];
    _subscriptionDeadlineWarning = int.tryParse(json['deadline_warning'].toString());
    _providerCanCancelBooking = int.tryParse(json['provider_can_cancel_booking'].toString());
    _providerCanEditBooking = int.tryParse(json['provider_can_edit_booking'].toString());
    _currencySymbolPosition = json['currency_symbol_position'];
    _providerSelfRegistration = int.tryParse(json['provider_self_registration'].toString());
    _businessName = json['business_name'];
    _logo = json['logo'];
    _logoFullPath = json['logo_full_path'];
    _favicon = json['favicon'];
    _faviconFullPath = json['favicon_full_path'];
    _countryCode = json['country_code'];
    _businessAddress = json['business_address'];
    _businessPhone = json['business_phone'];
    _businessEmail = json['business_email'];
    _baseUrl = json['base_url'];
    _currencyCode = json['currency_code'];
    _aboutUs = json['about_us'];
    _privacyPolicy = json['privacy_policy'];
    _termsAndConditions = json['terms_and_conditions'];
    _refundPolicy = json['refund_policy'];
    _returnPolicy = json['return_policy'];
    _cancellationPolicy = json['cancellation_policy'];
    _defaultLocation = json['default_location'] != null ? DefaultLocation.fromJson(json['default_location']) : null;
    _appUrlAndroid = json['app_url_android'];
    _appUrlIos = json['app_url_ios'];
    _emailVerification = json['email_verification'];
    _phoneVerification = json['phone_verification'];
    //_imageBaseUrl = json['image_base_url'];
    _paginationLimit = json['pagination_limit'];
    _timeFormat = json['time_format'];
    _currencyDecimalPoint = json['currency_decimal_point'];
    _defaultCommission = json['default_commission'];
    _adminDetails = json['admin_details'] != null ? AdminDetails.fromJson(json['admin_details']) : null;
    _minimumVersion = json['min_versions'] != null ? MinimumVersion.fromJson(json['min_versions']) : null;
    _footerText = json['footer_text'];
    _minimumWithdrawAmount = double.tryParse(json['minimum_withdraw_amount'].toString());
    _minimumPayableAmount = double.tryParse(json['min_payable_amount'].toString());
    _maximumWithdrawAmount = double.tryParse(json['maximum_withdraw_amount'].toString());
    _showPhoneNumber = int.tryParse(json['phone_number_visibility_for_chatting'].toString());
    _bidOfferVisibilityForProvider = int.tryParse(json['bid_offers_visibility_for_providers'].toString());
    _biddingStatus = int.tryParse(json['bidding_status'].toString());
    _sendOtpTimer = int.tryParse(json['otp_resend_time'].toString());
    _forgetPasswordVerificationMethod = json['forget_password_verification_method'];
     _bookingOtpVerification = int.tryParse(json['booking_otp_verification'].toString());
    _bookingImageVerification = int.tryParse(json['service_complete_photo_evidence'].toString());
    _additionalChargeLabelName = json['additional_charge_label_name'];
    _providerServicemanCanCancelBooking= int.tryParse(json['provider_serviceman_can_cancel_booking'].toString());
    _providerServicemanCanEditBooking = int.tryParse(json['provider_serviceman_can_edit_booking'].toString());
    _providerSelfDelete = int.tryParse(json['provider_self_delete'].toString());
    _maxCashInHandLimit = double.tryParse(json['max_cash_in_hand_limit_provider'].toString());
    _suspendOnCashInHandLimit = int.tryParse(json['suspend_on_exceed_cash_limit_provider'].toString());
    _currencySymbol = json['currency_symbol'];
    if (json['payment_gateways'] != null) {
      _paymentMethodList = <DigitalPaymentMethod>[];
      json['payment_gateways'].forEach((v) { _paymentMethodList!.add(DigitalPaymentMethod.fromJson(v)); });
    }
    if (json['system_language'] != null) {
      _languageList = <Language>[];
      json['system_language'].forEach((v) { _languageList!.add(Language.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provider_can_cancel_booking'] = _providerCanCancelBooking;
    data['currency_symbol_position'] = _currencySymbolPosition;
    data['provider_self_registration'] = _providerSelfRegistration;
    data['business_name'] = _businessName;
    data['logo'] = _logo;
    data['logo_full_path'] = _logoFullPath;
    data['favicon'] = _favicon;
    data['favicon_full_path'] = _faviconFullPath;
    data['country_code'] = _countryCode;
    data['business_address'] = _businessAddress;
    data['business_phone'] = _businessPhone;
    data['business_email'] = _businessEmail;
    data['base_url'] = _baseUrl;
    data['currency_code'] = _currencyCode;
    data['about_us'] = _aboutUs;
    data['privacy_policy'] = _privacyPolicy;
    data['terms_and_conditions'] = _termsAndConditions;
    data['refund_policy'] = _refundPolicy;
    data['return_policy'] = _returnPolicy;
    data['cancellation_policy'] = _cancellationPolicy;
    if (_defaultLocation != null) {
      data['default_location'] = _defaultLocation!.toJson();
    }
    data['app_url_android'] = _appUrlAndroid;
    data['app_url_ios'] = _appUrlIos;
    data['email_verification'] = _emailVerification;
    data['phone_verification'] = _phoneVerification;
   // data['image_base_url'] = _imageBaseUrl;
    data['pagination_limit'] = _paginationLimit;

    data['currency_decimal_point'] = _currencyDecimalPoint;
    data['default_commission'] = defaultCommission;

    if (_adminDetails != null) {
      data['admin_details'] = _adminDetails!.toJson();
    }
    if (_minimumVersion != null) {
      data['min_versions'] = _minimumVersion!.toJson();
    }
    data['footer_text'] = _footerText;
    data['minimum_withdraw_amount'] = _minimumWithdrawAmount;
    data['min_payable_amount'] = _minimumPayableAmount;
    data['maximum_withdraw_amount'] = _maximumWithdrawAmount;
    data['phone_number_visibility_for_chatting'] = _showPhoneNumber;
    data['bid_offers_visibility_for_providers'] = _bidOfferVisibilityForProvider;
    data['bidding_status'] = _biddingStatus;
    data['otp_resend_time'] = _sendOtpTimer;
    data['forget_password_verification_method'] = _forgetPasswordVerificationMethod;
    data['booking_otp_verification'] = _bookingOtpVerification;
    data['provider_self_delete'] = _providerSelfDelete;
    data['max_cash_in_hand_limit_provider'] = _maxCashInHandLimit;
    data['suspend_on_exceed_cash_limit_provider'] = _suspendOnCashInHandLimit;
    data['currency_symbol'] = _currencySymbol;
    return data;
  }
}

class DefaultLocation {
  Default? defaultLocation;



  DefaultLocation.fromJson(Map<String, dynamic> json) {
    defaultLocation = json['default'] != null ? Default.fromJson(json['default']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (defaultLocation != null) {
      data['default'] = defaultLocation!.toJson();
    }
    return data;
  }
}

class Default {
  double? lat;
  double? lon;

  Default({String? lat, String? lon}) {
    if (lat != null) {
      lat = lat;
    }
    if (lon != null) {
      lon = lon;
    }
  }

  Default.fromJson(Map<String, dynamic> json) {
    lat = double.tryParse(json['lat'].toString());
    lon = double.tryParse(json['lon'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
class AdminDetails {
  String? id;
  String? firstName;
  String? lastName;
  String? profileImage;

  AdminDetails(
      {String? id, String? firstName, String? lastName, String? profileImage}) {
    if (id != null) {
      id = id;
    }
    if (firstName != null) {
      firstName = firstName;
    }
    if (lastName != null) {
      lastName = lastName;
    }
    if (profileImage != null) {
      profileImage = profileImage;
    }
  }

  AdminDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    return data;
  }

}

class MinimumVersion {
  String? minVersionForAndroid;
  String? minVersionForIos;

  MinimumVersion({String? minVersionForAndroid, String? minVersionForIos}) {
    if (minVersionForAndroid != null) {
      minVersionForAndroid = minVersionForAndroid;
    }
    if (minVersionForIos != null) {
      minVersionForIos = minVersionForIos;
    }
  }

  MinimumVersion.fromJson(Map<String, dynamic> json) {
    minVersionForAndroid = json['min_version_for_android'];
    minVersionForIos = json['min_version_for_ios'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min_version_for_android'] = minVersionForAndroid;
    data['min_version_for_ios'] = minVersionForIos;
    return data;
  }
}

class DigitalPaymentMethod {
  String? gateway;
  String? gatewayImage;
  String? gatewayImageFullPath;
  String? label;

  DigitalPaymentMethod({this.gateway, this.gatewayImage, this.label, this.gatewayImageFullPath});

  DigitalPaymentMethod.fromJson(Map<String, dynamic> json) {
    gateway = json['gateway'];
    gatewayImage = json['gateway_image'];
    gatewayImageFullPath = json['gateway_image_full_path'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gateway'] = gateway;
    data['gateway_image'] = gatewayImage;
    data['label'] = label;
    return data;
  }
}


class Language {
  String? languageCode;
  bool? isDefault;
  int? status;
  String? fullName;

  Language({this.languageCode, this.isDefault, this.fullName});

  Language.fromJson(Map<String, dynamic> json) {
    languageCode = json['code'];
    isDefault = json['default'];
    status = int.tryParse(json['status'].toString());
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = languageCode;
    data['default'] = isDefault;
    data['status'] = status;
    data['full_name'] = fullName;
    return data;
  }
}
