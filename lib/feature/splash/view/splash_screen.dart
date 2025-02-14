import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, @required this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  StreamSubscription<List<ConnectivityResult>>? _onConnectivityChanged;
  double opacity = 0.5;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(!firstTime) {
        bool isNotConnected = result.first != ConnectivityResult.wifi && result.first != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });
    Get.find<SplashController>().initSharedData();

    _route();

  }


  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged!.cancel();
  }
  void _route() {

    Future.delayed(const Duration(milliseconds: 500),(){
      setState(() {
        opacity = 1;
      });
    });

    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(const Duration(seconds: 1), () async {

          bool isAvailableUpdate =false;

          String minimumVersion = "1.1.0";
          double? minimumBaseVersion =1.0;
          double? minimumLastVersion =0;

          String appVersion = AppConstants.appVersion;
          double? baseVersion = double.tryParse(appVersion.substring(0,3));
          double lastVersion=0;
          if(appVersion.length>3){
            lastVersion = double.tryParse(appVersion.substring(4,5))!;
          }


          if(GetPlatform.isAndroid && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString();
            if(minimumVersion.length==1){
              minimumVersion = "$minimumVersion.0";
            }
            if(minimumVersion.length==3){
              minimumVersion = "$minimumVersion.0";
            }
            minimumBaseVersion = double.tryParse(minimumVersion.substring(0,3));
            minimumLastVersion = double.tryParse(minimumVersion.substring(4,5));

            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          else if(GetPlatform.isIOS && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!;
            if(minimumVersion.length==1){
              minimumVersion = "$minimumVersion.0";
            }
            if(minimumVersion.length==3){
              minimumVersion = "$minimumVersion.0";
            }
            minimumBaseVersion = double.tryParse(minimumVersion.substring(0,3));
            if(minimumVersion.length>3){
              minimumLastVersion = double.tryParse(minimumVersion.substring(4,5));
            }
            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          if(isAvailableUpdate) {
            Get.offNamed(RouteHelper.getUpdateRoute(isAvailableUpdate));
          }
          else {
            PriceConverter.getCurrency();
            if(widget.body != null) {

              Get.find<UserProfileController>().getProviderInfo().then((value) {
                String notificationType = widget.body?.type??"";

                switch(notificationType) {

                  case "chatting": {
                    Get.offNamed(RouteHelper.getInboxScreenRoute(fromNotification: "fromNotification"));
                  } break;

                  case "booking": {
                    if( widget.body!.bookingId!=null&& widget.body!.bookingId!=""){
                      Get.offAllNamed(RouteHelper.getBookingDetailsRoute( widget.body!.bookingId!,"", 'fromNotification'));
                    }else{
                      Get.offNamed(RouteHelper.getInitialRoute());
                    }
                  } break;

                  case "bidding": {
                    if( widget.body!.postId!=null && widget.body!.postId!=""){
                      Get.offAll(()=>const CustomerRequestListScreen());
                    }else{
                      Get.offNamed(RouteHelper.getInitialRoute());
                    }
                  } break;

                  case "privacy_policy": {
                    Get.toNamed(RouteHelper.getHtmlRoute(page: "privacy-policy",fromPage: 'notification'));
                  } break;

                  case "terms_and_conditions": {
                    Get.toNamed(RouteHelper.getHtmlRoute( page:"terms-and-condition",fromPage: 'notification'));
                  } break;

                  case "suspend": {
                    Get.offAllNamed(RouteHelper.getInitialRoute());
                  } break;

                  case "withdraw": {
                    Get.toNamed(RouteHelper.getTransactionListRoute(fromPage: "fromNotification"));
                  } break;

                  case "admin_pay": {
                    Get.offAllNamed(RouteHelper.getInitialRoute());
                  } break;
                  case "advertisement": {
                    Get.toNamed(RouteHelper.getAdvertisementDetailsScreen(advertisementId: widget.body?.advertisementId, fromNotification: "fromNotification"));
                  } break;

                  default: {
                    Get.toNamed(RouteHelper.getNotificationRoute(fromPage: "notification"));
                  } break;
                }
              });

            }
            else{
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                Get.find<UserProfileController>().getProviderInfo()
                    .then((value) => Get.offNamed(RouteHelper.getInitialRoute())
                );
              } else {
                if( Get.find<SplashController>().showInitialLanguageScreen()){
                  Get.toNamed(RouteHelper.getLanguageScreenRoute());
                }else{
                  Get.offNamed(RouteHelper.getSignInRoute("LogIn"));
                }
              }
            }
            }
        });
      }else{

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 500),
          child: Center(
              child: splashController.hasConnection ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image.asset(Images.logo,width: Dimensions.logoWidth,),
                  // const SizedBox(height: Dimensions.paddingSizeLarge),
                  // Text(
                  //   AppConstants.appUser,
                  //   style: ubuntuBold.copyWith(
                  //     fontSize: 20,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  // ),
                  Image.asset('assets/images/splashLogo.png', width: double.infinity, height:MediaQuery.of(context).size.height, fit: BoxFit.cover,),
                ]
              )
              : NoInternetScreen(child: SplashScreen(body: widget.body)
             )
          ),
        );
      }),
    );
  }
}
