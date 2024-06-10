import 'dart:convert';
import 'dart:developer';

class ErrorData {
  late int status;
  late Map<String, dynamic> error;

  ErrorData({
    required this.status,
    required this.error,
  });
}

ErrorData getErrorData(String responseData) {
  final genericError = {'error': ['Something went wrong. Please contact your merchant.']};

  final errorData = ErrorData(
    status: 400,
    error: genericError,
  );

  try {
    final jsonData = jsonDecode(responseData);
    if (jsonData is! Map) {
      return errorData;
    }

    final statusCode = jsonData['status'] as int?;
    if (statusCode == null) {
      return errorData;
    }

    switch (statusCode) {
      case 403:
        errorData.error = jsonData['error']['message'];
        break;
      case 400:
        if (jsonData.containsKey('errors')) {
          errorData.status = 3009;
          errorData.error = jsonData['errors'];
        }
        break;
      case 500:
        errorData.status = 500;
        errorData.error = jsonData['error'];
        break;
      default:
        errorData.error = genericError;
    }
  } on FormatException catch (e) {
    errorData.error = genericError;
    log(e.toString());
  }

  return errorData;
}