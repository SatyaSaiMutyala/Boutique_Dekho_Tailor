import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/service_details/widget/rating_bar.dart';


class ProviderReviewItem extends StatelessWidget {
  final ReviewData reviewData;
  const ProviderReviewItem({super.key,
    required this.reviewData
  });
  @override
  Widget build(BuildContext context) {

    List<String> variationName =[];
    String serviceName ='';

    reviewData.booking?.detail?.forEach((element) {
      if(reviewData.serviceId==element.serviceId){
        serviceName = element.serviceName??"";
        variationName.add(element.variantKey??'');
      }
    });
    String variation = variationName.toString().replaceAll('[', '').replaceAll(']', '');

    int day = DateTime.now().difference(
        DateConverter.dateTimeString(DateConverter.isoStringToLocalDate( reviewData.createdAt!).toString())
    ).inDays;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:Dimensions.paddingSizeDefault),
            if(reviewData.customer != null)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraLarge)),
                child: CustomImage( height: 40, width: 40,
                  image: "${reviewData.customer?.profileImageFullPath}" ,
                ),
              ),
            const SizedBox(width:Dimensions.paddingSizeDefault),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(reviewData.customer != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(reviewData.customer != null)
                        Text("${reviewData.customer!.firstName!} ${reviewData.customer!.lastName!}",
                          style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
                          ),
                        ),

                        Text(
                          day==0?"today".tr:
                          "$day${day>1?  "days_ago".tr :"day_ago".tr}",
                          style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                        ),
                      ],
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
                    child: Row(
                      children: [
                        RatingBar(rating: reviewData.reviewRating,size: 15,),
                        const SizedBox(width:Dimensions.paddingSizeExtraSmall),
                        Text(
                          reviewData.reviewRating!.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(reviewData.booking!=null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Text("${"booking".tr} # ",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
                            ),
                          ),
                          Text(reviewData.booking?.readableId.toString()??"",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if(reviewData.booking!=null && reviewData.booking!.detail!=null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Text("${"service_name".tr} : ",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
                            ),
                          ),
                          Flexible(
                            child: Text(serviceName,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if(reviewData.booking!=null && reviewData.booking!.detail!=null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${"variant".tr} : ",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
                            ),
                          ),
                          Flexible(
                            child: Text(variation,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
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

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: Dimensions.paddingSizeSmall),
            child: Text(reviewData.reviewComment!,
              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
              textAlign: TextAlign.justify,
            )
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
