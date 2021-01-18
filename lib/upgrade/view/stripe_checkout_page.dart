import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:payment_repository/payment_repository.dart';

class StripeCheckoutPage extends StatefulWidget {
  final String sessionId;

  final Function activePremium;

  const StripeCheckoutPage({
    Key key,
    this.sessionId,
    this.activePremium,
  }) : super(key: key);

  @override
  _StripeCheckoutPageState createState() => _StripeCheckoutPageState();
}

class _StripeCheckoutPageState extends State<StripeCheckoutPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) =>
            _webViewController = webViewController,
        onPageFinished: (String url) {
          if (url == initialUrl) {
            _redirectToStripe(widget.sessionId);
          }
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(Config.successUrl)) {
            print('Succesfully!');
            widget.activePremium();
            Navigator.pop(context);
          } else if (request.url.startsWith(Config.cancelUrl)) {
            print('Failure !');
            Navigator.pop(context);
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  String get initialUrl => 'https://thinhhoangnguyen.github.io/';

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
    var stripe = Stripe(\'${Config.apiKey}\');
    stripe.redirectToCheckout({
      sessionId: '$sessionId'
      }).then(function (result) {
        result.error.message = 'Error'
        });
    ''';

    try {
      await _webViewController.evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }
}
