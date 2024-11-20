import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookWebViewScreen extends StatefulWidget {
  final String bookUrl;

  const BookWebViewScreen(String link, {super.key, required this.bookUrl});

  @override
  _BookWebViewScreenState createState() => _BookWebViewScreenState();
}

class _BookWebViewScreenState extends State<BookWebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally handle progress updates
            debugPrint('Loading progress: $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('HTTP error: ${error.response.toString()}');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('Blocked navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bookUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Viewer'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
