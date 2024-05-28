### PAYable IPG - Flutter Integration

![](https://i.imgur.com/ERpCDa7.png)

Flutter Package - [flutter-ipg.payable.lk](https://flutter-ipg.payable.lk) | [Create Issue](https://github.com/payable/flutter-ipg/issues/new)

[![Pub](https://img.shields.io/pub/v/payable_ipg.svg)](https://pub.dartlang.org/packages/payable_ipg)

<hr/>

### Initialization

<b>1.</b> Change the `minSdkVersion` as below from your app level `build.gradle` file.

```gradle
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

<b>2.</b> Add the below package into your `pubspec.yaml` file.

```yaml
payable_ipg: ^2.0.2
```

<hr/>

### Implementation

<b>1.</b> Import PAYable IPG SDK package.

```dart
import 'package:payable_ipg/payable_ipg.dart';
```

<b>2.</b> Create PAYable IPG client with `PAYableIPGClient`.

```dart 
PAYableIPGClient ipgClient = PAYableIPGClient(
    merchantKey: "YOUR_MERCHANT_KEY",
    merchantToken: "YOUR_MERCHANT_TOKEN",
    returnUrl: "YOUR_RETURN_URL_TO_REDIRECT",
    logoUrl: "YOUR_COMPANY_LOGO",
    environment: IPGEnvironment.sandbox, // only for testing
);
```

<b>3.</b> Call `PAYableIPG` into your application body.

> One-time payments
```dart
PAYableIPG(
    ipgClient: ipgClient,
    amount: 100.45,
    currencyCode: "LKR",
    paymentType: 1, // The value is 1 for one-time payments
    orderDescription: "Netflix",
    customerFirstName: "John",
    customerLastName: "Doe",
    customerEmail: "johndoe@gmail.com",
    customerMobilePhone: "0777123456",
    billingAddressStreet: "Hill Street",
    billingAddressCity: "Dehiwala",
    billingAddressCountry: "LK",
    billingAddressPostcodeZip: "10350"
)
```


> Recurring payments
```dart
PAYableIPG(
    ipgClient: ipgClient,
    amount: 0.00,
    currencyCode: "LKR",
    paymentType: 2, // The value is 2 for recurring payments
    orderDescription: "Play Pass",
    customerFirstName: "John",
    customerLastName: "Doe",
    customerEmail: "johndoe@gmail.com",
    customerMobilePhone: "0777123456",
    billingAddressStreet: "Hill Street",
    billingAddressCity: "Dehiwala",
    billingAddressCountry: "LK",
    billingAddressPostcodeZip: "10350"
    startDate: '2024-05-27',
    endDate: '2024-11-27',
    recurringAmount: 350.00,
    interval: 'MONTHLY', // Sets how often the payment is made. The value can be MONTHLY, QUARTERLY or YEARLY.
    isRetry: '1', // Sets whether automatic retying is allowed in case of a payment fails. (1 - allowed, 0 - not allowed)
    retryAttempts: '3', // Sets the amount of days that automatic retrying will be performed.
    doFirstPayment: '0', // Sets whether the user is making a payment in addition to the recurring amount.
)
```

> Optional params
```dart
custom1 // Merchant specific data
custom2 // Merchant specific data
billingPhone
billingCompanyName
billingStreetAddress2
billingProvince
shippingFirstName
shippingLastName
shippingMobile
shippingPhone
shippingEmail
shippingCompanyName
shippingStreetAddress1
shippingStreetAddress2
shippingTownCity
shippingProvince
shippingCountry // country code (LK, US, etc.)
shippingPostcode
```

<hr/>

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';

class _PaymentPageState extends State<PaymentPage> {
  PAYableIPGClient? _myIpgClient;
  PAYableIPG? _payableIPG;

  @override
  Widget build(BuildContext context) {
    _loadData();
    _payableIPG?.onPaymentStarted = (data) {
      log('Payment started');
    };
    _payableIPG?.onPaymentCompleted = (data) {
      log('Payment completed');
    };
    _payableIPG?.onPaymentError = (message) {
      log('Payment error: $message');
    };
    _payableIPG?.onPaymentCancelled = () {
      log('Payment cancelled');
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Stack(
        children: [
          if (_payableIPG != null) _payableIPG!,
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    setState(() {
        PAYableIPGClient myIpgClient = const PAYableIPGClient(
          logoUrl: "https://i.imgur.com/l21F5us.png",
          returnUrl: "https://example.com/receipt",
          merchantKey: "A748BFC24F8F6C61",
          merchantToken: "09FD8632EED1D1FEB9AD9A5E55427452",
          webhookUrl: "https://ipgv2-ntb.payable.lk/new-js-sdk/api/"
        );

        PAYableIPG payableIPG = PAYableIPG(
          ipgClient: myIpgClient,
          amount: "100.00",
          currencyCode: "LKR",
          paymentType: "1",
          orderDescription: "Order description goes here",
          invoiceId: _generateInvoiceId(),
          customerFirstName: "John",
          customerLastName: "Doe",
          customerMobilePhone: "0777123456",
          customerEmail: "johndoe@gmail.com",
          billingAddressStreet: "Hill Street",
          billingAddressCity: "Colombo",
          billingAddressCountry: "LK",
          billingAddressPostcodeZip: "70000"
        );
    }
  }
```
> Check the sample app for a full working code and more details on implementation.

<hr/>

### Advanced Usage

Check the status of the transaction using `uid` and `resultIndicator` receieved from `onPaymentStarted` or `onPaymentCompleted`.

```dart
var data = await ipgClient.getStatus("uid", "resultIndicator");
```

<hr/>

### API Documentation

This document contains all the HTTP APIs used in this package.

[ipg-mobile-api.payable.lk](https://ipg-mobile-api.payable.lk)

<hr/>

### Demo

![](https://raw.githubusercontent.com/payable/flutter-ipg/sprint7/screen.gif)

> If you want to do more customization on this package, you can get the source code from this repository and use it for further development.

<br>

PAYable IPG SDK - Flutter Integration
