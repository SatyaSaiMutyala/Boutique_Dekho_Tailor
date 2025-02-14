import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

void showCustomSnackBar(String? message, {bool isError = true, int duration =2}) {
  if(message != null && message.isNotEmpty) {
    Get.closeAllSnackbars();
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      maxWidth: Dimensions.webMaxWidth,
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      borderRadius: Dimensions.radiusSmall,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}