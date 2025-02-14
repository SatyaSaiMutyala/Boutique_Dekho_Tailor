import 'package:demandium_provider/core/helper/core_export.dart';

class VerifyPhoneHelper {

  static String getValidPhone(String number, {bool withCountryCode = false}) {
    bool isValid = false;
    String phone = "";

    try{
      PhoneNumber phoneNumber = PhoneNumber.parse(number);
      isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      if(isValid){
        phone =  withCountryCode ? "+${phoneNumber.countryCode}${phoneNumber.nsn}" : phoneNumber.nsn.toString();
        if (kDebugMode) {
          print("Phone Number : $phone");
        }
      }
    }catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return phone;
  }

  static String getValidCountryCode(String number, {bool withCountryCode = false}) {
    bool isValid = false;
    String countryCode = "";

    try{
      PhoneNumber phoneNumber = PhoneNumber.parse(number);
      isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      if(isValid){
        countryCode = "+${phoneNumber.countryCode.toString()}";
      }
    }catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return countryCode;
  }


  // static bool updateCountryAndNumberInEditServiceMan(String number){
  //   PhoneNumber phoneNumber = PhoneNumber.parse(number);
  //   bool isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
  //   if(isValid){
  //     Get.find<ServicemanSetupController>().countryDialCode = "+${phoneNumber.countryCode}";
  //     if (kDebugMode) {
  //       print("Country Code is ${Get.find<ServicemanSetupController>().countryDialCode}");
  //     }
  //     Get.find<ServicemanSetupController>().phoneController.text = phoneNumber.nsn;
  //     if (kDebugMode) {
  //       print("Phone Number is ${Get.find<ServicemanSetupController>().phoneController.text}");
  //     }
  //   }else{
  //     Get.find<ServicemanSetupController>().countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode??"+880";
  //   }
  //   return isValid;
  // }

}
