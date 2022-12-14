import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payable_ipg/payable_ipg.dart';

// Initialization PAYable IPG Client
PAYableIPGClient ipgClient = PAYableIPGClient(
  merchantKey: "A75BCD8EF30E529A",
  merchantToken: "B8727C74D29E210F9A297B65690C0140",
  refererUrl: "https://www.sandboxmerdev.payable.lk",
  logoUrl: "https://i.imgur.com/l21F5us.png",
  environment: IPGEnvironment.sandbox, // optional
);

PAYableIPG payableIPG = PAYableIPG(
  ipgClient: ipgClient,
  amount: 100.45,
  currencyCode: "LKR",
  orderDescription: "Netflix",
  customerFirstName: "Aslam",
  customerLastName: "Kasun",
  customerEmail: "test@org.lk",
  customerMobilePhone: "0777123456",
  billingAddressStreet: "Hill Street",
  billingAddressCity: "Dehiwala",
  billingAddressCountry: "LK",
  billingAddressPostcodeZip: "10350",
  onPaymentCompleted: (data) {
    Fluttertoast.showToast(msg: "onPaymentCompleted: $data");
  },
  onPaymentCancelled: () {
    Fluttertoast.showToast(msg: "onPaymentCancelled");
  },
  onPaymentError: (data) {
    Fluttertoast.showToast(msg: "onPaymentError: $data");
  },
);

PAYableIPGSession payableIPGSession = PAYableIPGSession(
  uid: "9727F698-C1CE-4E22-96C6-9635EE600BA3",
  onPaymentCompleted: (data) {
    Fluttertoast.showToast(msg: "onPaymentCompleted: $data");
  },
  onPaymentCancelled: () {
    Fluttertoast.showToast(msg: "onPaymentCancelled");
  },
  onPaymentError: (data) {
    Fluttertoast.showToast(msg: "onPaymentError: $data");
  },
  environment: IPGEnvironment.sandbox,
);

void getStatus(String uid, String resultIndicator) async {
  var data = await ipgClient.getStatus(uid, resultIndicator);
  print(data);
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("PAYable IPG Demo"),
        ),
        body: payableIPG,
      ),
    ),
  );
}
