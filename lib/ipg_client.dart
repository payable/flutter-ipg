import 'dart:convert';
import 'dart:developer';

import 'package:payable_ipg/environment.dart';
import 'package:http/http.dart' as http;

class PAYableIPGClient {
  final String logoUrl;
  final String returnUrl;
  final String merchantKey;
  final String merchantToken;
  final String? webhookUrl;
  final IPGEnvironment? environment;

  const PAYableIPGClient({
    required this.logoUrl,
    required this.returnUrl,
    required this.merchantKey,
    required this.merchantToken,
    this.webhookUrl,
    this.environment,
  });

  Future<String> getStatus({required String uid, required String statusIndicator}) async {
    final Map<String, dynamic> requestData = {
      "uid": uid,
      "statusIndicator": statusIndicator
    };
    String endpoint = "${getEndpoint(environment)}/check-status";
    String json = jsonEncode(requestData);
    log("Sending request: $json");

    // Make request
    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json,
    );

    // Get response
    log("Response: ${response.body}");
    return response.body;
  }
}
