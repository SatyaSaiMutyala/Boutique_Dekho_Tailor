import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class UserBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BankInfoController(bankInfoRepo: BankInfoRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => TransactionController(transactionRepo: TransactionRepo(apiClient: Get.find())));


  }
}