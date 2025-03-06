import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  _SocialLoginScreenState createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(getTranslated(context,"Maras")!,style: TextStyle(color: ColorsManager.primary,fontSize: 50.sp,fontWeight: FontWeight.bold),),
          SizedBox(height: 30.h,),
          Text("Welcome to Our app",style: TextStyle(color: Colors.black87,fontSize: 20.sp),),
          SizedBox(height: 40.h,),
          Center(
            child: InkWell(
              child: Container(
                height: 50.h,
                width: 0.8.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                    color: ColorsManager.primary,
                  )
                ),
                child: Center(child: Text(getTranslated(context, "Sign in with Phone Number")!)),
              ),
            ),
          ),
          SizedBox(height: 15.h,),
          Center(
            child: InkWell(
              child: Container(
                height: 50.h,
                width: 0.8.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                    color: ColorsManager.primary,
                  )
                ),
                child: Center(child: Text(getTranslated(context, "Sign in with google")!)),
              ),
            ),
          ),
          SizedBox(height: 15.h,),
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
                child: Center(child: Text(getTranslated(context, "Sign in with facebook")!,style: TextStyle(color: ColorsManager.white),)),
              ),
            ),
          ),
          SizedBox(height: 50.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getTranslated(context, "Already member")!),
              SizedBox(width: 5.w,),
              Text(getTranslated(context, "Sign In")!,style: TextStyle(color: ColorsManager.blue),)
            ],
          ),
          SizedBox(height: 50.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(getTranslated(context, "By continue you agree to our")!,style: TextStyle(color: ColorsManager.grey1),),
                    SizedBox(width: 5.w,),
                    Text(getTranslated(context, "Terms of service")!,style: TextStyle(color: ColorsManager.blue),)
                  ],
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getTranslated(context, "and our")!,style: TextStyle(color: ColorsManager.grey1),),
                  SizedBox(width: 5.w,),
                  Text(getTranslated(context, "Privacy Policy")!,style: TextStyle(color: ColorsManager.blue),)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
