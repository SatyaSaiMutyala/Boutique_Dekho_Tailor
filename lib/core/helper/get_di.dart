import 'dart:convert';
import 'package:demandium_provider/feature/advertisement/repository/advertisement_repo.dart';
import 'package:demandium_provider/feature/subscriptions/controller/business_subscription_controller.dart';
import 'package:get/get.dart';
import 'core_export.dart';

Future<Map<String, Map<String, String>>> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find())));
  Get.lazyPut(() => TransactionReportController(reportRepo: ReportRepo(apiClient: Get.find())));

  Get.lazyPut(() => UserProfileController( userRepo: UserRepo(Get.find(), apiClient: Get.find())));
  Get.lazyPut(() => DashboardController(dashBoardRepo: DashBoardRepo(apiClient: Get.find(),sharedPreferences: Get.find())));
  Get.lazyPut(() => BookingRequestController(bookingRequestRepo: BookingRequestRepo(apiClient: Get.find())));
  Get.lazyPut(() => AdvertisementController(advertisementRepo: AdvertisementRepo(apiClient: Get.find())));
  Get.lazyPut(() => ServiceCategoryController(serviceRepo: ServiceRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => ServicemanSetupController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));
  Get.lazyPut(() => SubcategorySubscriptionController(subscriptionRepo: SubscriptionRepo(apiClient: Get.find(), sharedPreferences: Get.find()), userRepo:UserRepo(Get.find(), apiClient: Get.find()) ));
  Get.lazyPut(() => BusinessSubscriptionController(subscriptionRepo: SubscriptionRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => BusinessSettingController(businessSettingRepo: BusinessSettingRepo(apiClient: Get.find())));
  Get.lazyPut(() => TransactionController(transactionRepo: TransactionRepo(apiClient: Get.find())));


  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsonValue = {};
    mappedJson.forEach((key, value) {
      jsonValue[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = jsonValue;
  }
  return languages;
}
