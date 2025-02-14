

import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {

    Get.lazyPut(() => ReviewController(reviewRepo: ReviewRepo(apiClient: Get.find())));
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => NotificationController(notificationRepo: NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => PostController(postRepo: PostRepo(apiClient: Get.find() )));
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
    Get.lazyPut(() => SuggestServiceController(suggestServiceRepo: SuggestServiceRepo(apiClient: Get.find())));

    Get.lazyPut(() => AuthController(authRepo:AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => UserProfileController( userRepo: UserRepo(Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => DashboardController(dashBoardRepo: DashBoardRepo(apiClient: Get.find(),sharedPreferences: Get.find())));
    Get.lazyPut(() => ServicemanSetupController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));
    Get.lazyPut(() => ReviewController(reviewRepo: ReviewRepo(apiClient: Get.find())));
    Get.lazyPut(() => BookingDetailsController(bookingDetailsRepo: BookingDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => BookingEditController(serviceRepo: ServiceRepo(apiClient: Get.find(), sharedPreferences: Get.find(),), bookingDetailsRepo: BookingDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServicemanSetupController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));

    Get.lazyPut(() => ServicemanDetailsController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));
    Get.lazyPut(() => BookingReportController(reportRepo: ReportRepo(apiClient: Get.find())));
    Get.lazyPut(() => BusinessReportController(reportRepo: ReportRepo(apiClient: Get.find())));

  }
}