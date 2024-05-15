import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payable_ipg/payable_ipg.dart';
import 'package:payable_ipg_demo/form_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'error_dialog.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? errorMessage;
  PAYableIPGClient? myIpgClient;
  PAYableIPG? payableIPG;

  @override
  Widget build(BuildContext context) {
    _loadData();
    payableIPG?.onPaymentSuccess = (data) {
      log('Payment success: ${data.statusIndicator}');
      Navigator.popUntil(context, (route) => route.isFirst);
    };
    payableIPG?.onPaymentError = (message) {
      log('Payment error: $message');
      setState(() {
        errorMessage = message;
      });
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Stack(
        children: [
          if (payableIPG != null) payableIPG!,
          if (errorMessage != null) ErrorDialog(errorMessage: errorMessage!),
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    CheckoutFormData form = Get.find();

    setState(() {
      myIpgClient = PAYableIPGClient(
          logoUrl: prefs.getString('logoUrl') ?? '',
          returnUrl: 'https://com.example.payable_ipg_example',
          merchantKey: prefs.getString('merchantKey') ?? '',
          merchantToken: prefs.getString('merchantToken') ?? '',
          webhookUrl: prefs.getString('notificationUrl') ?? '',
          environment: IPGEnvironment.sandbox
      );

      payableIPG =  PAYableIPG(
        ipgClient: myIpgClient!,
        paymentType: form.paymentType,
        orderDescription: form.orderDescription!,
        invoiceId: getInvoiceId(),
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
      );
    });
  }

  String getInvoiceId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
        List.generate(8, (index) => chars.codeUnitAt(math.Random().nextInt(chars.length)))
    );
  }
}
