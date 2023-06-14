// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadMoreNews extends StatefulWidget {
  String newsUrl;

  ReadMoreNews({
    Key? key,
    required this.newsUrl,
  }) : super(key: key);

  @override
  State<ReadMoreNews> createState() => _ReadMoreNewsState();
}

class _ReadMoreNewsState extends State<ReadMoreNews> {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.newsUrl = widget.newsUrl.contains("http:")
          ? widget.newsUrl.replaceAll("http:", "https:")
          : widget.newsUrl;
    });
  }

// create webview controller
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.newsUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            controller.complete(webViewController);
          });
        },
      ),
    );
  }
}
