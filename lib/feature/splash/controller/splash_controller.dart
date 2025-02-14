import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});




  ConfigModel _configModel = ConfigModel();
  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;

  ConfigModel get configModel => _configModel;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;

  bool _showCustomBookingButton = false;
  bool get showCustomBookingButton => _showCustomBookingButton;

  bool _showRedDotIconForCustomBooking = false;
  bool get showRedDotIconForCustomBooking => _showRedDotIconForCustomBooking;

  Future<bool> getConfigData() async {
    _hasConnection = true;
    Response response = await splashRepo.getConfigData();
    bool isSuccess = false;
    if(response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(response.body);
      isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      if(response.statusText == ApiClient.noInternetMessage) {
        _hasConnection = false;
      }
      isSuccess = false;
    }
    update();
    return isSuccess;
  }



  updateCustomBookingRedDotButtonStatus({required bool status, bool shouldUpdate = true }){
    _showRedDotIconForCustomBooking = status;

    Future.delayed(const Duration(milliseconds: 200), (){
      if(shouldUpdate){
        update();
      }
    });
  }

  void updateCustomBookingButtonStatus({bool shouldUpdate = true, bool fromCustomBookingScreen = false}){

    _showCustomBookingButton = true;
    if(shouldUpdate){
      update();
    }

    
    Future.delayed(const Duration(seconds: 10), (){
      _showCustomBookingButton = false;
      if(shouldUpdate){
        update();
      }
    });


  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  bool showInitialLanguageScreen() {
    return splashRepo.showInitialLanguageScreen();
  }

  void disableShowInitialLanguageScreen() {
    splashRepo.disableShowInitialLanguageScreen();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  Future<void> updateLanguage(bool isInitial) async {
    Response response = await splashRepo.updateLanguage();

    if(!isInitial){
     if(response.statusCode == 200 && response.body['response_code'] == "default_200"){

     }else{
       showCustomSnackBar("${response.body['message']}");
     }
   }

  }
}
