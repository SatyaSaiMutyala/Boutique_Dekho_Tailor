import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'core_export.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse? notificationResponse) async {
      try{
        if(notificationResponse!.payload!=null && notificationResponse.payload!=''){
          NotificationBody notificationBody = NotificationBody.fromJson(jsonDecode(notificationResponse.payload!));
          if (kDebugMode) {
            print("Type: ${notificationBody.type}");
          }
          if(notificationBody.type=="chatting"){

            if(Get.currentRoute.contains(RouteHelper.chatScreen)){
              Get.back();
              Get.back();

            } else if(Get.currentRoute.contains(RouteHelper.chatInbox)){
              Get.back();

            }

            Get.toNamed(RouteHelper.getChatScreenRoute(
              notificationBody.channelId??"",
              notificationBody.userType == "supper-admin" ? "admin" : notificationBody.userName??"",
              notificationBody.userProfileImage??"",
              notificationBody.userPhone??"",
              notificationBody.userType??"",
              fromNotification: "fromNotification",
            ));

          }
          else if(notificationBody.type=='bidding'){
            Get.to(()=>const CustomerRequestListScreen());
          }
          else if(notificationBody.type=='booking' && notificationBody.bookingId!=null && notificationBody.bookingId!=''){
            Get.toNamed(RouteHelper.getBookingDetailsRoute(notificationBody.bookingId.toString(),'','fromNotification'));
          } else if(notificationBody.type=='privacy_policy' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute(page: "privacy-policy"));
          }else if(notificationBody.type=='terms_and_conditions' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute(page: "terms-and-condition"));
          }else if(notificationBody.type == 'withdraw'){
            Get.toNamed(RouteHelper.getTransactionListRoute(fromPage: "fromNotification"));
          }
          else if(notificationBody.type == 'admin_pay'){
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }
          else if(notificationBody.type == 'service_request'){
            Get.to(()=> const SuggestedServiceListScreen());
          }
          else if(notificationBody.type == 'suspend'){
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }
          else if(notificationBody.type == 'logout'){
            Get.find<AuthController>().clearSharedData();
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }

          else if(notificationBody.type == 'advertisement'){
            Get.toNamed(RouteHelper.getAdvertisementDetailsScreen(advertisementId: notificationBody.advertisementId, fromNotification: "fromNotification"));
          }
          else{
            Get.toNamed(RouteHelper.getNotificationRoute(fromPage: "notification"));

          }
        }
      }catch (e) {
        if (kDebugMode) {
          print("");
        }
          }
          return;
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }

      if (kDebugMode) {
        print("onMessage Body : ${message.data.toString()}");
      }



      if(message.data['type']=='bidding'){
        if(message.data['post_id']!="" &&  message.data['post_id']!=null){
          Get.find<SplashController>().updateCustomBookingButtonStatus();
          Get.find<SplashController>().updateCustomBookingRedDotButtonStatus(status: true, shouldUpdate: true);
          Get.find<PostController>().getPostDetailsForNotification(message.data['post_id']);
          Get.find<DashboardController>().getDashboardData(reload: true);
        }else{
          NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
        }
      }

      else if(message.data['type']=='chatting'){

        if((message.data['channel_id']!="" && message.data['channel_id']!=null)){

          if(Get.currentRoute.contains(RouteHelper.chatScreen) && (message.data['channel_id'] == Get.find<ConversationController>().channelId) ){
            Get.find<ConversationController>().getConversation(message.data['channel_id'], 1);
          }else if(Get.currentRoute.contains(RouteHelper.chatInbox)
              || Get.currentRoute.contains(RouteHelper.chatScreen)){

            NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
            if(message.data['user_type'] == 'customer'){
              Get.find<ConversationController>().getChannelList(1);
            }else{
              Get.find<ConversationController>().getChannelList(1, type: "serviceman");
            }
          }else{
            NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
          }

        } else{
          NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
        }
      }else if(message.data['type']=='general'){
        NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
        Get.find<NotificationController>().getNotifications(1, saveNotificationCount: false);
      }
      else if(message.data['type'] == 'logout'){
        NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
        Get.find<AuthController>().clearSharedData();
        Get.offAllNamed(RouteHelper.getInitialRoute());
        showCustomSnackBar(message.data['title'], duration: 4);
      }
      else{
        NotificationHelper.showNotification(message, false,flutterLocalNotificationsPlugin);
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      try{
        if(message!=null && message.data.isNotEmpty) {
          NotificationBody notificationBody = convertNotification(message.data);
          if(notificationBody.type=="chatting"){

            if(Get.currentRoute.contains(RouteHelper.chatScreen)){
              Get.back();
              Get.back();
            } else if(Get.currentRoute.contains(RouteHelper.chatInbox)){
              Get.back();
            }
            Get.toNamed(RouteHelper.getChatScreenRoute(
              notificationBody.channelId??"",
              notificationBody.userType == "supper-admin" ? "admin" : notificationBody.userName??"",
              notificationBody.userProfileImage??"",
              notificationBody.userPhone??"",
              notificationBody.userType??"",
              fromNotification: "fromNotification"
            ));
          }
          else if(notificationBody.type=='bidding' ){
            Get.to(()=>const CustomerRequestListScreen());
          }

          else if(notificationBody.type=='booking' && notificationBody.bookingId!=null && notificationBody.bookingId!=''){
            Get.toNamed(RouteHelper.getBookingDetailsRoute(notificationBody.bookingId.toString(),'','fromNotification'));
          }
          else if(notificationBody.type=='privacy_policy' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute(page: "privacy-policy"));
          }
          else if(notificationBody.type=='terms_and_conditions' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute(page: "terms-and-condition"));
          }
          else if(notificationBody.type == 'service_request'){
            Get.to(()=> const SuggestedServiceListScreen());
          }
          else if(notificationBody.type == 'suspend'){
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }
          else if(notificationBody.type == 'withdraw'){
            Get.toNamed(RouteHelper.getTransactionListRoute(fromPage: "fromNotification"));
          }
          else if(notificationBody.type == 'admin_pay'){
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }
          else if(message.data['type'] == 'logout'){
            Get.find<AuthController>().clearSharedData();
            Get.offAllNamed(RouteHelper.getInitialRoute());
          }
          else if(message.data['type'] == 'advertisement'){
            Get.toNamed(RouteHelper.getAdvertisementDetailsScreen(advertisementId: notificationBody.advertisementId, fromNotification: "fromNotification"));
          }
          else{
            Get.toNamed(RouteHelper.getNotificationRoute(fromPage: "notification"));
          }
        }
      }catch (e) {
        if (kDebugMode) {
          print("");
        }
      }
    });
  }



  static Future<void> showNotification(RemoteMessage message,bool data,FlutterLocalNotificationsPlugin fln) async {
    if(!GetPlatform.isIOS) {
      String? title;
      String? body;
      String? image;
      String playLoad = jsonEncode(message.data);

        title = message.data['title']?.replaceAll('_', ' ').toString().capitalize;
        body = message.data['body'];
        image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;

      if(image != null && image.isNotEmpty) {
        try{
          await showBigPictureNotificationHiddenLargeIcon(title!, body!, playLoad, image, fln);
        }catch(e) {
          await showBigTextNotification(title :title!, body: '',payload: playLoad, fln : fln);
        }
      }else {
        await showBigTextNotification(title :title!, body: '',payload: playLoad, fln : fln);
      }
    }
  }

  static Future<void> showBigTextNotification({required String title, required String body, required String payload, required FlutterLocalNotificationsPlugin fln}) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );

    if(!Get.find<AuthController>().isNotificationActive()){
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithoutsound","demandium without sound", channelDescription:"description",
        playSound: false,
        importance: Importance.max,
        styleInformation: bigTextStyleInformation, priority: Priority.max,

      );
      int randomNumber = Random().nextInt(100);
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: payload);
    }
    else {
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithsound", 'demandium with sound', channelDescription:"description",
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('notification'),
        importance: Importance.max,
        styleInformation: bigTextStyleInformation, priority: Priority.max,
      );
      int randomNumber = Random().nextInt(100);
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: payload);
    }

  }
  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String payload, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );

    if(!Get.find<AuthController>().isNotificationActive()){
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithoutsound","demandium without sound", channelDescription:"description",
        playSound: false,
          largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max,
          styleInformation: bigPictureStyleInformation, importance: Importance.max,
      );
      int randomNumber = Random().nextInt(100);
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: payload);

    }else{
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithsound", 'demandium with sound', channelDescription:"description",
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('notification'),
        largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max,
        styleInformation: bigPictureStyleInformation, importance: Importance.max,
      );
      int randomNumber = Random().nextInt(100);
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: payload);
    }
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data){
    return NotificationBody.fromJson(data);

  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
}