import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/html/model/pages_model.dart';

class HtmlViewController extends GetxController implements GetxService{
  final HtmlRepository htmlRepository;
  HtmlViewController({required this.htmlRepository});

  final bool _isLoading = false;
  get isLoading=> _isLoading;
  String ? _htmlPage;
  String? get htmlPage => _htmlPage;
  PagesContent? _pagesContent;
  PagesContent? get pagesContent => _pagesContent;

  Future<void> getPagesContent() async {
    Response response =await htmlRepository.getPagesContent();
    if(response.statusCode == 200){
      _pagesContent = PagesContent.fromJson(response.body['content']);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }
}


