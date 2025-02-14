
enum FileType{png,jpg,jpeg,csv,txt,xlx,xls,pdf}

enum HtmlType {
  termsAndCondition,
  aboutUs,
  privacyPolicy,
  refundPolicy,
  cancellationPolicy,
  returnPolicy
}

enum NoDataType {
  request,
  notification,
  faq,
  conversation,
  transaction,
  others,
  service,
  customPost,
  myBids,
  subscriptions,
  none,
  advertisement
}

enum TransactionType {none ,payable, withdrawAble, adjust , adjustAndPayable, adjustWithdrawAble}
enum UserAccountStatus {deletable ,haveExistingBooking, needPaymentSettled}