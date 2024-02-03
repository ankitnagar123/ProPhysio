

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/Network/Apis.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';

class DPrivacyPolicy extends StatefulWidget {
  const DPrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<DPrivacyPolicy> createState() => _DPrivacyPolicyState();
}

class _DPrivacyPolicyState extends State<DPrivacyPolicy> {
  CustomView custom = CustomView();
  late final WebViewController _controller;
  bool loding = true;
  LocalString text = LocalString();
  bool rememberme = false;


  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            loding == true;
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            // loding == true;
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() {
              loding = false;
            });
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          MyAPI.urls+MyAPI.DPandP));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        elevation: 0,
        centerTitle: true,
        title:
        custom.text("Privacy Policy", 17, FontWeight.w500, MyColor.black),
      ),
      body: loding == true
          ? Center(
        child: custom.MyIndicator(),
      )
          : WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
