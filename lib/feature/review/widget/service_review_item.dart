import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/service_details/widget/rating_bar.dart';


class ServiceReviewItem extends StatelessWidget {

  final ReviewData reviewData;
  const ServiceReviewItem({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    int day = DateTime.now().difference(
        DateConverter.dateTimeString(DateConverter.isoStringToLocalDate( reviewData.createdAt!).toString())
    ).inDays;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(height:Dimensions.paddingSizeDefault),
            if(reviewData.customer != null)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraLarge)),
                child: CustomImage(height: 40, width: 40,
                  image: "${reviewData.customer?.profileImageFullPath}" ,
                ),
              ),
            const SizedBox(width:Dimensions.paddingSizeDefault),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(reviewData.customer != null)
                    Text("${reviewData.customer!.firstName!} ${reviewData.customer!.lastName!}",
                      style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.black,
                      ),
                    ),
                  if(reviewData.customer == null)
                    Text("customer_not_available".tr,
                      style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                      ),
                    ),

                  SizedBox(
                    height: 20,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Row(
                          children: [
                            RatingBar(rating: reviewData.reviewRating),
                            const SizedBox(width:Dimensions.paddingSizeExtraSmall),

                            Text(
                              reviewData.reviewRating!.toString(),
                              style: ubuntuBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).hintColor
                              ),
                            ),
                          ],
                        ),





                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            day==0?"today".tr:
                            "$day${day>1?  "days_ago".tr :"day_ago".tr}",
                            style: ubuntuRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeSmall
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height:Dimensions.paddingSizeSmall),
          ],
        ),
        const SizedBox(height:Dimensions.paddingSizeSmall),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: Dimensions.paddingSizeDefault),
            child: Text(reviewData.reviewComment!,
              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
              textAlign: TextAlign.justify,
            )
        ),
        const SizedBox(height:Dimensions.paddingSizeSmall),
      ],
    );
  }
}
