import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WPDetails extends StatefulWidget {
  const WPDetails({super.key, required this.wpUrl});
  static const routeName = '/wp_details';

  final String wpUrl;

  @override
  State<WPDetails> createState() => _WPDetailsState();
}

class _WPDetailsState extends State<WPDetails> {
  late final WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse((widget.wpUrl)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
