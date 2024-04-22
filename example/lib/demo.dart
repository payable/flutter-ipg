import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';

PayableIPG payableIPG = const PayableIPG(
  paymentType: 1,
  logoUrl: "",
  returnUrl: "",
  checkValue: "E57182F9304558C2475604DE27A41762736973EFFADBA1E6A4540FF2A3B1357147C54D541DCE0C5E381795CB26ABE9F76E45796447D4509E43BAA15A6F923831",
  orderDescription: "Order description goes here",
  invoiceId: "43123412",
  merchantKey: "A748BFC24F8F6C61",
  customerFirstName: "Tashila",
  customerLastName: "Pathum",
  customerMobilePhone: "0770507499",
  customerEmail: "tashila.payable@gmail.com",
  billingAddressStreet: "Hill Street",
  billingAddressCity: "Colombo",
  billingAddressCountry: "LK",
  amount: "500.00",
  currencyCode: "LKR",
);

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Payable IPG Demo"),
        ),
        body: payableIPG,
      ),
    ),
  );
}