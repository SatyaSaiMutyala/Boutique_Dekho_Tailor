import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ReviewRepo{
  final ApiClient apiClient;
  ReviewRepo({required this.apiClient});

  Future<Response> getProviderReviewList(int offset) async {
    return await apiClient.getData('${AppConstants.getProviderReviewList}?offset=$offset&limit=10');
  }

  Future<Response> getServiceReviewList(String serviceID,int offset) async {
    return await apiClient.getData('${AppConstants.getServiceReviewList}/$serviceID?offset=$offset&limit=10&status=all');
  }

}