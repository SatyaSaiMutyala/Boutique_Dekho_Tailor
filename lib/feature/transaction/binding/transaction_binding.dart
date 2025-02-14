import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class TransactionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController(transactionRepo: TransactionRepo(apiClient: Get.find())));
  }
}