library payable_ipg.utils;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_html/html.dart' as html;

Future<String> getPackageName() async {
  if (kIsWeb) {
    final origin = html.window.location.origin!; // Wrong warning; don't remove.
    return origin.replaceFirst(RegExp(r'^https?://'), '');
  } else {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
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