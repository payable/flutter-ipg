import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum IPGEnvironment { production, sandbox }

typedef OnPaymentPageLoaded = void Function();

typedef OnPaymentStarted = void Function();

typedef OnPaymentError = void Function(String error);

typedef OnPaymentCancelled = void Function();

typedef OnPaymentCompleted = void Function(String data);

class PAYableIPG extends StatefulWidget {
  //
  String merchantKey;
  String merchantToken;
  String refererUrl;
  String logoUrl;

  num amount;
  String currencyCode;
  String orderDescription;

  String customerFirstName;
  String customerLastName;
  String customerEmail;
  String customerMobilePhone;
  String billingAddressStreet;
  String billingAddressCity;
  String billingAddressCountry;
  String billingAddressPostcodeZip;
  String? billingAddressStateProvince;

  String? shippingContactFirstName;
  String? shippingContactLastName;
  String? shippingContactEmail;
  String? shippingContactMobilePhone;
  String? shippingAddressStreet;
  String? shippingAddressCity;
  String? shippingAddressCountry;
  String? shippingAddressPostcodeZip;
  String? shippingAddressStateProvince;

  String? notificationUrl;

  int buttonType;
  int statusViewDuration;

  IPGEnvironment environment;
  bool debug;

  OnPaymentPageLoaded? onPaymentPageLoaded;
  OnPaymentStarted? onPaymentStarted;

  OnPaymentError onPaymentError;
  OnPaymentCancelled onPaymentCancelled;
  OnPaymentCompleted onPaymentCompleted;

  PAYableIPG({
    Key? key,
    required this.merchantKey,
    required this.merchantToken,
    required this.refererUrl,
    required this.logoUrl,
    required this.amount,
    required this.currencyCode,
    required this.orderDescription,
    required this.customerFirstName,
    required this.customerLastName,
    required this.customerEmail,
    required this.customerMobilePhone,
    required this.billingAddressStreet,
    required this.billingAddressCity,
    required this.billingAddressCountry,
    required this.billingAddressPostcodeZip,
    this.billingAddressStateProvince,
    this.shippingContactFirstName,
    this.shippingContactLastName,
    this.shippingContactEmail,
    this.shippingContactMobilePhone,
    this.shippingAddressStreet,
    this.shippingAddressCity,
    this.shippingAddressCountry,
    this.shippingAddressPostcodeZip,
    this.shippingAddressStateProvince,
    this.notificationUrl,
    this.buttonType = 2,
    this.statusViewDuration = 5,
    this.environment = IPGEnvironment.production,
    this.debug = false,
    this.onPaymentPageLoaded,
    this.onPaymentStarted,
    required this.onPaymentError,
    required this.onPaymentCancelled,
    required this.onPaymentCompleted,
  }) : super(key: key);

  @override
  State<PAYableIPG> createState() => _PAYableIPGState();
}

class _PAYableIPGState extends State<PAYableIPG> {
  var _isLoading = false;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PAYable Payment'),
        ),
        body: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                //controller.complete(webViewController);
                _webViewController = controller;

                List<String> queryList = [];

                queryList.add(
                  'https://us-central1-payable-mobile.cloudfunctions.net/ipg/${widget.environment.name}/?',
                );

                queryList.add(
                  'merchantKey=${widget.merchantKey}',
                );

                queryList.add(
                  '&merchantToken=${widget.merchantToken}',
                );

                queryList.add(
                  '&integrationType=MSDK',
                );

                queryList.add(
                  '&integrationVersion=1.0.1',
                );

                queryList.add(
                  '&refererUrl=${widget.refererUrl}',
                );

                queryList.add(
                  '&logoUrl=${widget.logoUrl}',
                );

                queryList.add(
                  '&notificationUrl=${widget.notificationUrl}',
                );

                queryList.add(
                  '&returnUrl=https://us-central1-payable-mobile.cloudfunctions.net/ipg/status-view',
                );

                queryList.add(
                  '&buttonType=${widget.buttonType}',
                );

                queryList.add(
                  '&statusViewDuration=${widget.statusViewDuration}',
                );

                queryList.add(
                  '&amount=${widget.amount}',
                );

                queryList.add(
                  '&currencyCode=${widget.currencyCode}',
                );

                queryList.add(
                  '&orderDescription=${widget.orderDescription}',
                );

                queryList.add(
                  '&customerFirstName=${widget.customerFirstName}',
                );

                queryList.add(
                  '&customerLastName=${widget.customerLastName}',
                );

                queryList.add(
                  '&customerEmail=${widget.customerEmail}',
                );

                queryList.add(
                  '&customerMobilePhone=${widget.customerMobilePhone}',
                );

                queryList.add(
                  '&billingAddressStreet=${widget.billingAddressStreet}',
                );

                queryList.add(
                  '&billingAddressCity=${widget.billingAddressCity}',
                );

                queryList.add(
                  '&billingAddressCountry=${widget.billingAddressCountry}',
                );

                queryList.add(
                  '&billingAddressPostcodeZip=${widget.billingAddressPostcodeZip}',
                );

                if (widget.billingAddressStateProvince != null) {
                  queryList.add(
                    '&billingAddressStateProvince=${widget.billingAddressStateProvince}',
                  );
                }

                if (widget.shippingContactFirstName != null) {
                  queryList.add(
                    '&shippingContactFirstName=${widget.shippingContactFirstName}',
                  );
                }
                if (widget.shippingContactLastName != null) {
                  queryList.add(
                    '&shippingContactLastName=${widget.shippingContactLastName}',
                  );
                }

                if (widget.shippingContactEmail != null) {
                  queryList.add(
                    '&shippingContactEmail=${widget.shippingContactEmail}',
                  );
                }

                if (widget.shippingContactMobilePhone != null) {
                  queryList.add(
                    '&shippingContactMobilePhone=${widget.shippingContactMobilePhone}',
                  );
                }

                if (widget.shippingAddressStreet != null) {
                  queryList.add(
                    '&shippingAddressStreet=${widget.shippingAddressStreet}',
                  );
                }

                if (widget.shippingAddressCity != null) {
                  queryList.add(
                    '&shippingAddressCity=${widget.shippingAddressCity}',
                  );
                }

                if (widget.shippingAddressCountry != null) {
                  queryList.add(
                    '&shippingAddressCountry=${widget.shippingAddressCountry}',
                  );
                }

                if (widget.shippingAddressPostcodeZip != null) {
                  queryList.add(
                    '&shippingAddressPostcodeZip=${widget.shippingAddressPostcodeZip}',
                  );
                }

                if (widget.shippingAddressStateProvince != null) {
                  queryList.add(
                    '&shippingAddressStateProvince=${widget.shippingAddressStateProvince}',
                  );
                }

                queryList.add('&responseType=html');

                _webViewController.loadUrl(queryList.join());
              },
              onProgress: (progress) {
                showProgressDialog(context);
              },
              onPageFinished: (url) {
                Navigator.pop(context);
                _webViewController.runJavascriptReturningResult("(function(){return window.document.body.outerHTML})();").then((response) {
                  var content = response.replaceAll("\\u003C", "<");
                  if (content == "null" ||
                      content == "\"<body></body>\"" ||
                      content.contains("Web page not available") ||
                      content.contains("Something went wrong!") ||
                      content.contains("err-message")) {
                    var error = content == "null" ? "unknown" : "network";
                    if (content.contains("err-message")) {
                      try {
                        var data = content.replaceAll(RegExp(r'<[^>]*>'), "").replaceAll("\\", "");
                        var json = data.substring(data.indexOf("{"), data.lastIndexOf("}") + 1);
                        error = jsonDecode(json)['error']['err-message'];
                      } catch (ex) {
                        console("error => ex: $ex");
                      }
                    }
                    console("error => content: $error");
                    showErrorDialog(context, "Something went wrong\n$error");
                  }
                });
              },
              javascriptChannels: _createJavascriptChannels(context),
            ),
          ],
        ));
  }

  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'onPaymentPageLoaded',
        onMessageReceived: (message) {
          if (widget.onPaymentPageLoaded != null) {
            widget.onPaymentPageLoaded!();
          }
        },
      ),
      JavascriptChannel(
        name: 'onPaymentStarted',
        onMessageReceived: (message) {
          if (widget.onPaymentStarted != null) {
            widget.onPaymentStarted!();
          }
        },
      ),
      JavascriptChannel(
        name: 'onPaymentError',
        onMessageReceived: (message) {
          widget.onPaymentError(message.toString());
        },
      ),
      JavascriptChannel(
        name: 'onPaymentCancelled',
        onMessageReceived: (message) {
          widget.onPaymentCancelled();
        },
      ),
      JavascriptChannel(
        name: 'onPaymentCompleted',
        onMessageReceived: (message) {
          widget.onPaymentCompleted(message.toString());
        },
      ),
    };
  }

  showProgressDialog(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.red.withOpacity(0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text(
                  'One moment...',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    _isLoading = false;
  }

  showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(1),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Error'),
            content: Text(
              message,
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {},
              )
            ],
          ),
        );
      },
    );
  }

  console(message) {
    if (kDebugMode) {
      print("PAYABLE-IPG-FLUTTER $message");
    }
  }
}
