import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ForgetPassScreen extends StatefulWidget {
  final bool fromVerification;
  final bool showSignUpDialog;
  const ForgetPassScreen({super.key,this.fromVerification = false, required this.showSignUpDialog});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _identityController = TextEditingController();

  String identityType ="";
  final ConfigModel _configModel = Get.find<SplashController>().configModel;

  String countryDialCode = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode _emailAddressFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode?? "+880";
    if(widget.fromVerification){
      if(_configModel.content?.emailVerification==1){
        identityType = "email";
      }else{
        identityType = "phone";
      }
    } else{
      identityType = _configModel.content?.forgetPasswordVerificationMethod??"";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: widget.fromVerification && Get.find<SplashController>().configModel.content?.phoneVerification==1 ?
      'phone_verification'.tr : widget.fromVerification && Get.find<SplashController>().configModel.content?.emailVerification==1 ?
      "email_verification".tr : 'forgot_password'.tr),

      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Form(
            key: formKey,
            child: Column(children: [

              Image.asset(Images.forgetPassword,height: 100,width: 100,),

              if(widget.fromVerification)
                Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                  child: Center(child: Text('${"verify_your".tr} ${identityType=="email"?"email_address".tr.toLowerCase():"phone_number".tr.toLowerCase()}',
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.9)),textAlign: TextAlign.center,
                  )),
                ),

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge*1.5),
                child: Center(child: Text('${"please_enter_your".tr} ${identityType=="email"?"email_address".tr.toLowerCase():"phone_number".tr.toLowerCase()} ${"to_receive_a_verification_code".tr}',
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7)),textAlign: TextAlign.center,
                )),
              ),

              (identityType=="email")?
              CustomTextField(
                hintText: "enter_email_address".tr,
                controller: _identityController,
                inputType: TextInputType.emailAddress,
                title: "email".tr,
                focusNode: _emailAddressFocus,
                onValidate: (value){
                  if(value == null || value.isEmpty){
                    return 'empty_email_hint'.tr;
                  }else{
                    return FormValidationHelper().isValidEmail(value);
                  }
                },
              ): CustomTextField(
                hintText: 'ex : 1234567890'.tr,
                controller: _identityController,
                inputType: TextInputType.phone,
                focusNode: _phoneNumberFocus,
                countryDialCode: countryDialCode,
                onCountryChanged: (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
                onValidate: (value)  {
                  if(value == null || value.isEmpty){
                    return 'phone_number_hint'.tr;
                  }else{
                    return FormValidationHelper().isValidPhone(countryDialCode+(value));
                  }
                },
              ),

              const SizedBox(height: Dimensions.paddingSizeLarge),

              GetBuilder<AuthController>(builder: (authController) {
                return CustomButton(btnTxt: "send_verification_code".tr, isLoading: authController.isLoading!,
                  onPressed: ()=> formKey.currentState!.validate() ? _forgetPass(countryDialCode,authController) : null,
                );
              }),
              const SizedBox(height: 150),

            ]),
          ),
        )),
      )))),
    );
  }

  void _forgetPass(String countryDialCode,AuthController authController) async {

    String phone = countryDialCode + VerifyPhoneHelper.getValidPhone("$countryDialCode${_identityController.text}");

    String email = _identityController.text.trim();
    String identity = identityType=="phone"?phone:email;


    if (_identityController.text.isEmpty) {
      if(identityType=="phone"){
        showCustomSnackBar('enter_phone_number'.tr);
      }else{
        showCustomSnackBar('enter_email_address'.tr);
      }
    }else {
      if(widget.fromVerification){
        authController.sendOtpForVerificationScreen(identity,identityType).then((status) {
          if(status.isSuccess!){
            Get.toNamed(RouteHelper.getVerificationRoute(identity,identityType,"verification", showSignUpDialog: widget.showSignUpDialog));
          }else{
            showCustomSnackBar(status.message.toString().capitalizeFirst);
          }
        });
      }else{
        authController.sendOtpForForgetPassword(identity,identityType).then((status){
          if(status.isSuccess!){
            Get.toNamed(RouteHelper.getVerificationRoute(identity,identityType,"forget-password"));
          }else{
            showCustomSnackBar(status.message.toString().capitalizeFirst);
          }
        });
      }}
    }
}


