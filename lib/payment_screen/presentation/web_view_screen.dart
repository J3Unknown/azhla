import 'dart:convert';
import 'dart:developer';
import 'package:azhlha/payment_screen/presentation/failure_screen.dart';
import 'package:azhlha/payment_screen/presentation/sucess_screen.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../domain/payment_service.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  late String address_id;
  late String total_price;
  late String type;

  WebViewScreen({required this.url,required this.address_id,required this.total_price,required this.type});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController webViewController;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title:  Text(getTranslated(context, "Payment")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.refresh),
          //   onPressed: () {
          //     webViewController.reload();
          //   },
          // ),
        ],
      ),
      body:  WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      onProgress: (progress) {
        // Show loading overlay until progress is 100%
        setState(() {
          isLoading = progress < 100;
        });
      },
        onPageFinished: (url) async {
          // setState(() {
          //   isLoading = false;
          //
          // });
          // Evaluate JavaScript to get page content
          String? pageContent = await webViewController.runJavascriptReturningResult(
            "document.body.innerText",
          );

          // Process page content
          if (pageContent != null && pageContent.isNotEmpty) {
            try {
              // Decode JSON if the page content is JSON
              Map<String, dynamic> response = jsonDecode(pageContent);

              if (response['success'] == true) {

                PaymentServcie.confirmOrder(context,widget.address_id.toString(),widget.type).then((value){
                  log(value.toString());
                  setState(() {
                    if(value == true){
                      //showToast(context,"done");
                      // loadData();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (BuildContext context) => SuccessScreen(MSG: response['msg'],)));
                    }
                  });
                  //log(basket.length.toString());
                });
              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => FailureScreen(MSG: response['msg'])));
              }
            } catch (e) {
              print("Error parsing JSON: $e");
            }
          }
        },
        onWebResourceError: (error) {
          print('Error loading page: ${error.description}');
        },
      ),
    );
  }

  void showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
