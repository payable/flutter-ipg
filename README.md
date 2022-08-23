### PAYable IPG - Flutter Integration

![](https://i.imgur.com/ERpCDa7.png)

Flutter Package - [ipg.flutter.payable.lk](https://ipg.flutter.payable.lk) | [Create Issue](https://github.com/payable/flutter-ipg/issues/new)

[![Pub](https://img.shields.io/pub/v/payable_ipg.svg)](https://pub.dartlang.org/packages/payable_ipg)
[![Build Status](https://travis-ci.com/payable/flutter-ipg.svg?branch=master)](https://travis-ci.com/payable/flutter-ipg)

<hr/>

### Initialization

<b>1.</b> Change the `minSdkVersion` as below from your app level `build.gradle` file.

```gradle
android {
    defaultConfig {
        minSdkVersion 20
    }
}
```

<b>2.</b> Add the below package into your `pubspec.yaml` file.

```yaml
payable_ipg: ^1.1.1
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
    refererUrl: "YOUR_REQUEST_URL",
    logoUrl: "YOUR_COMPANY_LOGO",
    environment: IPGEnvironment.sandbox, // optional
);
```

<b>3.</b> Call `PAYableIPG` into your application body.

```dart
PAYableIPG(
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
      print("onPaymentCompleted: $data");
    },
    onPaymentCancelled: () {
      print("onPaymentCancelled");
    },
    onPaymentError: (data) {
      print("onPaymentError: $data");
    },
)
```

> Shipping details and notification URL are optional.

<hr/>

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';

void main() {
  
  PAYableIPGClient ipgClient = PAYableIPGClient(
    merchantKey: "YOUR_MERCHANT_KEY",
    merchantToken: "YOUR_MERCHANT_TOKEN",
    refererUrl: "YOUR_REQUEST_URL",
    logoUrl: "YOUR_COMPANY_LOGO",
    environment: IPGEnvironment.sandbox,
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
          customerLastName: "Kasun",
          customerEmail: "test@org.lk",
          customerMobilePhone: "0777123456",
          billingAddressStreet: "Hill Street",
          billingAddressCity: "Dehiwala",
          billingAddressCountry: "LK",
          billingAddressPostcodeZip: "10350",
          onPaymentCompleted: (data) {
            print("onPaymentCompleted: $data");
          },
          onPaymentCancelled: () {
            print("onPaymentCancelled");
          },
          onPaymentError: (data) {
            print("onPaymentError: $data");
          },
        ),
      ),
    ),
  );
}
```

<hr/>

### Advanced Usage

<b>1.</b> Pay with session `uid` without `merchantKey` and `merchantToken`.

```dart
PAYableIPGSession(
    uid: "969077C7-EBB5-428A-9F09-FF195560F200",
    onPaymentCompleted: (data) {
      print("onPaymentCompleted: $data");
    },
    onPaymentCancelled: () {
      print("onPaymentCancelled");
    },
    onPaymentError: (data) {
      print("onPaymentError: $data");
    },
    environment: IPGEnvironment.sandbox,
)
```

<b>2.</b> Check the status of the transaction using `uid` and `resultIndicator`.

```dart
var data = await ipgClient.getStatus("uid", "resultIndicator");
```

<hr/>

### API Documentation

This document contains all the HTTP APIs used in this package.

[ipg-mobile-api.payable.lk](https://ipg-mobile-api.payable.lk)

<hr/>

### Demo

![](https://raw.githubusercontent.com/payable/flutter-ipg/master/screen.gif)

> If you want to do more customizations on this package you can get the source code from this repository and use it for further developments.

PAYable IPG SDK - Flutter Integration
