import 'package:get/get.dart';
import 'package:demandium_provider/feature/html/controller/webview_controller.dart';
import 'package:demandium_provider/feature/html/repository/html_repo.dart';


class HtmlBindings extends Bindings {@override
void dependencies(){
  Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
}
}
