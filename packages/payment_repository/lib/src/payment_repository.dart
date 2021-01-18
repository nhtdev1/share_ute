import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:payment_repository/payment_repository.dart';

class PaymentRepository {
  Future<String> createCheckout(String packageType) async {
    final auth = 'Basic ' + base64Encode(utf8.encode(Config.secretKey));
    final package = _getPackge(packageType);
    final body = {
      'payment_method_types': ['card'],
      'line_items': [
        package,
      ],
      'mode': 'subscription',
      'success_url': Config.successUrl,
      'cancel_url': Config.cancelUrl,
    };

    try {
      final result = await Dio().post(
        'https://api.stripe.com/v1/checkout/sessions',
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: 'application/x-www-form-urlencoded',
        ),
      );
      return result.data['id'];
    } on DioError catch (e, s) {
      print(e.response);
      throw e;
    }
  }

  _getPackge(String packageType) {
    if (packageType == '1') {
      return Config.oneMonthPackage;
    }
    if (packageType == '2') {
      return Config.threeMonthsPackage;
    }
    return Config.oneYearPackage;
  }
}
