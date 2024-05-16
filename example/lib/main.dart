import 'package:flutter/material.dart';
import 'package:payable_ipg_demo/forms/checkout.dart';
import 'package:payable_ipg_demo/forms/billing_details.dart';
import 'package:payable_ipg_demo/forms/payment_details.dart';
import 'package:payable_ipg_demo/pages.dart';
import 'package:payable_ipg_demo/payment.dart';
import 'package:payable_ipg_demo/settings.dart';
import 'package:payable_ipg_demo/forms/shipping_details.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Payable IPG Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: Pages.home,
      routes: {
        Pages.home: (context) => const HomePage(),
        Pages.settings: (context) => const SettingsPage(),
        Pages.checkout: (context) => const CheckoutPage(),
        Pages.billingDetails: (context) => const BillingDetailsPage(),
        Pages.shippingDetails: (context) => const ShippingDetailsPage(),
        Pages.paymentDetails: (context) => const PaymentDetailsPage(),
        Pages.pay: (context) => const PaymentPage(),
      },
    ),
  );
}
