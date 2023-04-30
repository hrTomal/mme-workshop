// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentWebView extends StatefulWidget {
//   const PaymentWebView({
//     super.key,
//     required this.paymentUrl,
//   });

//   final String paymentUrl;

//   static const routeName = '/payment_web';

//   @override
//   State<PaymentWebView> createState() => _PaymentWebViewState(paymentUrl);
// }

// class _PaymentWebViewState extends State<PaymentWebView> {
//   late final WebViewController _controller;
//   final String paymentUrl;

//   _PaymentWebViewState(this.paymentUrl);

//   @override
//   void initState() {
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.google.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse((paymentUrl)));

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: Center(
//         child: WebViewWidget(
//           controller: _controller,
//         ),
//       ),
//     );
//   }
// }
