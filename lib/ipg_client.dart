import 'package:payable_ipg/environment.dart';

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
}
