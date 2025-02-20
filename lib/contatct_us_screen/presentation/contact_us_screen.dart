import 'dart:developer';

import 'package:azhlha/contatct_us_screen/Data/about_us_data.dart';
import 'package:azhlha/contatct_us_screen/domain/about_us_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../shared/validations.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  AboutUs ?aboutUs;
  bool isLoading =true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final formGlobalKey = GlobalKey < FormState > ();

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }
  void loadData(){
    AboutUsService.aboutUSApi(context).then((value) {
      log(value.toString());
      setState(() {
       aboutUs = value;
       isLoading = false;
      });
      // log(intList!.length.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
          title:  Text(getTranslated(context, "Contact Us")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: LoadingOverlay(
            progressIndicator: SpinKitSpinningLines(
              color: ColorsManager.primary,
            ),
            color: Color.fromRGBO(254, 222, 0, 0.1),
            isLoading: isLoading,
            child: isLoading == true
                ? Container():SingleChildScrollView(
          child: Form(
            key:formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h,),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated(context, "Name")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                      SizedBox(height: 5.h,),
                      Container(
                        height: 50.h,
                        width: 0.8.sw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(
                                color: ColorsManager.primary
                            )
                        ),
                        child: Center(
                          child: TextFormField(
                              validator: RequiredValidator(errorText: 'This field is required'),
                              controller: titleController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: getTranslated(context, "Name")!,
                                contentPadding: EdgeInsets.all(5.w),
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated(context, "Mobile Number")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                    SizedBox(height: 5.h,),

                    Container(
                      height: 50.h,
                      width: 0.8.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                              color: ColorsManager.primary
                          )
                      ),
                      child: Center(
                        child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'This field is required'),
                              MinLengthValidator(10, errorText: getTranslated(context, "Minimum length is characters")!+'10'),
                              MaxLengthValidator(12, errorText: getTranslated(context, "Maximum length is characters")!+'12')
                            ]),
                            controller: mobileController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 12,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly, // Allow only numeric input
                            //   LengthLimitingTextInputFormatter(12),  // Enforces maximum length
                            //   MinLengthEnforcer(minLength: 10),      // Custom logic for minimum length
                            // ],
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: getTranslated(context, "Mobile Number")!,
                              contentPadding: EdgeInsets.all(5.w),
                            )
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated(context, "Message")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                    SizedBox(height: 5.h,),

                    Container(
                      height: 150.h,
                      width: 0.8.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                              color: ColorsManager.primary
                          )
                      ),
                      child: Center(
                        child: TextFormField(
                            validator: RequiredValidator(errorText: 'This field is required'),
                            controller: messageController,
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: getTranslated(context, "Message")!,
                              contentPadding: EdgeInsets.all(5.w),
                            )
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.h,),
                Center(
                  child: InkWell(
                    child: Container(
                      height: 50.h,
                      width: 0.8.sw,
                      decoration: BoxDecoration(
                          color: ColorsManager.primary,
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                            color: ColorsManager.primary,
                          )
                      ),
                      child: Center(child: Text(getTranslated(context, "Send")!,style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold),)),
                    ),
                    onTap: () => sendOnClick(),
                  ),
                ),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/image/whatsapp.png")
                          )
                        ),
                      ),
                      onTap: (){
                        launchWhatsApp(aboutUs!.whatsappNumber!);
                      },
                    ),
                    SizedBox(width: 20.w,),
                    InkWell(
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/image/facebook.png")
                            )
                        ),
                      ),
                      onTap: (){
                        log(aboutUs!.facebook!);
                        launchURL(aboutUs!.facebook!);
                      },
                    ),
                    SizedBox(width:20.w),
                    InkWell(
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/image/instgram.png"),
                            )
                        ),
                      ),
                      onTap: (){
                        launchURL(aboutUs!.insta!);
                      },
                    ),

                  ],
                )
              ],
            ),
          ),
        )),
      ),
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();

      },
    );
  }
  void sendOnClick(){
    if(!formGlobalKey.currentState!.validate())
      return;
    AboutUsService.sendContactMessage(context, mobileController.text,titleController.text, messageController.text);
  }
  Future<void> launchWhatsApp(String phone) async {
    final link = WhatsAppUnilink(
      phoneNumber: '${phone}',
      text: "",
    );
    await launch('$link');
  }
  Future<void> launchURL(String url) async {
    launch(url);
  }
}
