import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/service_details/widget/rating_bar.dart';
import 'package:get/get.dart';

class ReviewHeading extends StatelessWidget {
  final Rating rating;
  const ReviewHeading({super.key,required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: shadow
      ),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft,
            child: Text("reviews".tr,
              style: ubuntuMedium.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                  fontSize: Dimensions.fontSizeDefault
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          Divider(height: 1, thickness: 1, color: Theme.of(context).hintColor
              .withOpacity(0.1),),
          Text(rating.averageRating.toString(),
              style: ubuntuBold.copyWith(
                  color:Theme.of(context).primaryColorLight, fontSize: 30
              )
          ),
          const SizedBox(height: 8,),
          RatingBar(rating: double.parse('${rating.averageRating}',),size: 22,),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${rating.ratingCount.toString()} ${'ratings'.tr}",
                style: ubuntuRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                  fontSize: Dimensions.fontSizeSmall
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall,),
              Text(
                "${rating.ratingCount.toString()} ${'reviews'.tr}",
                  style: ubuntuRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                      fontSize: Dimensions.fontSizeSmall
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
