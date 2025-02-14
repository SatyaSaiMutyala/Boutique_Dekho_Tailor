import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/booking_details/model/bookings_details_model.dart';

class BookingSummeryView extends StatelessWidget{
  final BookingDetailsContent bookingDetailsContent;
  final JustTheController? couponTooltipController;
  final JustTheController? serviceTooltipController;
  const BookingSummeryView({super.key, required this.bookingDetailsContent, this.couponTooltipController, this.serviceTooltipController});

  @override
  Widget build(BuildContext context){
    return GetBuilder<BookingDetailsController>(builder:(bookingDetailsController){


      double paidAmount = 0;

      double totalBookingAmount = bookingDetailsContent.totalBookingAmount ?? 0;
      bool isPartialPayment = bookingDetailsContent.partialPayments !=null && bookingDetailsContent.partialPayments!.isNotEmpty;

      if(isPartialPayment) {
        bookingDetailsContent.partialPayments?.forEach((element) {
          paidAmount = paidAmount + (element.paidAmount ?? 0);
        });
      }else{
        paidAmount  = totalBookingAmount - (bookingDetailsContent.additionalCharge ?? 0);
      }
      double dueAmount = totalBookingAmount - paidAmount;
      double additionalCharge = isPartialPayment ? totalBookingAmount - paidAmount : bookingDetailsContent.additionalCharge ?? 0;


      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [

          Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
            child: Text("booking_summary".tr,
              style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: Get.find<ThemeController>().darkTheme ? null : lightShadow),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              const SizedBox(height: Dimensions.paddingSizeDefault,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  height: 40,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("service_info".tr, style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge ,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8), decoration: TextDecoration.none)
                      ),
                      Text("price".tr,style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),decoration: TextDecoration.none)
                      ),
                    ],
                  ),
                ),
              ),

               const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

               ListView.builder(
                 itemCount: bookingDetailsController.bookingDetailsContent?.bookingDetails?.length,
                 physics: const NeverScrollableScrollPhysics(),
                 padding: EdgeInsets.zero,
                 shrinkWrap: true,
                 itemBuilder: (context,index){
                   return ServiceInfoItem(
                     bookingService : bookingDetailsController.bookingDetailsContent?.bookingDetails?[index],
                     bookingDetailsController: bookingDetailsController,
                     index: index,
                   );},
               ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Divider(height: 2, color: Colors.grey,),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("subtotal_vat_ex".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                      ),overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Text(PriceConverter.convertPrice(bookingDetailsController.allTotalCost, isShowLongPrice:true),
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(

                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text("service_discount".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                          ),overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                          // JustTheTooltip(
                          //   backgroundColor: Colors.black87, controller: serviceTooltipController,
                          //   preferredDirection: AxisDirection.down, tailLength: 14, tailBaseWidth: 20,
                          //   content: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          //     child:  Text("service_dummy_text", style: ubuntuRegular.copyWith(color: Colors.white70),),
                          //   ),
                          //   child: InkWell(
                          //     onTap: ()=> serviceTooltipController?.showTooltip(),
                          //     child: Icon(Icons.info, size: 15,
                          //       color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Text("(-) ${PriceConverter.convertPrice(
                        bookingDetailsController.totalDiscount,
                        isShowLongPrice:true)}",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(

                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text("coupon_discount".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                          ),overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                          // JustTheTooltip(
                          //   backgroundColor: Colors.black87, controller: couponTooltipController,
                          //   preferredDirection: AxisDirection.down, tailLength: 14, tailBaseWidth: 20,
                          //   content: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          //     child:  Text("coupon_dummy_text", style: ubuntuRegular.copyWith(color: Colors.white70),),
                          //   ),
                          //   child: InkWell(
                          //     onTap: ()=> couponTooltipController?.showTooltip(),
                          //     child: Icon(Icons.info, size: 15,
                          //       color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Text("(-) ${PriceConverter.convertPrice(
                        double.tryParse(bookingDetailsController.bookingDetailsContent!.totalCouponDiscountAmount!),
                        isShowLongPrice:true)}",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                      ),
                    ),
                  ],
                ),
              ),

              if(bookingDetailsController.bookingDetailsContent!.totalReferralDiscountAmount != null && bookingDetailsController.bookingDetailsContent!.totalReferralDiscountAmount! > 0)
                const SizedBox(height: Dimensions.paddingSizeSmall),

              if(bookingDetailsController.bookingDetailsContent!.totalReferralDiscountAmount != null && bookingDetailsController.bookingDetailsContent!.totalReferralDiscountAmount! > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'referral_discount'.tr,
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),
                        overflow: TextOverflow.ellipsis,),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalReferralDiscountAmount ?? 0)}',
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color!)),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(

                  children: [
                    Expanded(
                      child: Text("service_tax".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                      ),overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Text("(+) ${PriceConverter.convertPrice( bookingDetailsController.bookingDetailsContent?.totalTaxAmount ?? 0,
                        isShowLongPrice:true)}",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                      ),
                    ),
                  ],
                ),
              ),


             if(bookingDetailsContent.extraFee != null && bookingDetailsContent.extraFee! > 0)
               Padding(
                 padding: const EdgeInsets.only(left : Dimensions.paddingSizeDefault , right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeExtraSmall),
                 child: Row(
                   children: [
                     Expanded(
                       child: Text( Get.find<SplashController>().configModel.content?.additionalChargeLabelName ?? "",style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                           color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                       ),overflow: TextOverflow.ellipsis,
                       ),
                     ),
                     const SizedBox(width: Dimensions.paddingSizeDefault,),
                     Text("(+) ${PriceConverter.convertPrice( bookingDetailsController.bookingDetailsContent?.extraFee ?? 0,
                         isShowLongPrice:true)}",
                       style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                           color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                       ),
                     ),
                   ],
                 ),
               ),

              const SizedBox(height : Dimensions.paddingSizeSmall),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Divider(height: 2, color: Colors.grey,),
              ),
              const SizedBox( height:Dimensions.paddingSizeExtraSmall),

              !isPartialPayment && bookingDetailsContent.paymentMethod != "wallet_payment" ? (additionalCharge == 0) ||  bookingDetailsContent.paymentMethod == "cash_after_service" ?
              Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('grand_total'.tr,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalBookingAmount!.toDouble(),isShowLongPrice: true),
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                  ),
                ],),
              ) : Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: DottedBorder(
                  dashPattern: const [8, 4],
                  strokeWidth: 1.1,
                  borderType: BorderType.RRect,
                  color: Theme.of(context).colorScheme.primary,
                  radius: const Radius.circular(Dimensions.radiusDefault),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.02),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                    child: Column(
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('grand_total'.tr,
                            style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( totalBookingAmount ,isShowLongPrice: true),
                              style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color : Theme.of(context).colorScheme.primary,),),
                          ),
                        ],),

                        const SizedBox(height: Dimensions.paddingSizeSmall,),


                        additionalCharge > 0 ?
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("${(bookingDetailsContent.bookingStatus == "pending"  || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing")
                              ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                            overflow: TextOverflow.ellipsis,),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text( PriceConverter.convertPrice (additionalCharge, isShowLongPrice: true),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                          )]
                        ): const SizedBox()
                      ],
                    ),
                  ),
                ),
              ) :

              !isPartialPayment && bookingDetailsContent.paymentMethod == "wallet_payment" ?
              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column( children: [

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('grand_total'.tr,
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                          PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalBookingAmount!.toDouble(),isShowLongPrice: true),
                          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primary,)),
                    ),
                  ],),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  DottedBorder(
                    dashPattern: const [8, 4],
                    strokeWidth: 1.1,
                    borderType: BorderType.RRect,
                    color: Theme.of(context).colorScheme.primary,
                    radius: const Radius.circular(Dimensions.radiusDefault),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.02),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start ,children: [

                        Text( (bookingDetailsContent.additionalCharge! <= 0) ? 'total_order_amount_has_been_paid_by_customer'.tr : "has_been_paid_by_customer".tr,
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primary,),
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Row(children: [

                            Image.asset(Images.walletSmall,width: 17,),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                            Text( 'via_wallet'.tr,
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                              overflow: TextOverflow.ellipsis,),
                          ],),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( paidAmount ,isShowLongPrice: true),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                          )]
                        ),

                        if(additionalCharge > 0 )
                          Padding( padding: const EdgeInsets.only(top : 8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text("${(bookingDetailsContent.bookingStatus == "pending"  || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing")
                                  ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                                overflow: TextOverflow.ellipsis,),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  PriceConverter.convertPrice( additionalCharge, isShowLongPrice: true),
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                              )]
                            ),
                          )

                      ]),
                    ),
                  ),
                ]),
              )  :

              isPartialPayment ?
              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: DottedBorder(
                  dashPattern: const [8, 4],
                  strokeWidth: 1.1,
                  borderType: BorderType.RRect,
                  color: Theme.of(context).colorScheme.primary,
                  radius: const Radius.circular(Dimensions.radiusDefault),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.02),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                    child: Column(
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('grand_total'.tr,
                            style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( totalBookingAmount, isShowLongPrice: true),
                              style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color : Theme.of(context).colorScheme.primary,),),
                          ),
                        ],),

                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                        ListView.builder(itemBuilder: (context, index){
                          String payWith = bookingDetailsContent.partialPayments?[index].paidWith ?? "";

                          return  Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(children: [

                                Image.asset(Images.walletSmall, width: 15,),

                                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                                Text( '${ payWith == "cash_after_service" ? "paid_amount".tr : payWith == "digital" && bookingDetailsContent.paymentMethod == "offline_payment" ? ""  :'paid_by'.tr} ''${payWith == "digital" ? "${bookingDetailsContent.paymentMethod}".tr : (payWith == "cash_after_service" ? "(${'cash_after_service'.tr})" : payWith).tr }',
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                                  overflow: TextOverflow.ellipsis,),
                              ],),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  PriceConverter.convertPrice( bookingDetailsContent.partialPayments?[index].paidAmount ?? 0,isShowLongPrice: true),
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                              )]),
                          );
                        },itemCount: bookingDetailsContent.partialPayments?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),

                        bookingDetailsContent.partialPayments?.length == 1 && dueAmount > 0 ?
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("${(bookingDetailsContent.bookingStatus == "pending"  || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing")
                              ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                            overflow: TextOverflow.ellipsis,),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( dueAmount, isShowLongPrice: true),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                          )]) : const SizedBox(),

                      ],
                    ),
                  ),
                ),
              ) : Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('grand_total'.tr,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      PriceConverter.convertPrice( totalBookingAmount,isShowLongPrice: true),
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                  ),
                ],),
              ),


              const SizedBox(height: Dimensions.paddingSizeSmall,),
             ]),
          ),
        ],
      );
       },
    );
  }
}


class ServiceInfoItem extends StatelessWidget {
  final int index;
  final BookingDetailsController bookingDetailsController;
  final ItemService? bookingService;
  const ServiceInfoItem({
    super.key,required this.bookingService,
    required this.bookingDetailsController,
    required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          const SizedBox(height:Dimensions.paddingSizeSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: Text(bookingService?.serviceName??"",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Text(PriceConverter.convertPrice(bookingDetailsController.unitTotalCost[index],
                isShowLongPrice:true,
              ),
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.9)
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall-2,),
          if(bookingService?.variantKey!=null)
          Padding(padding: const EdgeInsets.only( bottom: Dimensions.paddingSizeExtraSmall),
            child: Text(bookingService?.variantKey??"",
              style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7)
              ),
            ),
          ),


          priceText("unit_price".tr, bookingService?.serviceCost??"0", context),

          Text("${"quantity".tr} : ${bookingService?.quantity}",
            style: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),


          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
          (bookingService?.discountAmount ?? 0) > 0
            ? priceText("discount".tr,
            (bookingService?.discountAmount ?? 0), context)
            : const SizedBox(),
          (bookingService?.campaignDiscountAmount ?? 0) > 0
            ? priceText("campaign".tr,
            (bookingService?.campaignDiscountAmount??"0"),
            context)
            : const SizedBox(),

          (bookingService?.overallCouponDiscountAmount ?? 0) > 0
            ? priceText("coupon".tr, (bookingService?.overallCouponDiscountAmount?? 0), context)
            : const SizedBox(),

          bookingService?.service != null && (bookingService?.service?.tax??0) > 0
            ? priceText(
            "tax".tr, (bookingService?.taxAmount?? 0), context)
           : const SizedBox(),
        ],
      ),);
  }

}


Widget priceText(String title,var amount,context){
  return Column(children: [
    Row(
      children: [
        Text("$title : ",
          style: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7)
          ),
        ),
        Text(PriceConverter.convertPrice(amount,isShowLongPrice:true),
          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7)),
        ),
      ],
    ),
    const SizedBox(height:Dimensions.paddingSizeExtraSmall),
    ],
  );
}
