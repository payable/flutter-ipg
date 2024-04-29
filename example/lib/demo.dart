import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';
import 'package:payable_ipg/payable_ipg_client.dart';

PAYableIPGClient myIpgClient = const PAYableIPGClient(
  logoUrl: "https://i.imgur.com/l21F5us.png",
  returnUrl: "https://example.com/receipt",
  merchantKey: "A748BFC24F8F6C61",
  merchantToken: "09FD8632EED1D1FEB9AD9A5E55427452"
);

PAYableIPG payableIPG = PAYableIPG(
  ipgClient: myIpgClient,
  paymentType: "1",
  orderDescription: "Order description goes here",
  invoiceId: "645855868",
  customerFirstName: "Tashila",
  customerLastName: "Pathum",
  customerMobilePhone: "0770507499",
  customerEmail: "tashila.payable@gmail.com",
  billingAddressStreet: "Hill Street",
  billingAddressCity: "Colombo",
  billingAddressCountry: "LK",
  billingAddressPostcodeZip: "0000",
  amount: "100.00",
  currencyCode: "LKR",
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: payableIPG,
      ),
    ),
  );
}