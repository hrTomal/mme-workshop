// import 'package:aamarpay/aamarpay.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentWebView extends StatefulWidget {
//   const PaymentWebView({
//     super.key,
//     required this.paymentUrl,
//   });

//   final String paymentUrl;

//   static const routeName = '/payment';

//   @override
//   State<PaymentWebView> createState() => _PaymentWebViewState(paymentUrl);
// }

// class _PaymentWebViewState extends State<PaymentWebView> {
//   late final WebViewController _controller;
//   final String paymentUrl;

//   _PaymentWebViewState(this.paymentUrl);

//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//       ),
//       body: Center(
//         child: Aamarpay(
//           // This will return a payment url based on failUrl,cancelUrl,successUrl
//           returnUrl: (String url) {
//             print(url);
//           },
//           // This will return the payment loading status
//           isLoading: (bool loading) {
//             setState(() {
//               isLoading = loading;
//             });
//           },
//           // This will return the payment event with a message
//           // status: (EventState event, String message) {
//           //   if (event == EventState.error) {
//           //     setState(() {
//           //       isLoading = false;
//           //     });
//           //   }
//           // },
//           // When you use your own url, you must have the keywords:cancel,confirm,fail otherwise the callback function will not work properly
//           cancelUrl: "example.com/payment/cancel",
//           successUrl:
//               "https://shop.meetingme.live/api/workshops/temp-user/payment-success/",
//           failUrl: "example.com/payment/fail",
//           customerEmail: "mailrony@gmail.com",
//           customerMobile: "01713115510",
//           customerName: "Arafat",
//           // That is the test signature key. But when you go to the production you must use your own signature key
//           signature: "35254501e0d0d621ea3486f02ec72ffb",
//           // That is the test storeID. But when you go to the production you must use your own storeID
//           storeID: "meetingme",
//           // Use transactionAmountFromTextField when you pass amount with TextEditingController
//           // transactionAmountFromTextField: amountTextEditingController,
//           transactionAmount: paymentUrl,
//           //The transactionID must be unique for every payment
//           transactionID: "${DateTime.now().millisecondsSinceEpoch}",
//           //The transactionID must be unique for every payment
//           // transactionID: "transactionID",
//           description: "test",
//           // When the application goes to the producation the isSandbox must be false
//           isSandBox: false,
//           child: Container(
//             color: Colors.orange,
//             height: 50,
//             child: Center(
//               child: Text(
//                 "Go to Payment",
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
