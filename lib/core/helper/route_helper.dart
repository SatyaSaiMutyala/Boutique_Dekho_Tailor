import 'dart:convert';
import 'package:demandium_provider/feature/advertisement/view/advertisement_details_screen.dart';
import 'package:demandium_provider/feature/advertisement/view/advertisement_list_screen.dart';
import 'package:demandium_provider/feature/language/view/language_screen.dart';
import 'package:demandium_provider/feature/subscriptions/view/business/business_plan_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/feature/service_details/model/service_details_model.dart';
import 'core_export.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String languageScreen = '/language-screen';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String update = '/update';
  static const String profile = '/profile';
  static const String bankInfo = '/bank-info';
  static const String mySubscription = '/my-subscription';
  static const String html = '/html';
  static const String allServices = '/all-services';
  static const String serviceDetails = '/service-details';
  static const String bookingDetails = '/booking-details';
  static const String serviceManSetup = '/serviceManSetup';
  static const String addNewServicemanScreen = '/addNewServicemanScreen';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String serviceScreen = '/service-screen';
  static const String sendOtpScreen = '/send-otp';
  static const String verification = '/otp-verification';
  static const String changePassword = '/change-password';
  static const String notification = '/notification';
  static const String profileInformation = '/profile-information';
  static const String transactions = '/transactions';
  static const String reporting = '/reporting';
  static const String suggestService = '/suggest-service';
  static const String advertisementList = '/advertisement-list';
  static const String advertisementDetails = '/advertisement-details';
  static const String businessPlan = '/business-plan';


  static String getInitialRoute({int pageIndex = 0}) => '$initial?pageIndex=$pageIndex';
  static String getSplashRoute(NotificationBody? body) {
    String data = 'null';
    if(body != null) {
      List<int> encoded = utf8.encode(jsonEncode(body));
      data = base64Encode(encoded);
    }
    return '$splash?data=$data';
  }
  static String getLanguageBottomSheet(String page) => '$language?page=$page';
  static String getLanguageScreenRoute() => languageScreen;
  static String getReportingPageRoute(String page) => '$reporting?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';

  static String getSendOtpScreen(String fromScreen, {bool? showSignUpDialog}){
    String showDialog = showSignUpDialog !=null && showSignUpDialog ? "showDialog" : "";
    return '$sendOtpScreen?fromPage=$fromScreen&showSignUpDialog=$showDialog';
  }
  static String getVerificationRoute(String identity,String identityType, String fromPage, {bool? showSignUpDialog}) {

    String showDialog = showSignUpDialog !=null && showSignUpDialog ? "showDialog":"";

    String data = Uri.encodeComponent(jsonEncode(identity));
    return '$verification?identity=$data&identity_type=$identityType&fromPage=$fromPage&showSignUpDialog=$showDialog';
  }
  static String getChangePasswordRoute(String identity,String identityType ,String otp) {
    String identity0 = Uri.encodeComponent(jsonEncode(identity));
    String otp0 = Uri.encodeComponent(jsonEncode(otp));
   return '$changePassword?identity=$identity0&identity_type=$identityType&otp=$otp0';
  }
  static String getProfileRoute() => profile;
  static String getBankInfoRoute() => bankInfo;
  static String getMySubscriptionRoute() => mySubscription;
  static String getHtmlRoute({String? page,String? fromPage}) => '$html?page=$page&fromPage=$fromPage';
  static String getAllServicesRoute() => allServices;
  static String getServiceDetailsRoute(String serviceId,Discount discount) => '$serviceDetails?service_id=$serviceId';
  static String getBookingDetailsRoute(String bookingId, String bookingStatus, String fromPage, {String? subcategoryId}) =>
      '$bookingDetails?booking_id=$bookingId&booking_status=$bookingStatus&fromPage=$fromPage&subcategory_id=$subcategoryId';
  static String getChatScreenRoute(String channelId,String name,String image,String phone,String userType, {String? fromNotification}) =>
      '$chatScreen?channelID=$channelId&name=$name&image=$image&phone=$phone&userType=$userType&fromNotification=$fromNotification';

  static String getInboxScreenRoute({String? fromNotification}) => '$chatInbox?fromNotification=$fromNotification';
  static String getNotificationRoute({String? fromPage}) => '$notification?page=$fromPage';
  static String getTransactionListRoute({String? fromPage}) => '$transactions?page=$fromPage';
  static String getAdvertisementListScreen({required int count}) => '$advertisementList?count=$count';
  static String getAdvertisementDetailsScreen({String? advertisementId, String? fromNotification}) => '$advertisementDetails?advertisementId=$advertisementId&fromNotification=$fromNotification';
  static String getBusinessPlanScreen() => businessPlan;

  static List<GetPage> routes = [
    GetPage( name: initial, page: () {
      int pageIndex = int.tryParse(Get.parameters['pageIndex'] ?? "0") ?? 0;
      return  HomeScreen(pageIndex: pageIndex);
    }),
    GetPage(name: splash, page: () {
      NotificationBody? data;
      if(Get.parameters['data'] != 'null') {
        List<int> decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
        data = NotificationBody.fromJson(jsonDecode(utf8.decode(decode)));
      }
      return SplashScreen(body: data);
    }),
    GetPage(name: profile, page: () => const ProfileScreen(),binding: UserBinding()),
    GetPage(binding: ServicemanSetupBinding(), name: serviceManSetup, page: () => const ServicemanSetupScreen()),
    GetPage(name: addNewServicemanScreen, page: () => const AddNewServicemanScreen(),),
    GetPage(binding: BankInfoBinding(),name: profile, page: () => const ProfileScreen()),
    GetPage(name: allServices, page: () => getRoute(const AllServicesScreen())),

    GetPage(name: bookingDetails, binding: BookingBinding(),
        page: () => getRoute(BookingDetails(
          bookingStatus: Get.parameters['booking_status'].toString(),
          bookingId: Get.parameters['booking_id'].toString(),
          fromPage: Get.parameters['fromPage'],
          subcategoryId: Get.parameters['subcategory_id'].toString(),
        ))
    ),
    GetPage(name: notification, page: () => NotificationScreen(
        fromNotificationPage: Get.parameters['fromPage'].toString()
    )),
    GetPage( name: mySubscription, page: () => const SubscriptionScreen()),
    GetPage(transition: Transition.fadeIn, name: signIn, page: () => const SignInScreen(exitFromApp: false,)),
    GetPage(binding: SignupBinding(),name: signUp, page: () => const SignUpScreen()),

    GetPage(binding: HtmlBindings(),name: html, page: () => HtmlViewerScreen(
      htmlType: Get.parameters['page'] == 'terms-and-condition' ? HtmlType.termsAndCondition
              : Get.parameters['page'] == 'privacy-policy' ? HtmlType.privacyPolicy
              : Get.parameters['page'] == 'refund-policy' ? HtmlType.refundPolicy
              : Get.parameters['page'] == 'return-policy' ? HtmlType.returnPolicy
              : Get.parameters['page'] == 'cancellation-policy' ? HtmlType.cancellationPolicy
              : HtmlType.aboutUs,
      fromNotificationPage: Get.parameters['fromPage'].toString()
    ),

    ),
    GetPage( name: chatScreen, page: () => getRoute(ConversationDetailsScreen(
      channelID: Get.parameters['channelID']!,
      name: Get.parameters['name']!,
      phone: Get.parameters['phone']!,
      image: Get.parameters['image']!,
      userType: Get.parameters['userType']!,
      formNotification: Get.parameters['fromNotification'] ?? "",
    ))),

    GetPage(name: chatInbox,binding: ConversationBinding(), page: () =>  ConversationListScreen(
      fromNotification: Get.parameters['fromNotification'],
    )),
    GetPage(name: language, page: () => const ChooseLanguageBottomSheet()),
    GetPage(transition: Transition.fadeIn , name: languageScreen, page: () => const ChooseLanguageScreen()),
    GetPage(name: reporting, page: () => const ReportNavigationView()),
    GetPage(name: bankInfo,binding: BankInfoBinding(), page: () => const BankInformation()),

    GetPage(name: sendOtpScreen, page:() {
     return  ForgetPassScreen(
        fromVerification: Get.parameters['fromPage']=="verification",
       showSignUpDialog: Get.parameters["showSignUpDialog"] == "showDialog",
      );
    }),

    GetPage(name: verification, page:() {
      String data = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));

      return VerificationScreen(
        identity: data,
        identityType: Get.parameters['identity_type']!,
        fromVerification: Get.parameters['fromPage']=="verification",
        showSignUpDialog: Get.parameters["showSignUpDialog"] == "showDialog",
        );
    }),

    GetPage(name: changePassword, page:() {
      String identity0 = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));
      String otp0 = Uri.decodeComponent(jsonDecode(Get.parameters['otp']!));

      return NewPassScreen(
          identity: identity0,
          identityType:  Get.parameters['identity_type']!,
          otp: otp0
      );
    }),

    GetPage(name: profileInformation, page:() => getRoute(const ProfileInformationScreen(),)),
    GetPage(binding: TransactionBinding(),name:transactions, page:() => getRoute( TransactionScreen(
      fromNotification: Get.parameters['page'],
    ),)),
    GetPage(binding: SuggestServiceBinding(),name:suggestService, page:() => getRoute(const SuggestServiceScreen(),)),
    GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(name: advertisementList, page: () =>  AdvertisementListScreen(
      isDataAvailable: Get.parameters['count'] != "0",
    )),
    GetPage(name: advertisementDetails, page: () =>
    AdvertisementDetailsScreen(
      id: Get.parameters['advertisementId'],
      fromNotification: Get.parameters['fromNotification'],
    )),
    GetPage(name: businessPlan, page: () => const BusinessPlanScreen()),

  ];
  static getRoute(Widget navigateTo) {
    // double _minimumVersion = 1.0;
    // if(GetPlatform.isAndroid) {
    //   if(Get.find<SplashController>().configModel.content!.minimumVersion!=null){
    //     _minimumVersion = double.parse(Get.find<SplashController>()
    //         .configModel.content!.minimumVersion!.minVersionForAndroid!.toString());
    //   }
    // }else if(GetPlatform.isIOS) {
    //   if(Get.find<SplashController>().configModel.content!.minimumVersion!=null){
    //     _minimumVersion = double.parse(Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!.toString());
    //   }
    // }
    return  navigateTo;
  }
}