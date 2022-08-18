import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payable_ipg/payable_ipg.dart';

void main() {
  // Initialization PAYable IPG Client
  PAYableIPGClient ipgClient = PAYableIPGClient(
    merchantKey: "A75BCD8EF30E529A",
    merchantToken: "B8727C74D29E210F9A297B65690C0140",
    refererUrl: "https://www.sandboxmerdev.payable.lk",
    logoUrl: "https://bizenglish.adaderana.lk/wp-content/uploads/NOLIMIT-logo.jpg",
    environment: IPGEnvironment.sandbox, // optional
  );

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("PAYable IPG Demo"),
        ),
        body: PAYableIPG(
          ipgClient: ipgClient,
          amount: 100.45,
          currencyCode: "LKR",
          orderDescription: "Netflix",
          customerFirstName: "Aslam",
          customerLastName: "Anver",
          customerEmail: "aslam@payable.lk",
          customerMobilePhone: "0762724081",
          billingAddressStreet: "String",
          billingAddressCity: "Hill Street",
          billingAddressCountry: "LK",
          billingAddressPostcodeZip: "10350",
          billingAddressStateProvince: "Western",
          shippingContactFirstName: "Aslam",
          shippingContactLastName: "Anver",
          shippingContactEmail: "aslam@payable.lk",
          shippingContactMobilePhone: "0762724081",
          shippingAddressStreet: "Hill Street",
          shippingAddressCity: "Dehiwala",
          shippingAddressCountry: "LK",
          shippingAddressPostcodeZip: "10350",
          shippingAddressStateProvince: "Western",
          notificationUrl: "https://us-central1-payable-mobile.cloudfunctions.net/ipg/request-test",
          onPaymentCompleted: (data) {
            Fluttertoast.showToast(msg: "onPaymentCompleted: $data");
          },
          onPaymentCancelled: () {
            Fluttertoast.showToast(msg: "onPaymentCancelled");
          },
          onPaymentError: (data) {
            Fluttertoast.showToast(msg: "onPaymentError: $data");
          },
        ),
      ),
    ),
  );
}
