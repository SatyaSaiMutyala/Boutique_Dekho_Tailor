import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class ReviewController extends GetxController implements GetxService{
  final ReviewRepo reviewRepo;
  ReviewController({required this.reviewRepo});

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  List<ReviewData> _providerReviewList = [];
  List<ReviewData> get providerReviewList => _providerReviewList;

  Rating? _providerRating;
  Rating? get providerRating => _providerRating;


  List<ReviewData>? _serviceReviewList = [];
  List<ReviewData>? get serviceReviewList => _serviceReviewList!;

  Rating? _serviceRating;
  Rating? get serviceRating => _serviceRating;

  final ScrollController scrollController = ScrollController();


  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getProviderReview(offset+1);
        }
      }
    });
  }

  Future<void> getProviderReview(int offset,{bool reload = false}) async {
    _offset = offset;
    _isLoading = true;
    if(!reload){
      update();
    }
    Response response = await reviewRepo.getProviderReviewList(offset);
    if (response.statusCode == 200 && response.body['response_code'] ==  'default_200') {
      _pageSize = response.body['content']['reviews']['last_page'];
      if(reload){
        _providerReviewList =[];
        _providerRating==null;
      }
        response.body['content']['reviews']['data'].forEach((review){
          _providerReviewList.add( ReviewData.fromJson(review));
        });
        _providerRating = Rating.fromJson(response.body['content']['rating']);
    } else {
      _providerReviewList =[];
      _providerRating=null;
    }
    _isLoading = false;
    update();
  }


  Future<void> getServiceReview(String serviceID) async {
    _serviceReviewList =[];
    _serviceRating=null;
    Response response = await reviewRepo.getServiceReviewList(serviceID,1);
    if (response.statusCode == 200 && response.body['response_code'] ==  'default_200') {
      try{
        response.body['content']['reviews']['data'].forEach((review){
          _serviceReviewList!.add( ReviewData.fromJson(review));
        });
      }catch(error){
        if (kDebugMode) {
          print('error : $error');
        }
      }
      try{
        _serviceRating = Rating.fromJson(response.body['content']['rating']);
      }catch(error){
        if (kDebugMode) {
          print('rating get error : $error');
        }
      }
    } else {
      //ApiChecker.checkApi(response);
    }
  }

}