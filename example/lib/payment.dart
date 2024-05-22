import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payable_ipg/payable_ipg.dart';
import 'package:payable_ipg/utils.dart';
import 'package:payable_ipg_demo/form_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'error_dialog.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _errorMessage;
  PAYableIPGClient? _myIpgClient;
  PAYableIPG? _payableIPG;

  @override
  Widget build(BuildContext context) {
    _loadData();
    _payableIPG?.onPaymentStarted = (data) {
      log('Payment started');
    };
    _payableIPG?.onPaymentCompleted = (data) {
      log('Payment completed');
      Navigator.popUntil(context, (route) => route.isFirst);
    };
    _payableIPG?.onPaymentError = (data) {
      log('Payment error');
      setState(() {
        _errorMessage = getError(data);
      });
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Stack(
        children: [
          if (_payableIPG != null) _payableIPG!,
          if (_errorMessage != null) ErrorDialog(errorMessage: _errorMessage!),
        ],
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
          environment: IPGEnvironment.dev
      );

      _payableIPG =  PAYableIPG(
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
      );
    });
  }

  String _getInvoiceId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
        List.generate(8, (index) => chars.codeUnitAt(math.Random().nextInt(chars.length)))
    );
  }

  String getError(String json) {
    final Map<String, dynamic> data = jsonDecode(json) as Map<String, dynamic>;

    if (data['errors'] != null) {
      // Iterate through the first list of errors (assuming there can be multiple error messages per field)
      for (final errorList in data['errors'].values) {
        if (errorList is List) {
          for (final errorMessage in errorList) {
            // Extract only alphanumeric characters, spaces, and common punctuation
            final String filteredMessage = RegExp(r'^[a-zA-Z0-9\s\-.,!?:]+$').stringMatch(errorMessage) ?? '';
            if (filteredMessage.isNotEmpty) {
              return filteredMessage;
            }
          }
        }
      }
    }

    if (json.contains('logoUrl')) {
      return 'Please enter a valid Logo URL';
    }

    return 'Something went wrong';
  }
}
