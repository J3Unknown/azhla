import 'dart:developer';

import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'package:azhlha/contatct_us_screen/presentation/contact_us_screen.dart';
import 'package:azhlha/events_screen/presentation/events_reminder.dart';
import 'package:azhlha/events_screen/presentation/my_events.dart';
import 'package:azhlha/profile_screen/presentation/profile_screen.dart';
import 'package:azhlha/setting_screen/domain/settings_service.dart';
import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
import 'package:azhlha/special_request/presentation/add_special_request.dart';
import 'package:azhlha/terms_and_conditions/presentation/terms_and_conditions.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/icons_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../profile_screen/domain/profile_service.dart';
import '../../shared/alerts.dart';
import '../../terms_and_conditions/presentation/web_view_terms.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String token = '';
  String word = 'Sign In';
  String image = '';
  String name = '';
  bool isLoading = true;
  void initawaits() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      getProfileDate();
      token = prefs.getString("token")!;
      setState(() {
        word = "Log Out";
        log(word);
      });

    }else {
      setState(() {
        name = getTranslated(context, "guest")!;
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    initawaits();
    // TODO: implement initState
    super.initState();
  }
  void getProfileDate(){
    ProfileService.profile().then((data) {
      if(data == null){

      }
      else{
        setState(() {
          log("test name"+data.name.toString());
          name = data.name!;
          log("name test"+name);
          image = data.image.toString();
          isLoading = false;
        });

        log("logged image"+image);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: InkWell(child:Icon(CupertinoIcons.back),),
        title:  Text(getTranslated(context, "Settings")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: LoadingOverlay(
          progressIndicator: SpinKitSpinningLines(
            color: ColorsManager.primary,
          ),
          color: ColorsManager.primary0_1Transparency,
          isLoading: isLoading,
          child: isLoading == true
              ? Container()
              :SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              (token != '')?Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(50.sp),
                  border: Border.all(
                    color: ColorsManager.grey1
                  ),
                  image: DecorationImage(
                    image: NetworkImage(AppConstants.MAIN_URL_IMAGE+image),
                    //image: AssetImage("assets/image/person.png"),
                    fit: BoxFit.contain
                  )
                ),
              ):Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(50.sp),
                    border: Border.all(
                        color: ColorsManager.grey1
                    ),
                    image: DecorationImage(
                        image: AssetImage("assets/image/person.png"),
                        fit: BoxFit.contain
                    )
                ),
              ),
              SizedBox(height: 10.h,),
              Text(getTranslated(context, "Welcome, Dear ")!+name,style: TextStyle(fontSize: 22.sp),),
              SizedBox(height: 20.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath+AssetsManager.person)
                          )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      SizedBox(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "Profile")!)),
                      const Icon(IconsManager.rightArrowIcon)
                    ],
                  )),
                ),
                onTap: (){
                  if(token != '') {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProfileScreen()));
                    //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()) );
                  }
                  else {
                   showToastSetting(context,getTranslated(context, "please login")!);
                  }
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.globe)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Container(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "Language")!)),
                      Icon(CupertinoIcons.forward)
                    ],
                  )),
                ),
                onTap: (){
                  handleLanguage(context).show();
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.w,),
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.todoList)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      SizedBox(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "Add Special Request")!)),
                      const Icon(CupertinoIcons.forward)
                    ],
                  )),

                ),
                onTap: (){
                  if(token != '') {
                    Navigator.push(
                        context,MaterialPageRoute(
                        builder: (BuildContext context) => AddSpecialRequest()));
                    //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()) );
                  }
                  else {
                    showToastSetting(context,getTranslated(context, "please login")!);
                  }
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.w,),
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.calender2)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      SizedBox(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "My EVents")!)
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  )),

                ),
                onTap: (){
                  if(token != '') {
                    Navigator.push(
                        context,MaterialPageRoute(
                        builder: (BuildContext context) => const MyEvents()));
                    //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()) );
                  }
                  else {
                    showToastSetting(context,getTranslated(context, "please login")!);
                  }
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.w,),
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.specialCalender)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Container(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "Event Reminders")!)),
                      Icon(CupertinoIcons.forward)
                    ],
                  )),

                ),
                onTap: (){
                  if(token != '') {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventReminders()));

                    //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()) );
                  }
                  else {
                   showToastSetting(context,getTranslated(context, "please login")!);
                  }
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(width: 5.w,),
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.headphones)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Container(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "Support")!)),
                      Icon(IconsManager.rightArrowIcon)
                    ],
                  )),

                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ContactUsScreen()));
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.handShake)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      SizedBox(
                        height: 20.h,
                        width: 0.6.sw,
                        child: Text(getTranslated(context, "Terms & Conditions")!)
                      ),
                      const Icon(IconsManager.rightArrowIcon)
                    ],
                  )),
                ),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => WebViewTerms()));
                },
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 15.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.info)
                            )
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Container(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, "About Us")!)),
                      Icon(CupertinoIcons.forward)
                    ],
                  )),
                ),
              ),
              SizedBox(height: 10.h,),
              InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: ColorsManager.red
                  ),
                  child: Center(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon((token != '')?Icons.logout:Icons.login, color: ColorsManager.white,),
                      SizedBox(width: 10.w,),
                      Container(
                          height: 20.h,
                          width: 0.6.sw,
                          child: Text(getTranslated(context, word)!, style: TextStyle(color: ColorsManager.white),)),
                      Icon(CupertinoIcons.forward, color: ColorsManager.white,)
                    ],
                  )),
                ),
                onTap: () async{
                  if(token != '') {
                    await showDialog<void>(
                        context: context,
                        builder: (context) => Container(
                            height: 200.h,
                            width: 0.8.sw,
                            decoration: BoxDecoration(

                            ),
                            child:
                            AlertDialog(
                                scrollable: true,
                                content: Column(
                                  children: [
                                    Container(
                                        height: 50.h,
                                        width:50.w,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(25.sp),
                                        ),
                                        child:
                                        Center(child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.white,size: 30.sp,),)
                                    ),
                                    SizedBox(height: 20.h,),
                                    Text(getTranslated(context, "Log Out")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
                                    SizedBox(height: 20.h,),
                                    Center(
                                      child: InkWell(
                                        child: Container(
                                          height: 50.h,
                                          width: 0.4.sw,
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
                                          signOutOnClick();

                                        },
                                      ),
                                    ),
                                    SizedBox(height: 30.h,),
                                    Center(
                                      child: InkWell(
                                        child: Container(
                                          height: 50.h,
                                          width: 0.4.sw,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.sp),
                                              border: Border.all(
                                                color: ColorsManager.primary,
                                              )
                                          ),
                                          child: Center(child: Text(getTranslated(context, "Cancel")!)),
                                        ),
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                            )));

                  }
                  else{
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignInScreen(signUp: 'setting',)));
                  }
                },
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      )),
    );
  }
  void signOutOnClick() {
    SettingsService.logout(context).then((value) {
      if (value == true)
        SharedPreferences.getInstance().then((prefs) {
          prefs.remove('token');
          prefs.remove('phone');
          prefs.remove('name');
          Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => SignInScreen(signUp: 'setting',)));
        });
    });
  }
  Alert handleLanguage(BuildContext context) {
    Object?
    groupVal; // Compare this value with select buttons values to detect the selected one and change its color
    getLocale().then((value) => groupVal = value.languageCode);

    return Alert(

      context: context,
      padding: EdgeInsets.zero,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height:  0.2.sh,
            width: 0.9.sw,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text (getTranslated(context, "Choose your language")!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.r)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("العربية"),
                          SizedBox(
                            width: 5.w,
                          ),
                          // CustomCircularUnborderImage(
                          //     25.h,
                          //     25.w,
                          //     "assets/image/Arabic.png"),
                          Radio(
                            value: 'ar',
                            groupValue: groupVal,
                            onChanged: (value) async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              setState(() {
                                prefs.setString("lang_ar", 'ar');
                                prefs.remove("lang_en");

                                groupVal = value;
                              });
                            },
                            activeColor:  ColorsManager.primary,
                            toggleable: false,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("English"),
                          SizedBox(
                            width:5.w,
                          ),
                          // CustomCircularUnborderImage(
                          //     25.h,
                          //     25.w,
                          //     "assets/image/English.png"),
                          Radio(
                            value: 'en',
                            groupValue: groupVal,

                            onChanged: (value) async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              setState(() {
                                prefs.setString("lang_en", 'en');
                                prefs.remove("lang_ar");
                                groupVal = value;
                              });

                            },
                            activeColor:  ColorsManager.primary,
                            toggleable: false,
                          ),
                        ],
                      )
                    ],
                  ),
                  LongCustomSimpleTextButton( getTranslated(context, "Change")!,
                          () {
                        getLocale().then((currentLanguage) {
                          if (groupVal != currentLanguage.languageCode) {
                            if (currentLanguage.languageCode == 'ar')
                              _changeLanguage(context, 'en');
                            else if (currentLanguage.languageCode == 'en')
                              _changeLanguage(context, 'ar');
                          } else {
                            // Do nothing
                          }
                        });
                      })
                ],
              ),
            ),
          );
        },
      ),
      style: AlertStyle(
        animationType: AnimationType.shrink,
        isOverlayTapDismiss: true,
        // Close when tap outside the alert
        alertPadding: EdgeInsets.zero,
        // Internal Padding
        buttonAreaPadding: EdgeInsets.zero,
        // Internal Padding
        isCloseButton: false,
        // Close Button
        isButtonVisible: false,
        // Close Button

        descTextAlign: TextAlign.center,

        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(color: Colors.white, width: 1.5),
        ),
        overlayColor: Color(0x55000000).withOpacity(0.5), // Alert Background color
        //alertElevation: 0,
      ),
    );
  }

  void _changeLanguage(BuildContext context, String language) async {
    Locale _locale = await setLocale(language);
    MyHomePage.setLocale(context, _locale);
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
  }
}
