import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payable_ipg_flutter/payable_ipg_flutter.dart';
import 'package:payable_ipg_demo/form_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PAYableIPGClient? _myIpgClient;
  PAYableIPG? _payableIPG;
  List<String>? _errorMessages;
  bool _loadIPG = true;

  @override
  Widget build(BuildContext context) {
    _loadData();

    Widget children;
    if (_payableIPG != null && _loadIPG) {
      children = _payableIPG as Widget;
    } else if (_errorMessages != null) {
      children = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...?_errorMessages?.map((errorMessage) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              )),
        ],
      );
    } else {
      children = Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Stack(
        children: [children],
      ),
    );
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    CheckoutFormData form = Get.find();

    setState(() {
      _myIpgClient = PAYableIPGClient(
          logoUrl: prefs.getString('logoUrl') ?? '',
          returnUrl: 'https://com.example.payable_ipg_example',
          merchantKey: prefs.getString('merchantKey') ?? '',
          merchantToken: prefs.getString('merchantToken') ?? '',
          webhookUrl: prefs.getString('notificationUrl') ?? '',
          environment: IPGEnvironment.dev);

      _payableIPG = PAYableIPG(
          ipgClient: _myIpgClient!,
          paymentType: form.paymentType,
          orderDescription: form.orderDescription!,
          invoiceId: _getInvoiceId(),
          customerFirstName: form.billingFirstName!,
          customerLastName: form.billingLastName!,
          customerMobilePhone: form.billingMobile!,
          customerEmail: form.billingEmail!,
          billingAddressStreet: form.billingStreetAddress1!,
          billingAddressCity: form.billingTownCity!,
          billingAddressCountry: form.billingCountry!,
          billingAddressPostcodeZip: form.billingPostcode,
          amount: form.amount!,
          currencyCode: form.currency!,
          custom1: form.custom1,
          custom2: form.custom2,
          customerPhone: form.billingPhone,
          billingAddressStreet2: form.billingStreetAddress2,
          billingCompanyName: form.billingCompanyName,
          billingAddressStateProvince: form.billingProvince,
          shippingContactFirstName: form.shippingFirstName,
          shippingContactLastName: form.shippingLastName,
          shippingContactMobilePhone: form.shippingMobile,
          shippingContactPhone: form.shippingPhone,
          shippingContactEmail: form.shippingEmail,
          shippingCompanyName: form.billingCompanyName,
          shippingAddressStreet: form.shippingStreetAddress1,
          shippingAddressStreet2: form.shippingStreetAddress2,
          shippingAddressCity: form.shippingTownCity,
          shippingAddressStateProvince: form.shippingTownCity,
          shippingAddressCountry: form.shippingCountry,
          shippingAddressPostcodeZip: form.shippingPostcode,
          startDate: form.startDate,
          endDate: form.endDate,
          recurringAmount: form.recurringAmount,
          interval: form.interval,
          isRetry: form.isRetry,
          retryAttempts: form.retryAttempts,
          doFirstPayment: form.doFirstPayment,

          onPaymentStarted: (data) {
            log('Payment started');
          },
          onPaymentCompleted: (data) {
            log('Payment completed');
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          onPaymentError: (data) {
            log('Payment error');
            if (data.status == 3009) {
              final errorMap = data.error;
              final errorMessages =
                  errorMap.values.expand((list) => list).toList();
              setState(() {
                _loadIPG = false;
                _errorMessages = errorMessages.cast<String>();
              });
            }
          },
          onPaymentCancelled: () {
            log('Payment cancelled');
            Navigator.pop(context);
          });
    });
  }

  String _getInvoiceId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(List.generate(
        8, (index) => chars.codeUnitAt(math.Random().nextInt(chars.length))));
  }
}
