import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';
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
    payableIPG?.onPaymentError = (message) {
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

    setState(() {
      myIpgClient = PAYableIPGClient(
          logoUrl: prefs.getString('logoUrl') ?? '',
          returnUrl: prefs.getString('notificationUrl') ?? '',
          merchantKey: prefs.getString('merchantKey') ?? '',
          merchantToken: prefs.getString('merchantToken') ?? '',
          webhookUrl: "https://ipgv2-ntb.payable.lk/new-js-sdk/api/"
      );

      payableIPG =  PAYableIPG(
        ipgClient: myIpgClient!,
        paymentType: "1",
        orderDescription: "Order description goes here",
        invoiceId: "7e81374801",
        customerFirstName: "Tashila",
        customerLastName: "Pathum",
        customerMobilePhone: "0770507499",
        customerEmail: "tashila.payable@gmail.com",
        billingAddressStreet: "Hill Street",
        billingAddressCity: "Colombo",
        billingAddressCountry: "LK",
        billingAddressPostcodeZip: "0000",
        amount: "200.00",
        currencyCode: "LKR",
      );
    });
  }
}
