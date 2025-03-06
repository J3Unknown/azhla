import 'package:azhlha/otp_screen/presentation/otp_password_screen.dart';
import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
import 'package:azhlha/sign_up_screen/presentation/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../buttom_nav_bar/presentation/buttom_nav_screen.dart';
import '../../sign_up_screen/sign_up_service/sign_up_service.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';
import '../domain/forget_password_service.dart';

class NewPasswordScreen extends StatefulWidget {
  String phone;
  String otp;
  NewPasswordScreen({Key? key,required this.phone,required this.otp}) : super(key: key);

  @override
  _NewPasswordScreenScreenState createState() => _NewPasswordScreenScreenState();
}

class _NewPasswordScreenScreenState extends State<NewPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final formGlobalKey = GlobalKey < FormState > ();
  bool secure = true;
  bool secure1 = true;
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
      backgroundColor: Colors.white,
      body: Form(
        key: formGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text(getTranslated(context,"Maras")!,style: TextStyle(color: ColorsManager.primary,fontSize: 50.sp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 30.h,),
            // Text(getTranslated(context, "Enter your Number")!,style: TextStyle(color: Colors.black87,fontSize: 20.sp),),
            SizedBox(height: 40.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, "Enter New Password")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
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
                  child: TextFormField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      validator: passwordValidator,
                      obscureText:secure,
                      decoration: InputDecoration(

                        border: InputBorder.none,
                        hintText: getTranslated(context, "Enter New Password")!,
                          contentPadding:(passwordController.text.isNotEmpty)?EdgeInsets.only(top:30.sp):EdgeInsets.only(top:15.sp),
                          suffixIcon: InkWell(

                            child: Icon((secure)?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: ColorsManager.primary,),
                            onTap: (){
                              if(secure == true){
                                setState(() {
                                  secure = false;
                                });
                              }
                              else{
                                setState(() {
                                  secure = true;
                                });
                              }
                            },
                          )
                      ),

                  ),
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, "Confirm New Password")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
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
                        controller: newPasswordController,
                        textAlign: TextAlign.center,
                        obscureText:secure1,
                        textDirection: TextDirection.ltr,
                        validator: passwordValidator,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: getTranslated(context, "Confirm New Password")!,
                            hintStyle: TextStyle(

                              // textAlign: TextAlign.center, // Ensures hint is also centered
                            ),
                            // contentPadding: EdgeInsets.zero, // Removes extra padding
                            contentPadding:(passwordController.text.isNotEmpty)?EdgeInsets.only(top:30.sp):EdgeInsets.only(top:15.sp),
                            suffixIcon: InkWell(

                              child: Icon((secure1)?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: ColorsManager.primary,),
                              onTap: (){
                                if(secure1 == true){
                                  setState(() {
                                    secure1 = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    secure1 = true;
                                  });
                                }
                              },
                            )

                        ),
                    ),
                  ),
                )
              ],
            ),
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
                    child: Center(child: Text(getTranslated(context, "Submit")!,style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold),)),
                    onTap: (){
                      onClick();
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OtpPasswordScreen(phone: "+965"+phoneController.text)) );

                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    // Regular expression to validate password constraints
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must include uppercase, lowercase, number, and special character';
    }
    return null;
  }
void onClick(){
  if(!formGlobalKey.currentState!.validate())
    return;
    // Check if the passwords match
    if (passwordController.text != newPasswordController.text) {
      // Show an error dialog if passwords do not match
      showToastError(context,getTranslated(context, "Passwords do not match")!);
      return;
    }
  ForgetPasswordService.resetPassword(context,widget.phone,passwordController.text,newPasswordController.text,widget.otp).then((data) async {
    if(data == null){
      setState(() {
        //isLoading = false;
      });
    }
    else{
      if(data == true) {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen(signUp: "sign up")));
      }
      }
  });
}
  void showErrorDialog(String title, String message) {
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
