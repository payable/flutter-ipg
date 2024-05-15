import 'dart:convert';

class PaymentData {
  PaymentData({
      String? status,
      String? uid,
      String? statusIndicator,
      String? paymentPage,}){
    _status = status;
    _uid = uid;
    _statusIndicator = statusIndicator;
    _paymentPage = paymentPage;
}

  PaymentData.fromJson(dynamic json) {
    _status = jsonDecode(json)['status'];
    _uid = jsonDecode(json)['uid'];
    _statusIndicator = jsonDecode(json)['statusIndicator'];
    _paymentPage = jsonDecode(json)['paymentPage'];
  }
  String? _status;
  String? _uid;
  String? _statusIndicator;
  String? _paymentPage;

  String? get status => _status;
  String? get uid => _uid;
  String? get statusIndicator => _statusIndicator;
  String? get paymentPage => _paymentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['uid'] = _uid;
    map['statusIndicator'] = _statusIndicator;
    map['paymentPage'] = _paymentPage;
    return map;
  }

}