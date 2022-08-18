import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PAYableIPG(
        merchantKey: "A748BFC24F8F6C61",
        merchantToken: "A8907A75E36A210DE82CDB65430B2E1F",
        refererUrl: "https://www.payable.lk",
        logoUrl: "https://bizenglish.adaderana.lk/wp-content/uploads/NOLIMIT-logo.jpg",
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
        // billingAddressStateProvince: "Western",
        // shippingContactFirstName: "Aslam",
        // shippingContactLastName: "Anver",
        // shippingContactEmail: "aslam@payable.lk",
        // shippingContactMobilePhone: "0762724081",
        // shippingAddressStreet: "Hill Street",
        // shippingAddressCity: "Dehiwala",
        // shippingAddressCountry: "LK",
        // shippingAddressPostcodeZip: "10350",
        // shippingAddressStateProvince: "Western",
        // notificationUrl: "https://us-central1-payable-mobile.cloudfunctions.net/ipg/request-test",
        // environment: Environment.production,
        // debug: true,
        onPaymentCompleted: (data) {
          //Fluttertoast.showToast(msg: "onPaymentCompleted: $data");
        },
        onPaymentCancelled: () {
          //Fluttertoast.showToast(msg: "onPaymentCancelled");
        },
        onPaymentError: (data) {
          //Fluttertoast.showToast(msg: "onPaymentError: $data");
        },
      ),
    );
  }
}
