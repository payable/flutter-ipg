import 'package:flutter/material.dart';
import 'package:payable_ipg_demo/checkout.dart';
import 'package:payable_ipg_demo/contact_details.dart';
import 'package:payable_ipg_demo/pages.dart';
import 'package:payable_ipg_demo/settings.dart';

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
        Pages.contactDetails: (context) => const ContactDetailsPage(),
      },
    ),
  );
}
