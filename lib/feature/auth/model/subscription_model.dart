class SubscriptionModel {
  final int id;
  final String? title;
  final double? price;
  final String? expiryDate;
  final List<String>? includedServiceList;

  SubscriptionModel( {this.title, this.price, this.expiryDate, this.includedServiceList, required this.id});
}