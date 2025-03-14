import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class VerificationScreen extends StatefulWidget {
   final String? identity;
   final bool fromVerification;
   final String identityType;
   final bool  showSignUpDialog;
  const VerificationScreen({super.key, this.identity, required this.fromVerification, required this.identityType, required this.showSignUpDialog});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  String? _identity;
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    if( (widget.fromVerification && Get.find<SplashController>().configModel.content?.phoneVerification==1)
        || (!widget.fromVerification && Get.find<SplashController>().configModel.content?.forgetPasswordVerificationMethod=="phone")){
      _identity = widget.identity!.startsWith('+') ? widget.identity : '+${widget.identity!.substring(1, widget.identity!.length)}';
    } else{
      _identity = widget.identity;
    }

    _startTimer();
  }

  void _startTimer() {
    _seconds = Get.find<SplashController>().configModel.content?.sendOtpTimer??60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'otp_verification'.tr),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: GetBuilder<AuthController>(builder: (authController) {
            return Column(children: [
              Image.asset(Images.logo,width: Dimensions.logoWidth,),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Column(
                children: [
                   Text('enter_the_verification'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5))),
                   const SizedBox(height: Dimensions.paddingSizeSmall,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('sent_to'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5))),
                       const SizedBox(width: Dimensions.paddingSizeSmall,),
                       Text('$_identity', style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
                     ],
                   ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor: Get.isDarkMode?Colors.grey.withOpacity(0.6):Colors.white,
                    inactiveFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                    inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    activeColor: Theme.of(context).primaryColor.withOpacity(0.4),
                    activeFillColor: Theme.of(context).disabledColor.withOpacity(0.2),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authController.updateVerificationCode,
                  beforeTextPaste: (text) => true,
                  pastedTextStyle: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ),

              authController.verificationCode.length == 4 ?
              CustomButton(
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                btnTxt: "verify".tr, isLoading: authController.isLoading!,
                onPressed: (){
                _otpVerify(_identity!,widget.identityType, authController.verificationCode,authController);
                },
              )  : const SizedBox.shrink(),

              (widget.identity != null && widget.identity!.isNotEmpty) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'did_not_receive_the_code'.tr,
                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(1, 40),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    textStyle: TextStyle(color: Theme.of(context).primaryColor)
                  ),
                  onPressed: _seconds! < 1 ? () {
                    if(widget.fromVerification){
                      authController.sendOtpForVerificationScreen(_identity!,widget.identityType).then((value) {
                        if (value.isSuccess!) {
                          _startTimer();
                          showCustomSnackBar('resend_code_successful'.tr, isError: false);
                        } else {
                          showCustomSnackBar(value.message);
                        }
                      });

                    }else{
                      authController.sendOtpForForgetPassword(_identity!,widget.identityType).then((value) {
                        if (value.isSuccess!) {
                          _startTimer();
                          showCustomSnackBar('resend_code_successful'.tr, isError: false);
                        } else {
                          showCustomSnackBar(value.message);
                        }
                      });
                    }
                  } : null,
                  child: Text('${'resend'.tr}${_seconds! > 0 ? ' ($_seconds)' : ''}',style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,)),
                ),
              ]) : const SizedBox(),

              SizedBox(height: Get.height*0.1,)
            ]);
          }),
        ),
      ),
    );
  }

  void _otpVerify(String identity,String identityType,String otp, AuthController authController) async {

    if(widget.fromVerification){
      authController.verifyOtpForVerificationScreen(identity,identityType,otp).then((status){
        if(status.isSuccess!){
          Get.toNamed(RouteHelper.getSignInRoute(""));
          if(widget.showSignUpDialog){
            showCustomBottomSheet(child: const WelcomeBottomSheet(fromSignup: true,));
          }else{
            showCustomSnackBar(status.message,isError: false);
          }
        }else{
          showCustomSnackBar(status.message);
        }
      });
    }  else{
      authController.verifyOtpForForgetPasswordScreen(identity,identityType,otp).then((status) async {
        if (status.isSuccess!) {
          Get.offNamed(RouteHelper.getChangePasswordRoute(identity,identityType,otp));
        }else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}
