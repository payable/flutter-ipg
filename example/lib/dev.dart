import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payable_ipg/payable_ipg.dart';

// Initialization PAYable IPG Client

String _uid = "9727F698-C1CE-4E22-96C6-9635EE600BA3";
IPGEnvironment _ipgEnvironment = IPGEnvironment.sandbox;
String? _resultIndicator;

PAYableIPGClient getPAYableIPGClient(IPGEnvironment ipgEnvironment) {
  if (ipgEnvironment == IPGEnvironment.production) {
    return PAYableIPGClient(
      merchantKey: "2C60AC94E06CFC1B",
      merchantToken: "DC9420BC7EBC2E38A19A931BB8B099EB",
      refererUrl: "https://ipgmobileteam.payable.lk",
      logoUrl: "https://i.imgur.com/l21F5us.png",
    );
  } else {
    return PAYableIPGClient(
      merchantKey: "A75BCD8EF30E529A",
      merchantToken: "B8727C74D29E210F9A297B65690C0140",
      refererUrl: "https://www.sandboxmerdev.payable.lk",
      logoUrl: "https://i.imgur.com/l21F5us.png",
      environment: IPGEnvironment.sandbox, // optional
    );
  }
}

PAYableIPG getPAYableIPG(IPGEnvironment ipgEnvironment) {
  PAYableIPGClient ipgClient = getPAYableIPGClient(ipgEnvironment);
  return PAYableIPG(
    ipgClient: ipgClient,
    amount: 2.00,
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
    billingAddressStateProvince: "Western",
    shippingContactFirstName: "Aslam",
    shippingContactLastName: "Kasun",
    shippingContactEmail: "test@org.lk",
    shippingContactMobilePhone: "0777123456",
    shippingAddressStreet: "Hill Street",
    shippingAddressCity: "Dehiwala",
    shippingAddressCountry: "LK",
    shippingAddressPostcodeZip: "10350",
    shippingAddressStateProvince: "Western",
    notificationUrl: "https://us-central1-payable-mobile.cloudfunctions.net/ipg/request-test",
    onPaymentCompleted: (data) {
      Fluttertoast.showToast(msg: "onPaymentCompleted: $data");
      var json = jsonDecode(data);
      _uid = json['uid'];
      _resultIndicator = json['resultIndicator'];
    },
    onPaymentPageLoaded: (uid) {
      Fluttertoast.showToast(msg: "onPaymentPageLoaded: $uid");
      _uid = uid;
      _ipgEnvironment = ipgClient.environment;
    },
    onPaymentStarted: () {
      Fluttertoast.showToast(msg: "onPaymentStarted");
    },
    onPaymentCancelled: () {
      Fluttertoast.showToast(msg: "onPaymentCancelled");
    },
    onPaymentError: (data) {
      Fluttertoast.showToast(msg: "onPaymentError: $data");
    },
  );
}

PAYableIPGSession getPAYableIPGSession(String uid, IPGEnvironment ipgEnvironment) {
  return PAYableIPGSession(
    uid: uid,
    onPaymentCompleted: (data) {
      Fluttertoast.showToast(msg: "onPaymentCompleted: $data");
      var json = jsonDecode(data);
      _uid = json['uid'];
      _resultIndicator = json['resultIndicator'];
    },
    onPaymentPageLoaded: (uid) {
      Fluttertoast.showToast(msg: "onPaymentPageLoaded: $uid");
    },
    onPaymentStarted: () {
      Fluttertoast.showToast(msg: "onPaymentStarted");
    },
    onPaymentCancelled: () {
      Fluttertoast.showToast(msg: "onPaymentCancelled");
    },
    onPaymentError: (data) {
      Fluttertoast.showToast(msg: "onPaymentError: $data");
    },
    environment: ipgEnvironment,
  );
}

void main() {
  runApp(
    const MaterialApp(
      home: Dashboard(),
    ),
  );
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAYable IPG Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: const Text('Sandbox'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Sandbox'),
                        ),
                        body: getPAYableIPG(IPGEnvironment.sandbox),
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: const Text('Production'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Production'),
                        ),
                        body: getPAYableIPG(IPGEnvironment.production),
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: const Text('Session ID'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Session ID'),
                        ),
                        body: getPAYableIPGSession(_uid, _ipgEnvironment),
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
            ),
            if (_resultIndicator != null)
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  child: const Text('Status'),
                  onPressed: () {
                    PAYableIPGClient ipgClient = getPAYableIPGClient(_ipgEnvironment);
                    ipgClient.getStatus(_uid, _resultIndicator!).then((response) {
                      Fluttertoast.showToast(msg: response);
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
