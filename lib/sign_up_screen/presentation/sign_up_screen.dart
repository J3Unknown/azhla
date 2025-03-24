import 'dart:developer';

import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../otp_screen/presentation/otp_screen.dart';
import '../../shared/validations.dart';
import '../../terms_and_conditions/presentation/terms_and_conditions.dart';
import '../../terms_and_conditions/presentation/web_view_terms.dart';
import '../../utill/assets_manager.dart';
import '../../utill/colors_manager.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formGlobalKey = GlobalKey < FormState > ();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  bool checkBoxValue = false;
  late Locale locale;
  bool isLoading = true;
  bool secure = true;
  @override
  void initState() {
    initAwaits();
    // TODO: implement initState
    // phoneController.text = '+965';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){

            Navigator.pop(context);


          // Navigator.pop(context);

        },),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath+AssetsManager.logo, height: 180, width: 180,),
            // SizedBox(height: 100.h,),
            // Center(child: Text(getTranslated(context,"Maras")!,style: TextStyle(color: ColorsManager.primary, fontSize: 50.sp,fontWeight: FontWeight.bold),)),
            //SizedBox(height: 30.h,),
            Text(getTranslated(context, "Sign Up")!,style: TextStyle(color: Colors.black87,fontSize: 24.sp, fontWeight: FontWeight.w500),),
            SizedBox(height: 30.h,),
            SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated(context, "Full Name")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
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
                          validator: RequiredValidator(errorText: 'This field is required'),
                          controller: fullNameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: getTranslated(context, "First and Last Name")!,
                            contentPadding: EdgeInsets.all(5.w),
                          )
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Text(getTranslated(context, "Phone Number with Whatsapp")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
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
                                  validator: RequiredValidator(errorText: 'This field is required'),
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
                      ),
                      SizedBox(height: 20.h,),
                      Text(getTranslated(context, "password")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
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
                            textDirection: TextDirection.ltr,
                            validator: passwordValidator,
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            obscureText:secure,

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: getTranslated(context, "password")!,

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
                                ),
                              errorStyle: TextStyle(
                                fontSize: 10.sp,  // You can adjust this to make the error message smaller
                                height: 0,        // Reduces the line height, bringing the error message closer
                              ),
                            )
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Checkbox(
                  checkColor: Colors.white,
                  activeColor:Color.fromRGBO(99, 69, 69, 1),
                  value: checkBoxValue,
                  onChanged: (bool? newValue){
                    setState(() {
                      checkBoxValue = newValue!;


                    });
                  },

                ),
                // SizedBox(width:10.w),
                InkWell(
                  child: Container(
                    height: 30.h,
                    width:0.65.sw,
                    child: Text(getTranslated(context, "Terms & Conditions")!,style: TextStyle(color: Colors.blue,fontSize: 24.sp),),),
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => WebViewTerms()));
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h,),
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
                  child: Center(child: Text(getTranslated(context, "Sign Up")!,style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold),)),
                ),
                onTap: (){
                  signUpOnClick();
                },
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslated(context, "Already have an account")!),
                SizedBox(width: 5.w,),
                InkWell(child:
                Text(getTranslated(context, "Sign In")!,style: TextStyle(color: Colors.blue),),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignInScreen(signUp: 'sign up',)));
                },)
              ],
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
  void signUpOnClick(){
    if(!formGlobalKey.currentState!.validate())
      return;
    if(checkBoxValue == false){
      showToast(context, getTranslated(context, "you should agree terms & conditions")!);
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OtpScreen(name: fullNameController.text,phone: "974"+phoneController.text,password: passwordController.text,)) );

  }
}
