import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class WebViewTerms extends StatefulWidget {
  const WebViewTerms({Key? key}) : super(key: key);

  @override
  _WebViewTermsState createState() => _WebViewTermsState();
}

class _WebViewTermsState extends State<WebViewTerms> {
  String lang = '';
  bool isLoading = true; // Initial loading state

  @override
  void initState() {
    super.initState();
    initAwaits();
  }

  Future<void> initAwaits() async {
    Locale locale = await getLocale();
    setState(() {
      lang = locale.languageCode;
    });
    log(lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          getTranslated(context, "Terms and Conditions")!,
          style: TextStyle(
            color: ColorsManager.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          child: const Icon(CupertinoIcons.back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: LoadingOverlay(
        progressIndicator: const SpinKitSpinningLines(
          color: ColorsManager.primary,
        ),
        color: const Color.fromRGBO(254, 222, 0, 0.1),
        isLoading: isLoading,
        child: WebView(
          initialUrl: (lang == 'en')
              ? "https://ezhalhakw.com/ezhalha/terms_en"
              : "https://ezhalhakw.com/ezhalha/terms_ar",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            // WebView created
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false; // Hide loader when page content is loaded
            });
          },
        ),
      ),
    );
  }
}
