class ReturnData {
  String uid;
  String statusIndicator;

  ReturnData({required this.uid, required this.statusIndicator});
}

ReturnData getReturnData(String url) {
  Uri uri = Uri.parse(url);
  String uid = uri.queryParameters['uid'] ?? '';
  String statusIndicator = uri.queryParameters['statusIndicator'] ?? '';
  return ReturnData(uid: uid, statusIndicator: statusIndicator);
}