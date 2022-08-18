### PAYable IPG SDK - Flutter Integration

![](https://i.imgur.com/ERpCDa7.png)

Flutter SDK - [ipg.flutter.payable.lk/](https://ipg.flutter.payable.lk) | [Create Issue](https://github.com/payable/flutter-ipg/issues/new)

[![Pub](https://img.shields.io/pub/v/payable_ipg.svg)](https://pub.dartlang.org/packages/payable_ipg)
[![Build Status](https://travis-ci.com/payable/flutter-ipg.svg?branch=master)](https://travis-ci.com/payable/flutter-ipg)

<hr>

### Initialization

1. Change the `minSdkVersion` as below from your app level `build.gradle` file.

```gradle
android {
    defaultConfig {
        minSdkVersion 20
    }
}
```

2. Add the below package into your `pubspec.yaml` file.

```yaml
payable_ipg: ^1.0.1
```

<hr>

### Implementation

<b>1.</b> Import PAYable IPG SDK package.

```dart
import 'package:payable_ipg/payable_ipg.dart';
```

<b>2.</b> Create PAYable IPG client with

```dart 
PAYableIPGClient ipgClient = PAYableIPGClient(
    merchantKey: "A75BCD8EF30E529A",
    merchantToken: "B8727C74D29E210F9A297B65690C0140",
    refererUrl: "https://www.sandboxmerdev.payable.lk",
    logoUrl: "https://bizenglish.adaderana.lk/wp-content/uploads/NOLIMIT-logo.jpg",
    environment: IPGEnvironment.sandbox,
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

* Optional parameters

```java
payableSale.setReceiptEmail("test@payable.lk");
payableSale.setReceiptSMS("0110000000");
payableSale.setOrderTracking("invoice56");
payableSale.setTerminalId("1254");
```

<hr/>

### Advanced Usage

##### PAYable events

| Method | Callback
|--|--|
| `boolean requestProfileList()` | `onProfileList(List<PayableProfile> payableProfiles)`
| `boolean requestVoid(String txId)` | `onVoid(PayableResponse payableResponse)`

* `PayableProfile`

```java
String tid;
String name;
String currency;
Integer installment;
```

* `PAYableResponse`

```java
int status;
String txId;
String error;
```

<hr/>

##### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:payable_ipg/payable_ipg.dart';

void main() {
  
  PAYableIPGClient ipgClient = PAYableIPGClient(
    merchantKey: "A75BCD8EF30E529A",
    merchantToken: "B8727C74D29E210F9A297B65690C0140",
    refererUrl: "https://www.sandboxmerdev.payable.lk",
    logoUrl: "https://bizenglish.adaderana.lk/wp-content/uploads/NOLIMIT-logo.jpg",
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

PAYable IPG SDK - Flutter Integration