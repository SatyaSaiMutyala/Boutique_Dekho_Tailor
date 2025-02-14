import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';

class ServicemanSetupBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ServicemanSetupController(
        servicemanRepo: ServicemanRepo(apiClient: Get.find()))
    );
    Get.lazyPut(() => ServicemanDetailsController(
        servicemanRepo: ServicemanRepo(apiClient: Get.find()))
    );
  }


}