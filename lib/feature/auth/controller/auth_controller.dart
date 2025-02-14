import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool? _isLoading = false;
  final bool _notification = true;

  bool? get isLoading => _isLoading;
  bool? get notification => _notification;

  bool? _isActiveRememberMe =false ;
  bool? get isActiveRememberMe => _isActiveRememberMe;

  String _verificationCode = '';
  String get verificationCode => _verificationCode;

  Future<void> login(String emailOrPhone, String password) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.login(emailOrPassword: emailOrPhone, password: password);
    if (response!.statusCode == 200  && response.body['response_code']=='auth_login_200'){
      if (isActiveRememberMe!) {
        authRepo.saveUserNumberAndPassword(emailOrPhone, password);
      } else {
        authRepo.clearUserNumberAndPassword();
      }
      authRepo.saveUserToken(response.body['content']["token"]);
      authRepo.updateToken();
      Get.offAllNamed(RouteHelper.initial);
      Get.find<SplashController>().updateLanguage(true);
      showCustomSnackBar("successfully_logged_in".tr,isError: false);
    }
    else if((response.body['response_code']=='unverified_email_401' || response.body['response_code']=='unverified_phone_401') && response.statusCode==401){
      showCustomSnackBar(response.body['message'],isError: false);
      Get.toNamed(RouteHelper.getSendOtpScreen("verification"));
    }else{
      showCustomSnackBar(response.body['message'].toString().capitalizeFirst??response.statusText);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> sendOtpForVerificationScreen(String identity, String identityType) async {
    _isLoading = true;
    update();
    Response  response = await authRepo.sendOtpForVerificationScreen(identity,identityType);
    if (response.statusCode == 200 && response.body["response_code"]=="default_200") {
      _isLoading = false;
      update();
      return ResponseModel(true, "");
    } else {
      _isLoading = false;
      update();

      String responseText = "";
      if(response.statusCode == 500){
        responseText = "Internal Server Error";
      }else{
       responseText = response.body["message"] ?? response.statusText ;
      }
      return ResponseModel(false, responseText);
    }
  }


  Future<ResponseModel> sendOtpForForgetPassword(String identity, String identityType) async {
    _isLoading = true;
    update();
    Response response = await authRepo.sendOtpForForgetPassword(identity,identityType);

    if (response.statusCode == 200 && response.body["response_code"]=="default_200") {
      _isLoading = false;
      update();
      return ResponseModel(true, "");
    } else {

      _isLoading = false;
      update();

      String responseText = "";
      if(response.statusCode == 500){
        responseText = "Internal Server Error";
      }else{
        responseText = response.body["message"] ?? response.statusText ;
      }
      return ResponseModel(false, responseText);
    }
  }


  Future<ResponseModel>  verifyOtpForVerificationScreen(String identity,  String identityType, String otp,) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.verifyOtpForVerificationScreen(identity,identityType,otp);
    ResponseModel responseModel;
    if (response!.statusCode == 200 && response.body['response_code']=="default_200") {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {

      String responseText = "";
      if(response.statusCode == 500){
        responseText = "Internal Server Error";
      }else{
        responseText = response.body["message"] ?? response.statusText ;
      }
      responseModel = ResponseModel(false, responseText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  Future<ResponseModel> verifyOtpForForgetPasswordScreen(String identity, String identityType, String otp) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyOtpForForgetPassword(identity, identityType, otp);

    if (response.statusCode==200 &&  response.body['response_code'] == 'default_200') {
      _isLoading = false;
      update();
      return ResponseModel(true, "successfully_verified");
    }else{
      _isLoading = false;
      update();


      String responseText = "";
      if(response.statusCode == 500){
        responseText = "Internal Server Error";
      }else{
        responseText = response.body["message"] ?? response.statusText ;
      }
      return ResponseModel(false, responseText);
    }

  }


  Future<void> resetPassword(String identity,String identityType, String otp, String password, String confirmPassword) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(identity,identityType, otp, password, confirmPassword);

    if (response!.statusCode == 200 && response.body['response_code']=="default_password_reset_200") {
      Get.offNamed(RouteHelper.signIn);
      showCustomSnackBar('password_changed_successfully'.tr,isError: false);
    } else {
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }

  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await authRepo.deleteUser();
    _isLoading = false;
    if(response.statusCode == 200){
      showCustomSnackBar('your_account_remove_successfully'.tr, isError: false);
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    }else{
      Get.back();
      ApiChecker.checkApi(response);
    }
  }


  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }
  bool isNotificationActive() {
    return authRepo.isNotificationActive();

  }

  toggleNotificationSound(){
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe!;
    authRepo.setRememberMeValue(_isActiveRememberMe!);
    update();
  }

  bool? getRememberMeValue() {
    return authRepo.getRememberMeValue();
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }
}