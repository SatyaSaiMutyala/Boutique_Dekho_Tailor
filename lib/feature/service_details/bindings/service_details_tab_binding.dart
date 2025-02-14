import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/service_details/repo/service_details_repo.dart';

class ServiceDetailsTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceDetailsController(serviceDetailsRepo: ServiceDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find())), );
  }

}