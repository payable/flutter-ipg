import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:package_info/package_info.dart';

import 'package:flutter/material.dart';

class PayableIPG extends StatefulWidget {

  // Required params for all payments
  final int paymentType;
  final String logoUrl;
  final String returnUrl;
  final String checkValue;
  final String orderDescription;
  final String invoiceId;
  final String merchantKey;
  final String customerFirstName;
  final String customerLastName;
  final String customerMobilePhone;
  final String customerEmail;
  final String billingAddressStreet;
  final String billingAddressCity;
  final String billingAddressCountry;
  final String amount;
  final String currencyCode;

  // Required params only for recurring payments when paymentType is 2
  final String? startDate;
  final String? endDate;
  final String? recurringAmount;
  final String? interval;
  final String? isRetry;
  final String? retryAttempts;
  final String? doFirstPayment;

  // Optional params
  final String? custom1;
  final String? custom2;
  final String? customerPhone;
  final String? billingAddressStreet2;
  final String? billingCompanyName;
  final String? billingAddressPostcodeZip;
  final String? billingAddressStateProvince;
  final String? shippingContactFirstName;
  final String? shippingContactLastName;
  final String? shippingContactMobilePhone;
  final String? shippingContactPhone;
  final String? shippingContactEmail;
  final String? shippingCompanyName;
  final String? shippingAddressStreet;
  final String? shippingAddressStreet2;
  final String? shippingAddressCity;
  final String? shippingAddressStateProvince;
  final String? shippingAddressCountry;
  final String? shippingAddressPostcodeZip;

  const PayableIPG({
    super.key,
    required this.paymentType,
    required this.logoUrl,
    required this.returnUrl,
    required this.checkValue,
    required this.orderDescription,
    required this.invoiceId,
    required this.merchantKey,
    required this.customerFirstName,
    required this.customerLastName,
    required this.customerMobilePhone,
    required this.customerEmail,
    required this.billingAddressStreet,
    required this.billingAddressCity,
    required this.billingAddressCountry,
    required this.amount,
    required this.currencyCode,
    this.startDate,
    this.endDate,
    this.recurringAmount,
    this.interval,
    this.isRetry,
    this.retryAttempts,
    this.doFirstPayment,
    this.custom1,
    this.custom2,
    this.customerPhone,
    this.billingAddressStreet2,
    this.billingCompanyName,
    this.billingAddressPostcodeZip,
    this.billingAddressStateProvince,
    this.shippingContactFirstName,
    this.shippingContactLastName,
    this.shippingContactMobilePhone,
    this.shippingContactPhone,
    this.shippingContactEmail,
    this.shippingCompanyName,
    this.shippingAddressStreet,
    this.shippingAddressStreet2,
    this.shippingAddressCity,
    this.shippingAddressStateProvince,
    this.shippingAddressCountry,
    this.shippingAddressPostcodeZip,
  });

  @override
  PayableIPGState createState() => PayableIPGState();
}


class PayableIPGState extends State<PayableIPG> {
  String? _responseUrl;
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SDK demo'),
      ),
      body: Center(
        child: _responseUrl != null
            ? WebViewWidget(controller: controller)
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchResponseUrl() async {
    final Map<String, dynamic> requestData = {

      // Provided from SDK side
      "paymentType": widget.paymentType,
      "isMobilePayment": 1,
      "packageName": getPackageName(),
      "integrationType": "Android SDK",
      "integrationVersion": getVersion(),
      "statusReturnUrl": "TODO",
      "webhookUrl": "TODO",

      // Required params
      "logoUrl": widget.logoUrl,
      "returnUrl": widget.returnUrl,
      "checkValue": widget.checkValue,
      "orderDescription": widget.orderDescription,
      "invoiceId": widget.invoiceId,
      "merchantKey": widget.merchantKey,
      "customerFirstName": widget.customerFirstName,
      "customerLastName": widget.customerLastName,
      "customerMobilePhone": widget.customerMobilePhone,
      "customerEmail": widget.customerEmail,
      "billingAddressStreet": widget.billingAddressStreet,
      "billingAddressCity": widget.billingAddressCity,
      "billingAddressCountry": widget.billingAddressCountry,
      "billingAddressPostcodeZip": widget.billingAddressPostcodeZip,
      "amount": widget.amount,
      "currencyCode": widget.currencyCode,
    };

    // For recurring payments
    if (widget.paymentType == 2) {
      requestData.addAll({
        "startDate": widget.startDate,
        "endDate": widget.endDate,
        "recurringAmount": widget.recurringAmount,
        "interval": widget.interval,
        "isRetry": widget.isRetry,
        "retryAttempts": widget.retryAttempts,
        "doFirstPayment": widget.doFirstPayment,
      });
    }

    // Optional params
    requestData.addAll({
      "custom1": widget.custom1,
      "custom2": widget.custom2,
      "customerPhone": widget.customerPhone,
      "billingAddressStreet2": widget.billingAddressStreet2,
      "billingCompanyName": widget.billingCompanyName,
      "billingAddressPostcodeZip": widget.billingAddressPostcodeZip,
      "billingAddressStateProvince": widget.billingAddressStateProvince,
      "shippingContactFirstName": widget.shippingContactFirstName,
      "shippingContactLastName": widget.shippingContactLastName,
      "shippingContactMobilePhone": widget.shippingContactMobilePhone,
      "shippingContactPhone": widget.shippingContactPhone,
      "shippingContactEmail": widget.shippingContactEmail,
      "shippingCompanyName": widget.shippingCompanyName,
      "shippingAddressStreet": widget.shippingAddressStreet,
      "shippingAddressStreet2": widget.shippingAddressStreet2,
      "shippingAddressCity": widget.shippingAddressCity,
      "shippingAddressStateProvince": widget.shippingAddressStateProvince,
      "shippingAddressCountry": widget.shippingAddressCountry,
      "shippingAddressPostcodeZip": widget.shippingAddressPostcodeZip,
    });

    final response = await http.post(
      Uri.parse('https://payable-ipg-dev.web.app/ipg/dev'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      setState(() {
        // Get the response URL
        _responseUrl = jsonDecode(response.body)['url'];
      });
    } else {
      throw Exception('Failed to load URL');
    }
  }

  Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
