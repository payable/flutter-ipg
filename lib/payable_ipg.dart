import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

enum IPGEnvironment {
  production,
  sandbox,
}

class PAYableIPGClient {
  String merchantKey;
  String merchantToken;
  String refererUrl;
  String logoUrl;
  IPGEnvironment environment;

  PAYableIPGClient({
    required this.merchantKey,
    required this.merchantToken,
    required this.refererUrl,
    required this.logoUrl,
    this.environment = IPGEnvironment.production,
  });

  Future<String> getStatus(String uid, String resultIndicator) async {
    var url = Uri.parse('https://us-central1-payable-mobile.cloudfunctions.net/ipg/${environment.name}/status-view').replace(queryParameters: {
      'uid': uid,
      'resultIndicator': resultIndicator,
      'responseType': 'json',
    });

    try {
      var response = await http.get(url);
      return response.body;
    } catch (ex) {
      return ex.toString();
    }
  }
}

typedef OnPaymentPageLoaded = void Function();

typedef OnPaymentStarted = void Function();

typedef OnPaymentError = void Function(String error);

typedef OnPaymentCancelled = void Function();

typedef OnPaymentCompleted = void Function(String data);

class PAYableIPG extends StatefulWidget {
  PAYableIPGClient ipgClient;

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

  OnPaymentPageLoaded? onPaymentPageLoaded;
  OnPaymentStarted? onPaymentStarted;

  OnPaymentError onPaymentError;
  OnPaymentCancelled onPaymentCancelled;
  OnPaymentCompleted onPaymentCompleted;

  String? uid;

  PAYableIPG({
    Key? key,
    required this.ipgClient,
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
    this.onPaymentPageLoaded,
    this.onPaymentStarted,
    required this.onPaymentError,
    required this.onPaymentCancelled,
    required this.onPaymentCompleted,
    this.uid,
  }) : super(key: key);

  @override
  State<PAYableIPG> createState() => _PAYableIPGState();
}

class _PAYableIPGState extends State<PAYableIPG> {
  var _isLoading = false;
  String? _errorMessage;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            // controller.complete(webViewController);
            _webViewController = controller;

            List<String> queryList = [];

            queryList.add(
              'https://us-central1-payable-mobile.cloudfunctions.net/ipg/${widget.ipgClient.environment.name}/?',
            );

            if (widget.uid != null) {
              queryList.add(
                'uid=${widget.uid}',
              );
            } else {
              queryList.add(
                'merchantKey=${widget.ipgClient.merchantKey}',
              );

              queryList.add(
                '&merchantToken=${widget.ipgClient.merchantToken}',
              );

              queryList.add(
                '&integrationType=MSDK',
              );

              queryList.add(
                '&integrationVersion=1.0.1',
              );

              queryList.add(
                '&refererUrl=${widget.ipgClient.refererUrl}',
              );

              queryList.add(
                '&logoUrl=${widget.ipgClient.logoUrl}',
              );

              queryList.add(
                '&notificationUrl=${widget.notificationUrl}',
              );

              queryList.add(
                '&returnUrl=https://us-central1-payable-mobile.cloudfunctions.net/ipg/${widget.ipgClient.environment.name}/status-view',
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
            }

            _webViewController.loadUrl(queryList.join());
          },
          onProgress: (progress) {
            if (!_isLoading) {
              setState(() {
                _isLoading = true;
              });
            }
            // showProgressDialog(context);
          },
          onPageFinished: (url) {
            if (_isLoading) {
              setState(() {
                _isLoading = false;
              });
            }
            _webViewController.runJavascriptReturningResult("(function(){return window.document.body.outerHTML})();").then((response) {
              var content = response.replaceAll("\\u003C", "<");
              if (content == "null" || content == "\"<body></body>\"" || content.contains("Web page not available") || content.contains("Something went wrong!") || content.contains("err-message")) {
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
                setState(() {
                  _errorMessage = error;
                });
                // showErrorDialog(context, "Something went wrong\n$error");
              }
            });
          },
          javascriptChannels: _createJavascriptChannels(context),
        ),
        if (_isLoading) viewMessage(true, "One moment..."),
        if (_errorMessage != null) viewMessage(false, _errorMessage.toString(), opacity: 1),
      ],
    );
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
          widget.onPaymentError(message.message);
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
          widget.onPaymentCompleted(message.message);
        },
      ),
    };
  }

  viewMessage(bool progress, String message, {double opacity = 0.8}) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.white.withOpacity(opacity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (progress) const CircularProgressIndicator(),
          if (progress) const SizedBox(width: 20),
          Text(
            message,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  console(message) {
    if (kDebugMode) {
      print("PAYABLE-IPG-FLUTTER $message");
    }
  }
}

class PAYableIPGSession extends StatelessWidget {
  String uid;
  OnPaymentPageLoaded? onPaymentPageLoaded;
  OnPaymentStarted? onPaymentStarted;
  OnPaymentError onPaymentError;
  OnPaymentCancelled onPaymentCancelled;
  OnPaymentCompleted onPaymentCompleted;
  IPGEnvironment environment;

  PAYableIPGSession({
    Key? key,
    required this.uid,
    this.onPaymentPageLoaded,
    this.onPaymentStarted,
    required this.onPaymentError,
    required this.onPaymentCancelled,
    required this.onPaymentCompleted,
    this.environment = IPGEnvironment.production,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PAYableIPG(
      ipgClient: PAYableIPGClient(
        merchantKey: "-",
        merchantToken: "-",
        refererUrl: "-",
        logoUrl: "-",
        environment: environment,
      ),
      uid: uid,
      amount: 0,
      currencyCode: "-",
      orderDescription: "-",
      customerFirstName: "-",
      customerLastName: "-",
      customerEmail: "-",
      customerMobilePhone: "-",
      billingAddressStreet: "-",
      billingAddressCity: "-",
      billingAddressCountry: "-",
      billingAddressPostcodeZip: "-",
      billingAddressStateProvince: "-",
      onPaymentPageLoaded: onPaymentPageLoaded,
      onPaymentStarted: onPaymentStarted,
      onPaymentCompleted: onPaymentCompleted,
      onPaymentCancelled: onPaymentCancelled,
      onPaymentError: onPaymentError,
    );
  }
}
