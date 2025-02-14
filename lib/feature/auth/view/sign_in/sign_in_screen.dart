// ignore_for_file: deprecated_member_use

import 'package:demandium_provider/components/custom_pop_scope_widget.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  const SignInScreen({super.key, required this.exitFromApp});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  bool _canExit = GetPlatform.isWeb ? true : false;
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  
  String? emailErrorText;
  String? passwordErrorText;

  @override
  void initState() {
    super.initState();
    _emailController.text = Get.find<AuthController>().getUserNumber();
    _passwordController.text = Get.find<AuthController>().getUserPassword();

  }


  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      onPopInvoked: () {
        if (_canExit) {
          exit(0);
        } else {
          showCustomSnackBar('back_press_again_to_exit'.tr, isError: false);
          _canExit = true;
          Timer(const Duration(seconds: 2), () {
            _canExit = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Center(
              child: GetBuilder<AuthController>(builder: (authController) {

                return Form(
                  key: signInFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(children: [
                    Image.asset(Images.logo,width: Dimensions.logoWidth,),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomTextField(
                      title: 'email_or_phone'.tr,
                      hintText: 'enter_email_or_password'.tr,
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _passwordFocus,
                      inputType: TextInputType.emailAddress,
                      onValidate: (String? value){
                        return  FormValidationHelper().isValidEmailOrPhone(value!);
                      },
                    ),

                    const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),
                    CustomTextField(
                      title: 'password'.tr,
                      hintText: '********'.tr,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      inputAction: TextInputAction.done,
                      onValidate: (String? value){
                        return FormValidationHelper().isValidPassword(value);
                      },
                    ),


                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: () => authController.toggleRememberMe(),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  child: Checkbox(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: authController.isActiveRememberMe,
                                    checkColor: Colors.white,
                                    onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                                Text(
                                  'remember_me'.tr,
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            horizontalTitleGap: 0,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(minimumSize: const Size(1, 40),backgroundColor: Theme.of(context).colorScheme.surface),
                          onPressed: () => Get.toNamed(RouteHelper.getSendOtpScreen("forget-password")),
                          child: Text('forgot_password?'.tr, style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),)
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    CustomButton(btnTxt: 'sign_in'.tr, onPressed:  () => _login(authController) , isLoading: authController.isLoading!,),

                    Get.find<SplashController>().configModel.content?.providerSelfRegistration == 1 ?
                    Column(
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeDefault),

                        Text("or".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color,)),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('do_not_have_an_account'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).primaryColor)),
                            TextButton(
                              style: TextButton.styleFrom(minimumSize: const Size(1, 40),
                                  backgroundColor: Theme.of(context).colorScheme.surface),
                              onPressed: () => Get.toNamed(RouteHelper.signUp),

                              child:Text('register_here'.tr,
                                style: ubuntuRegular.copyWith(
                                    color: Theme.of(context).colorScheme.tertiary.withOpacity(.8),
                                    fontSize: Dimensions.fontSizeDefault
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ) :const SizedBox.shrink(),

                  ]),
                );
              }),
            ),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController) async {

    if(signInFormKey.currentState!.validate()){
      String phone = VerifyPhoneHelper.getValidPhone(_emailController.text.trim(), withCountryCode: true);
      authController.login( phone !="" ? phone : _emailController.text.trim(), _passwordController.text.trim());
    }
  }
}

