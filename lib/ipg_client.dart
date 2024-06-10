import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'environment.dart';

class PAYableIPGClient {
  /// URL for your company's logo
  final String logoUrl;
  /// Called when the user tap 'Go Home' after completing a payment, which will
  /// trigger [PAYableIPG.onPaymentCompleted].
  final String returnUrl;
  /// The merchant key provided in merchant portal.
  final String merchantKey;
  /// The merchant token provided in merchant portal.
  final String merchantToken;
  /// The payment information will be notifies to this URL.
  final String? webhookUrl;
  /// Default is [IPGEnvironment.production].
  final IPGEnvironment? environment;

  /// Sets the params applicable for all payments.
  const PAYableIPGClient({
    required this.logoUrl,
    required this.returnUrl,
    required this.merchantKey,
    required this.merchantToken,
    this.webhookUrl,
    this.environment,
  });

  /// Provides the status of a specific payment by using [uid] and
  /// [statusIndicator] acquired when starting or completing the payment.
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
