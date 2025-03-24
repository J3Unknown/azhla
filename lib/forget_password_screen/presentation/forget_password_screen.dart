import 'dart:developer';

import 'package:azhlha/otp_screen/presentation/otp_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../otp_screen/domain/otp_service.dart';
import '../../utill/assets_manager.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class FrogetPasswordScreen extends StatefulWidget {
  const FrogetPasswordScreen({Key? key}) : super(key: key);

  @override
  _FrogetPasswordScreenState createState() => _FrogetPasswordScreenState();
}

class _FrogetPasswordScreenState extends State<FrogetPasswordScreen> {
  TextEditingController phoneController = TextEditingController();
  late int otpCode;
  bool isLoading = false;
  late Locale locale;

  @override
  void initState() {
  initAwaits();
  // sendOTP();
  // TODO: implement initState
    super.initState();
  }
  void initAwaits () async{
    locale  = await getLocale();
    log("Got Locale" +locale.languageCode);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: ColorsManager.white,
      body: LoadingOverlay(
          progressIndicator: SpinKitSpinningLines(
            color: ColorsManager.primary,
          ),
          color: ColorsManager.primary0_1Transparency,
          isLoading: isLoading,
          child: isLoading == true
              ? Container()

              : SingleChildScrollView(
                child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath+AssetsManager.logo, height: 180, width: 180,),
          // Center(child: Text(getTranslated(context,"Maras")!,style: TextStyle(color: ColorsManager.primary,fontSize: 50.sp,fontWeight: FontWeight.bold),)),
          // SizedBox(height: 30.h,),
          Text(getTranslated(context, "Enter your Number")!,style: TextStyle(color: Colors.black87,fontSize: 24.sp, fontWeight: FontWeight.w500),),
          SizedBox(height: 40.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(getTranslated(context, "Phone Number")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
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
                  child: Row(
                    children: [
                      SizedBox(width: 5.h,),
                      (locale.languageCode == "en")?Text("+974",style: TextStyle(color: Colors.grey),):Container(),
                      Container(
                        height: 50.h,
                        width: 0.65.sw,
                        child: TextFormField(
                          controller: phoneController,
                            textAlign: TextAlign.center,
                            maxLength: 8,
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: getTranslated(context, "Mobile Number")!,
                              contentPadding: EdgeInsets.all(5.w),
                            )
                        ),
                      ),
                      (locale.languageCode == "ar")?Text("974+",style: TextStyle(color: Colors.grey),):Container()
                    ],
                  ),
                )
            ],
          ),
          SizedBox(height: 20.h,),
          SizedBox(height: 20.h,),
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
                  child: InkWell(
                      child: Center(child: Text(getTranslated(context, "Send")!,style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold),)),
                    onTap: (){
                      sendOTP();
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OtpPasswordScreen(phone: "+965"+phoneController.text)) );

                    },
                  ),
                ),
            ),
          ),

        ],
      ),
              )),
    );
  }
  void sendOTP(){
  setState(() {
    isLoading = true;
  });
    OtpService.sendOTPPassword(context, "974"+phoneController.text).then((value){
      log(value.toString());
      if(value != null) {
        setState(() {
          otpCode = value!.otpCode!;
          setState(() {
            isLoading = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OtpPasswordScreen(phone: "974"+phoneController.text,firstOtp: otpCode,)) );

          // launchWhatsApp(value!.otpLink!);
        });
        log(otpCode.toString());
      }else{
        setState(() {
          isLoading = false;
        });
      }
    });
    // decrease();
  }
}
