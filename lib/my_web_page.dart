import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'core/app/app_name.dart';
import 'core/service/webview_service.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewService.createController(AppName.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenue"),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}