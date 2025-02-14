import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
  }
}