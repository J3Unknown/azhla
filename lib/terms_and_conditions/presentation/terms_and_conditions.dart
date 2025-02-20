// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:loading_overlay/loading_overlay.dart';
//
// import '../../contatct_us_screen/domain/about_us_service.dart';
// import '../../utill/localization_helper.dart';
//
// class TermsAndCondition extends StatefulWidget {
//   const TermsAndCondition({Key? key}) : super(key: key);
//
//   @override
//   _TermsAndConditionState createState() => _TermsAndConditionState();
// }
//
// class _TermsAndConditionState extends State<TermsAndCondition> {
//   bool isLoading =true;
//    String? body;
//   bool isAR = false;
//   void initState() {
//
//     initAwaits();
//   }
//   Future<void> initAwaits() async {
//     await getTerms();
//     getLang();
//
//   }
//   Future getTerms() async {
//     AboutUsService.aboutUSApi(context).then((value) {
//       log(value.toString());
//       setState(() {
//         body = value!.terms.toString();
//         isLoading = false;
//       });
//       // log(intList!.length.toString());
//     });
//   }
//   void getLang() {
//     // setState(() {
//     //   isLoading = true;
//     // });
//     getLocale().then((value) {
//       isAR = value.languageCode == "en"
//           ? false
//           : true;
//
//       setState(() {
//        // isLoading = false;
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     if(isAR == false) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           // leading: InkWell(child:Icon(CupertinoIcons.back),),
//           title:  Text(getTranslated(context, "Terms and Conditions")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
//           centerTitle: true,
//         ),
//         body:
//         LoadingOverlay(
//             progressIndicator: SpinKitSpinningLines(
//               color: Color.fromRGBO(254, 222, 0, 1),
//             ),
//             color: Color.fromRGBO(254, 222, 0, 0.1),
//             isLoading: isLoading,
//             child: isLoading == true
//                 ? Container()
//                 :
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Padding(
//                   //   padding: EdgeInsets.only(top: 70.0.h, left: 70.w),
//                   //   child: Text(
//                   //     getTranslated(context, "Terms and Conditions")!,
//                   //     style: TextStyle(
//                   //       color: Colors.black87, fontSize: 25.sp,),),
//                   // ),
//                   Column(
//
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only( left: 10.w),
//                         child: Center(child: Text(
//                           body.toString() , overflow: TextOverflow.clip,
//                           style: TextStyle(
//                             color: Colors.black87, fontSize: 25.sp,),)),
//                       ),
//                       SizedBox(height: 20.h,),
//                       // Container(
//                       //     height: 60.h,
//                       //     width: MediaQuery
//                       //         .of(context)
//                       //         .size
//                       //         .width * 0.9,
//                       //     decoration: BoxDecoration(
//                       //         color: Color.fromRGBO(170, 143, 10, 1),
//                       //         boxShadow: [
//                       //           BoxShadow(
//                       //             color: Colors.grey.withOpacity(0.2),
//                       //             spreadRadius: 3,
//                       //             blurRadius: 3,
//                       //             offset: Offset(
//                       //                 0, 0), // changes position of shadow
//                       //           ),
//                       //         ],
//                       //         borderRadius: BorderRadius.circular(5)
//                       //     ),
//                       //     child: InkWell(
//                       //       child: Row(
//                       //         children: [
//                       //           SizedBox(
//                       //             width: 20.w,
//                       //
//                       //           ),
//                       //           Text(getTranslated(context, "Back")!,
//                       //             style: TextStyle(color: Colors.white,
//                       //                 fontSize: 20.sp,
//                       //                 fontWeight: FontWeight.bold),),
//                       //           SizedBox(
//                       //             width: 220.w,
//                       //
//                       //           ),
//                       //           Icon(Icons.arrow_forward,
//                       //             color: Colors.white, size: 35.sp,),
//                       //         ],
//                       //       ),
//                       //       onTap: () {
//                       //         Navigator.pop(context);
//                       //       },
//                       //     )),
//                     ],
//                   ),
//
//                 ],
//               ),
//             )),
//       );
//     }
//     else{
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           // leading: InkWell(child:Icon(CupertinoIcons.back),),
//           title:  Text(getTranslated(context, "Terms and Conditions")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
//           centerTitle: true,
//         ),
//         body:
//         LoadingOverlay(
//             progressIndicator: SpinKitSpinningLines(
//               color: Color.fromRGBO(254, 222, 0, 1),
//             ),
//             color: Color.fromRGBO(254, 222, 0, 0.1),
//             isLoading: isLoading,
//             child:isLoading == true
//                 ? Container()
//                 :
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                       children: [
//                         // Container(
//                         //   width: MediaQuery.of(context).size.width,
//                         //   height: 650.h,
//                         //   decoration: BoxDecoration(
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     image:DecorationImage(
//                         //         image: AssetImage("assets/image/Background.png"),
//                         //         fit: BoxFit.cover
//                         //     ),
//                         //   ),
//                         //
//                         // ),
//                         // Padding(
//                         //   padding:  EdgeInsets.only(top:40.0.h,right: 120.w),
//                         //   child: Text(getTranslated(context, "Terms & Conditions")! ,style: TextStyle(color: Colors.black87,fontSize: 25.sp,),),
//                         // ),
//                         Column(
//
//                           children: [
//                             Padding(
//                               padding:  EdgeInsets.only(right: 10.w),
//                               child: Center(child: Text(body.toString(),overflow: TextOverflow.clip,style: TextStyle(color: Colors.black87,fontSize: 25.sp,),)),
//                             ),
//                             SizedBox(height: 20.h,),
//                             // Container(
//                             //     height: 60.h,
//                             //     width:MediaQuery.of(context).size.width * 0.9,
//                             //     decoration: BoxDecoration(
//                             //         color: Color.fromRGBO(222, 192 , 0, 1),
//                             //         boxShadow: [
//                             //           BoxShadow(
//                             //             color: Colors.grey.withOpacity(0.2),
//                             //             spreadRadius: 3,
//                             //             blurRadius: 3,
//                             //             offset: Offset(0, 0), // changes position of shadow
//                             //           ),
//                             //         ],
//                             //         borderRadius: BorderRadius.circular(5)
//                             //     ),
//                             //     child: InkWell(
//                             //       child: Row(
//                             //         children: [
//                             //           SizedBox(
//                             //             width: 20.w,
//                             //
//                             //           ),
//                             //           Text(getTranslated(context, "Back")!,style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
//                             //           SizedBox(
//                             //             width: 220.w,
//                             //
//                             //           ),
//                             //           Icon(Icons.arrow_forward,color: Colors.white,size: 35.sp,),
//                             //         ],
//                             //       ),
//                             //       onTap: (){
//                             //         Navigator.pop(context);
//                             //       },
//                             //     )),
//                           ],
//                         ),
//                       ]
//                   ),
//
//                 ],
//               ),
//             )),
//       );
//     }
//   }
// }
