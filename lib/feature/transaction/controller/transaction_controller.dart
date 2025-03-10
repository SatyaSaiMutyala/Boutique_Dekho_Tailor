import 'package:demandium_provider/data/model/response/api_response_model.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class TransactionController extends GetxController implements GetxService{

  final TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  bool? _paginationLoading = false;
  bool? get paginationLoading => _paginationLoading;

  List<TransactionData>? _transactionsList =[];
  List<TransactionData>? get transactionsList => _transactionsList;

  String? _defaultPaymentMethodId;
  String? _defaultPaymentMethodName;

  String? get  defaultPaymentMethodId => _defaultPaymentMethodId;
  String? get  defaultPaymentMethodName => _defaultPaymentMethodName;

  WithdrawModel? _withdrawModel;
  WithdrawModel? get withdrawModel => _withdrawModel;

  List<WithdrawalMethod>? _withdrawalMethods;
  List<WithdrawalMethod>? get withdrawalMethods => _withdrawalMethods;

  String? _selectAmount;
  String? get selectAmount => _selectAmount;
  int _transactionTypeIndex = -1;
  int get transactionTypeIndex => _transactionTypeIndex;

  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {

    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getWithdrawRequestList(offset+1,true, shouldUpdate: false);
        }
      }
    });
  }

  Future<void> getWithdrawRequestList(int offset,bool isFormPagination, {bool shouldUpdate = true}) async {
    _offset = offset;

      if(!isFormPagination){
        _transactionsList = [];
        _isLoading = true;
      }else{
        _paginationLoading = true;
      }
    Response response = await transactionRepo.getTransactionsList(offset);
    if(response.statusCode==200){
      _pageSize =response.body['content']['withdraw_requests']['last_page'];
     List<dynamic> transactionList = response.body['content']['withdraw_requests']['data'];
     for (var element in transactionList) {
         transactionsList!.add(TransactionData.fromJson(element));
     }
    }
    else if(response.statusCode == 401){
      ApiChecker.checkApi(response);
    }
    _paginationLoading = false;
    _isLoading = false;
    update();
  }


  Future<void> withDrawRequest({Map<String, String>? placeBody})async{
    _isLoading = true;
    update();
    Response response = await transactionRepo.withdrawRequest(placeBody: placeBody);

    if(response.statusCode == 200 && response.body["response_code"] == 'default_200' ){
      await Get.find<UserProfileController>().getProviderInfo(reload: true);

      Get.back();
      Get.back();
      showCustomSnackBar('withdraw_request_send_successful'.tr, isError: false);
    } else if (response.statusCode == 400){
      Get.back();
      showCustomSnackBar(response.body['errors'][0]['message']);
    }else{
      Get.back();
      showCustomSnackBar(response.statusText);

    }
    _isLoading = false;
    update();
  }


  Future<void> getWithdrawMethods({bool isReload = false}) async{
    if(_withdrawModel == null || isReload) {
      Response response = await transactionRepo.getWithdrawMethods();
      ResponseModelApi responseApi = ResponseModelApi.fromJson(response.body);

      if(responseApi.responseCode == 'default_200' && responseApi.content != null) {
        _withdrawModel = WithdrawModel.fromJson(response.body);

        _withdrawModel?.withdrawalMethods?.forEach((element) {
          if(element.isDefault==1){
            _defaultPaymentMethodId = element.id;
            _defaultPaymentMethodName = element.methodName;
          }
        });
      }else{
        _withdrawModel = WithdrawModel(withdrawalMethods: [],);
        ApiChecker.checkApi(response);
      }
    }
    update();
  }

  Future<void> adjustTransaction() async{
    _isLoading = true;
    update();
    Response response = await transactionRepo.adjustTransaction();

    if(response.statusCode == 200){
     await  Get.find<UserProfileController>().getProviderInfo(reload: true);
     showCustomSnackBar(response.body['message'], isError: false);
    }else{
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }



  void setIndex(int index , String amount) {
    _transactionTypeIndex = index;
    _selectAmount = amount;
    update();
  }

  void selectAmountSet(String value) {
    _selectAmount = value;
    update(['inputAmountListController']);
  }
}