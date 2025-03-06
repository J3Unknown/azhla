import 'dart:developer';

import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'package:azhlha/shared/validations.dart';
import 'package:azhlha/sign_in_screen/data/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../forget_password_screen/presentation/forget_password_screen.dart';
import '../../sign_up_screen/presentation/sign_up_screen.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';
import '../domain/sign_in.dart';

class SignInScreen extends StatefulWidget {
  late String signUp;
  SignInScreen({Key? key,required this.signUp}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formGlobalKey = GlobalKey < FormState > ();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = true;
  bool secure = true;
  late Locale locale;
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
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){

          if(widget.signUp == "setting"){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 4,)) );
          }else if(widget.signUp == "delete user"){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)) );
          }else{
          Navigator.pop(context);
          }

          // Navigator.pop(context);

          },),

      ),
      backgroundColor: Colors.white,
      body:  LoadingOverlay(
        progressIndicator: SpinKitSpinningLines(
        color: ColorsManager.primary0_1Transparency,
    ),
    color: ColorsManager.primary,
    isLoading: isLoading,
    child: isLoading == true
    ? Container():
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(getTranslated(context,"Maras")!,style: TextStyle(color: ColorsManager.primary ,fontSize: 50.sp,fontWeight: FontWeight.bold),)),
          SizedBox(height: 30.h,),
          Text(getTranslated(context, "Sign In")!,style: TextStyle(color: Colors.black87,fontSize: 20.sp),),
          SizedBox(height: 40.h,),
          Form(
            key: formGlobalKey,
            child:
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
                              validator: RequiredValidator(errorText: 'This field is required'),
                              textAlign: TextAlign.center,
                              // maxLength: 8,
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
                        controller: passwordController,
                        validator: RequiredValidator(errorText: 'This field is required'),
                        textAlign: TextAlign.center,
                        obscureText:secure,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: getTranslated(context, "password")!,
                          contentPadding: EdgeInsets.only(top:15.sp),

                          suffixIcon: InkWell(

                              child: Padding(
                                padding:  EdgeInsets.only(top: 5.h),
                                child: Icon((secure)?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: ColorsManager.primary,),
                              ),
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
                        )
                    ),
                  )
                ],
              ),
          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //
          //   ],
          // ),
          SizedBox(height: 20.h,),
          Padding(
            padding:  EdgeInsets.only(left: 180.w),
            child: InkWell(child:
            Text(getTranslated(context, "Forget Password")!,style: TextStyle(color: Colors.blue,fontSize: 16.sp),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FrogetPasswordScreen()) );

            },
            ),
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
                child: Center(child: Text(getTranslated(context, "Sign In")!,style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold),)),
              ),
              onTap: (){
                onLoginClick();
              },
            ),
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getTranslated(context, "continue as a")!),
              SizedBox(width: 5.w,),
              InkWell(child:
              Text(getTranslated(context, "guest")!,style: TextStyle(color: Colors.blue),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)) );

                },
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getTranslated(context, "Don't have an account")!),
              SizedBox(width: 5.w,),
              InkWell(child:
              Text(getTranslated(context, "Sign Up")!,style: TextStyle(color: Colors.blue),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()) );

                },
              )
            ],
          ),
        ],
      ),
    ));
  }
  void onLoginClick(){
    if(!formGlobalKey.currentState!.validate())
      return;
    setState(() {
      isLoading = true;
    });
    UserService.login(context,"974"+phoneController.text,passwordController.text).then((data) async {
      if(data == null){
        setState(() {
          isLoading = false;
        });


      }
      else{

        Login user = data;
        // String? token = await messaging.getToken(
        //   vapidKey: "AAAAtZFow-Q:APA91bF6MfZcttelZai1HUlfzDE2OW7q2y7goDl1wRSi-h1rix_LkanVemUxGwMgnJH3pdGEXTQkFZr21dxCybfQArbaQTqP6KpyD_sIYE68UxVEwm3hPNT1WusyPUByr5DDXzVxwWmz",
        // );
        log("token!");

        log(user.image.toString());
        log(user.name.toString());
        SharedPreferences.getInstance().then((prefs){
          // Add User's Info here and remove them in the Sign Out & Splash Screen (When token is expired)
          prefs.setString( 'token' , data.token.toString());
          //String userType = user.roleId == 1? 'user' : "company";
          //log("Logining in with usertype " + userType);

          prefs.setString( 'name' , user.name.toString() );
          prefs.setString( 'image' , user.image.toString());
          //prefs.setString( 'email' , user.email );
          prefs.setString( 'phone' , user.phone.toString() );

          // if(user.whatsapp_number != null) prefs.setString( 'whatsapp_number' , user.whatsapp_number.toString() );
          // if(user.address != null) prefs.setString( 'address' , user.address! );



        });
        setState(() {
          isLoading = false;
        });
        if(widget.signUp == "sign up" || widget.signUp =="delete user"){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)) );

    }else if(widget.signUp == "setting"){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 4,)) );
    }else{
          Navigator.pop(context);
        }
      }

    });
  }
}
