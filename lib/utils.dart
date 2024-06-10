library payable_ipg.utils;

import 'package:package_info/package_info.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

Future<String> getPackageName() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.packageName;
}

Future<String> getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

String getCheckValue({
  required String merchantKey,
  required String merchantToken,
  required String invoiceId,
  required String amount,
  required String currencyCode
}) {
  String hash1 = sha512.convert(utf8.encode(merchantToken)).toString().toUpperCase();
  String hash2 = sha512.convert(utf8.encode("$merchantKey|$invoiceId|$amount|$currencyCode|$hash1")).toString().toUpperCase();
  return hash2;
}