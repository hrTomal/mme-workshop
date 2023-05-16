import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MeetingWebview extends StatefulWidget {
  const MeetingWebview({
    super.key,
    required this.meetingUrl,
  });
  static const routeName = '/meeting_webview';
  final String meetingUrl;

  @override
  State<MeetingWebview> createState() => _MeetingWebviewState();
}

class _MeetingWebviewState extends State<MeetingWebview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('MeetingMe'),
      // ),
      body: SafeArea(
        child: Center(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse('https://live.shor.tn/${widget.meetingUrl}'),
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform:
                  InAppWebViewOptions(useShouldOverrideUrlLoading: true),
            ),
          ),
        ),
      ),
    );
  }
}
