import 'package:flutter/material.dart';
import 'package:payable_ipg_demo/checkout.dart';
import 'package:payable_ipg_demo/billing_details.dart';
import 'package:payable_ipg_demo/pages.dart';
import 'package:payable_ipg_demo/settings.dart';
import 'package:payable_ipg_demo/shipping_details.dart';
import 'home.dart';

//4508750015741019

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
      },
    ),
  );
}
