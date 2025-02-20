import 'dart:developer';

import 'package:azhlha/forget_password_screen/presentation/password_screen.dart';
import 'package:azhlha/otp_screen/domain/otp_service.dart';
import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/sign_up_screen/data/sign_up.dart';
import 'package:azhlha/sign_up_screen/sign_up_service/sign_up_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../buttom_nav_bar/presentation/buttom_nav_screen.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class OtpPasswordScreen extends StatefulWidget {
  late String phone;
  late int firstOtp;
  OtpPasswordScreen({Key? key,required this.phone,required this.firstOtp}) : super(key: key);

  @override
  _OtpPasswordScreenState createState() => _OtpPasswordScreenState();
}

class _OtpPasswordScreenState extends State<OtpPasswordScreen> {
  late int otpCode;
  late String OTP;
  late String link;
  int counter = 60;
  late Locale locale;

  @override
  void initState() {
    // sendOTP();

    decrease();
    initAwaits();
    otpCode = widget.firstOtp;
    // TODO: implement initState
    super.initState();
  }


  void initAwaits () async{
    locale  = await getLocale();
    log("Got Locale" +locale.languageCode);
    setState(() {
      // isLoading = false;
    });
  }
  void decrease()async{
    while(counter >0){
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        counter = counter -1;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(CupertinoIcons.back),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200.h,),
            Center(child: Text(getTranslated(context,"Ezhalha")!,style: TextStyle(color: ColorsManager.primary,fontSize: 50.sp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 30.h,),
            Text(getTranslated(context, "Enter Received OTP")!,style: TextStyle(color: Colors.black87,fontSize: 20.sp),),
            SizedBox(height: 40.h,),
            Directionality(
              textDirection: TextDirection.ltr, // Forces LTR direction
              child: OtpTextField(
                numberOfFields: 4,
                focusedBorderColor: ColorsManager.primary,
                enabledBorderColor: ColorsManager.primary,
                disabledBorderColor: ColorsManager.primary,
                borderWidth: 0.5.w,
                fieldWidth: 60.w,
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                  // Handle code change
                },
                onSubmit: (String verificationCode) {
                  setState(() {
                    OTP = verificationCode;
                  });
                  log((otpCode.toString() == verificationCode).toString());
                },
              ),
            ),

            SizedBox(height: 60.h,),
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
                  child: Center(child: Text(getTranslated(context, "Confirm")!,style: TextStyle(color: Colors.white),)),
                ),
                onTap: (){
                  log(otpCode.toString());
                  log(OTP.toString());
                  if(otpCode.toString() == OTP.toString()) {
                    log("true");
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NewPasswordScreen(phone: widget.phone, otp: OTP.toString())) );

                    // onClick();
                  }
                  else{
                    showToastError(context, getTranslated(context, "OTP incorrect")!);
                    log("false");
                  }
                },
              ),
            ),
            SizedBox(height: 60.h,),
            Text(counter.toString(),style: TextStyle(fontSize: 24.sp,color: Colors.grey),),
            SizedBox(height: 30.h,),
            Center(
              child: InkWell(child:
              Center(
                child:locale.languageCode == 'ar'? Container(
                    height: 20.h,
                    width: 0.25.sw,
                    child:
                    Text(getTranslated(context, "Send again?")!,style: TextStyle(color: (counter == 0)?Colors.blue:Colors.black,fontSize: 17.sp),)
                )
                :
                Text(getTranslated(context, "Send again?")!,style: TextStyle(color: (counter == 0)?Colors.blue:Colors.black,fontSize: 17.sp),)
                ,
              ),
                onTap: (){

                  if(counter == 0) {
                    setState(() {
                      counter = 60;
                    });
                    sendOTP();
                  }
                },
              ),
            ),
            // SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }

  // void onClick(){
  //   SignUpService.signUp(context,widget.name,widget.phone,widget.password,OTP).then((data) async {
  //     if(data == null){
  //       setState(() {
  //         //isLoading = false;
  //       });
  //     }
  //     else{
  //       SignUpObject user = data;
  //       log("token!");
  //       SharedPreferences.getInstance().then((prefs){
  //         prefs.setString( 'token' , data.token.toString());
  //         prefs.setString( 'name' , user.name.toString() );
  //         prefs.setString( 'phone' , user.phone.toString() );
  //       });
  //       setState(() {
  //         //isLoading = false;
  //       });
  //
  //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)) );
  //     }
  //   });
  // }
  void sendOTP(){
    OtpService.sendOTPPassword(context, widget.phone).then((value){
      log(value.toString());
      setState(() {
        otpCode = value!.otpCode!;
        // launchWhatsApp(value!.otpLink!);
      });
      log(otpCode.toString());
    });
    decrease();
  }
  // _launchURL(String openLink) async {
  //   final Uri url = Uri.parse(openLink);
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
  Future<void> launchWhatsApp(String link) async {
    // final link = WhatsAppUnilink(
    //   phoneNumber: '${phone}',
    //   text: "",
    // );
    await launch('$link');
  }
}
