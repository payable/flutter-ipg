import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payable_ipg/return_data.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'environment.dart';
import 'ipg_client.dart';
import 'utils.dart';

class PAYableIPG extends StatefulWidget {
  final PAYableIPGClient ipgClient;

  // Required params for any payment
  final String? orderDescription;
  final String invoiceId;
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
  final int paymentType;
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

  OnPaymentSuccess? onPaymentSuccess;
  OnPaymentError? onPaymentError;

  PAYableIPG(
      {super.key,
      required this.ipgClient,
      required this.paymentType,
      required this.orderDescription,
      required this.invoiceId,
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
      this.onPaymentSuccess,
      this.onPaymentError});

  @override
  PAYableIPGState createState() => PAYableIPGState();
}

class PAYableIPGState extends State<PAYableIPG> {
  String? _responseUrl;

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    fetchResponseUrl();
  }

  Future<void> fetchResponseUrl() async {
    final Map<String, dynamic> requestData = {
      // Set by the developer
      "logoUrl": widget.ipgClient.logoUrl,
      "returnUrl": widget.ipgClient.returnUrl,
      "webhookUrl": widget.ipgClient.webhookUrl,
      "merchantKey": widget.ipgClient.merchantKey,
      "paymentType": widget.paymentType,

      // Hardcoded, developer is not allowed to set the values
      "isMobilePayment": 1,
      "integrationType": "Android SDK",
      "integrationVersion": "2.0.0",
      "statusReturnUrl": "https://payable-ipg-dev.web.app/ipg/dev/status-view",

      // Generated internally, developer is not allowed to set the values
      "packageName": await getPackageName(),
      "checkValue": getCheckValue(
          merchantKey: widget.ipgClient.merchantKey,
          merchantToken: widget.ipgClient.merchantToken,
          invoiceId: widget.invoiceId,
          amount: widget.amount,
          currencyCode: widget.currencyCode),

      // Required params for all payments
      "orderDescription": (widget.orderDescription != null && widget.orderDescription!.isNotEmpty)?
      widget.orderDescription : 'Order from Payable Mobile Payment',
      "invoiceId": widget.invoiceId,
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

    // Required params for recurring payments only
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
      if (widget.custom1 != null) "custom1": widget.custom1,
      if (widget.custom2 != null) "custom2": widget.custom2,
      if (widget.customerPhone != null) "customerPhone": widget.customerPhone,
      if (widget.billingAddressStreet2 != null)
        "billingAddressStreet2": widget.billingAddressStreet2,
      if (widget.billingCompanyName != null)
        "billingCompanyName": widget.billingCompanyName,
      if (widget.billingAddressPostcodeZip != null)
        "billingAddressPostcodeZip": widget.billingAddressPostcodeZip,
      if (widget.billingAddressStateProvince != null)
        "billingAddressStateProvince": widget.billingAddressStateProvince,
      if (widget.shippingContactFirstName != null)
        "shippingContactFirstName": widget.shippingContactFirstName,
      if (widget.shippingContactLastName != null)
        "shippingContactLastName": widget.shippingContactLastName,
      if (widget.shippingContactMobilePhone != null)
        "shippingContactMobilePhone": widget.shippingContactMobilePhone,
      if (widget.shippingContactPhone != null)
        "shippingContactPhone": widget.shippingContactPhone,
      if (widget.shippingContactEmail != null)
        "shippingContactEmail": widget.shippingContactEmail,
      if (widget.shippingCompanyName != null)
        "shippingCompanyName": widget.shippingCompanyName,
      if (widget.shippingAddressStreet != null)
        "shippingAddressStreet": widget.shippingAddressStreet,
      if (widget.shippingAddressStreet2 != null)
        "shippingAddressStreet2": widget.shippingAddressStreet2,
      if (widget.shippingAddressCity != null)
        "shippingAddressCity": widget.shippingAddressCity,
      if (widget.shippingAddressStateProvince != null)
        "shippingAddressStateProvince": widget.shippingAddressStateProvince,
      if (widget.shippingAddressCountry != null)
        "shippingAddressCountry": widget.shippingAddressCountry,
      if (widget.shippingAddressPostcodeZip != null)
        "shippingAddressPostcodeZip": widget.shippingAddressPostcodeZip,
    });

    // Prepare request
    String endpoint = getEndpoint(widget.ipgClient.environment);
    String json = jsonEncode(requestData);
    log("Sending request: $json");

    // Make request
    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json,
    );

    // Get response
    if (response.statusCode == 200) {
      log("Request success: ${response.body}");
      setState(() {
        _responseUrl = jsonDecode(response.body)['paymentPage'];
        controller
          ..setNavigationDelegate(NavigationDelegate(
              onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(widget.ipgClient.returnUrl)) {
              if (widget.onPaymentSuccess != null) {
                ReturnData data = getReturnData(request.url);
                widget.onPaymentSuccess!(data);
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          }))
          ..loadRequest(Uri.parse(_responseUrl!));
      });
    } else {
      log("Request error: ${response.statusCode}");
      if (widget.onPaymentError != null) {
        widget.onPaymentError!(response.body);
      }
    }
  }
}

typedef OnPaymentSuccess = void Function(ReturnData data)?;
typedef OnPaymentError = void Function(String message)?;