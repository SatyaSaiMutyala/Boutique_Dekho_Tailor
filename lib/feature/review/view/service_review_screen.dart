import 'package:demandium_provider/feature/review/widget/review_heading.dart';
import 'package:demandium_provider/feature/review/widget/review_linear_chart.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/review/widget/empty_review_widget.dart';
import 'package:demandium_provider/feature/review/widget/service_review_item.dart';

class ServiceDetailsReview extends StatelessWidget {
  const ServiceDetailsReview({
    super.key,
    required this.reviewList,
    required this.rating,
    required this.scrollController
  });

  final List<ReviewData> reviewList;
  final Rating rating;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {

    if(reviewList.isNotEmpty) {
      return  SliverToBoxAdapter(
        child: Center(
          child: Container(
            width: Dimensions.webMaxWidth,
            constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
              minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
            ) : null,
        
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  ReviewHeading(rating: rating),
        
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                  ReviewLinearChart(rating:rating),
        
                  const Divider(),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),
        
                  ListView.separated(
                    separatorBuilder: (context, index){
                      return const Divider();
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviewList.length,
                    itemBuilder: (context, index){
                      return ServiceReviewItem(reviewData: reviewList.elementAt(index),);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(child: EmptyReviewWidget());
  }
}