import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/review/widget/provider_review_item.dart';
import 'package:demandium_provider/feature/review/widget/provider_review_shimmer.dart';
import 'package:demandium_provider/feature/review/widget/review_heading.dart';
import 'package:demandium_provider/feature/review/widget/review_linear_chart.dart';
import 'package:demandium_provider/feature/service_details/repo/service_details_repo.dart';
import 'package:demandium_provider/feature/review/widget/empty_review_widget.dart';
import 'package:get/get.dart';

class ProviderReviewScreen extends StatefulWidget {
  const ProviderReviewScreen({super.key});

  @override
  State<ProviderReviewScreen> createState() => _ProviderReviewScreenState();
}
class _ProviderReviewScreenState extends State<ProviderReviewScreen> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ServiceDetailsController(
        serviceDetailsRepo: ServiceDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find())
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'reviews'.tr),
      body: GetBuilder<ReviewController>(
        initState: (_){
          Get.find<ReviewController>().getProviderReview(1,reload: true);
        },
        builder: (reviewController){
          if(!reviewController.isLoading){
            return CustomScrollView(
              controller: reviewController.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        ReviewHeading(rating: reviewController.providerRating ??Rating(ratingCount: 0,averageRating: 0,ratingGroupCount: [])),

                        const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                        ReviewLinearChart(rating: reviewController.providerRating??Rating(ratingCount: 0,averageRating: 0,ratingGroupCount: [])),

                        const Divider(),
                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                       reviewController.providerReviewList.isNotEmpty? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviewController.providerReviewList.length,
                          itemBuilder: (context, index){

                            return InkWell(
                              child: ProviderReviewItem(reviewData: reviewController.providerReviewList.elementAt(index),
                              ),
                              onTap: ()=>Get.toNamed(RouteHelper.getBookingDetailsRoute(
                                reviewController.providerReviewList[index].booking!.id!,
                                "",
                                "others",
                              ),
                              ),
                            );
                          },
                        ):const EmptyReviewWidget(),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                      child: reviewController.isLoading?
                      const CircularProgressIndicator():
                      const SizedBox()
                  ),
                ),
              ],
            );
          }else {
            return const ProviderReviewShimmer();
          }
        },
      ),
    );
  }
}
