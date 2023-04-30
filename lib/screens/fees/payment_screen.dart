import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({
    super.key,
    required this.paymentUrl,
  });

  final String paymentUrl;

  static const routeName = '/payment';

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState(paymentUrl);
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  final String paymentUrl;

  _PaymentWebViewState(this.paymentUrl);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.paymentUrl),
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform:
                InAppWebViewOptions(useShouldOverrideUrlLoading: true),
          ),
        ),
      ),
    );
  }
}
