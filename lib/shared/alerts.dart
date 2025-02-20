import 'package:azhlha/events_screen/presentation/events_screen.dart';
import 'package:azhlha/events_screen/presentation/my_events.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../buttom_nav_bar/presentation/buttom_nav_screen.dart';
import '../events_screen/presentation/events_reminder.dart';
import '../sign_in_screen/presentation/sign_in_screen.dart';
import '../utill/colors_manager.dart';

void showToast(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(top: 220.h, bottom: 220.h),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: ColorsManager.primary,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure dialog height is dynamic
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h,),
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/like.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  msg,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Container(
                  height: 60.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    color: ColorsManager.primary,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: TextButton(
                    child: Text(
                      getTranslated(context, "close")!,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h,),

            ],
          ),
        ),
      );
    },
  );
}

showToastError(BuildContext context, String msg){
  return showDialog(
    context: context,
    builder: (_) =>  Padding(
      padding:  EdgeInsets.only(top: 260.h,bottom: 260.h),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: ColorsManager.primary, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(child:
            Text(msg,style:
            TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp),
            textAlign: TextAlign.center,
            )),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(width:220.w),
            Center(
              child: Container(
                height: 60.h,
                width: 130.w,
                decoration: BoxDecoration(
                    color: ColorsManager.primary,
                    borderRadius: BorderRadius.circular(20.sp)
                ),
                child: TextButton(
                  child: Text(getTranslated(context, "close")!,style: TextStyle(color: Colors.white),),
                  onPressed : () {
                    // Navigator.pop(context);
                    //Navigator.of(context, rootNavigator: true).pop('dialog');
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
              ),
            )
          ],
        ),


      ),
    ),
  );
}
showToastReminder(BuildContext context, String msg){
  return showDialog(
    context: context,
    builder: (_) =>  Padding(
      padding:  EdgeInsets.only(top: 240.h,bottom: 240.h),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: ColorsManager.primary, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagePath+AssetsManager.like),
                      fit: BoxFit.contain
                  )
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(child: Text(msg,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp),)),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(width:220.w),
            Center(
              child: Container(
                height: 60.h,
                width: 130.w,
                decoration: BoxDecoration(
                    color: ColorsManager.primary,
                    borderRadius: BorderRadius.circular(20.sp)
                ),
                child: TextButton(
                  child: Text(getTranslated(context, KeysManager.close)!,style: TextStyle(color: ColorsManager.white),),
                  onPressed : () {
                    Navigator.pop(context);
                    //Navigator.of(context, rootNavigator: true).pop('dialog');
                    //Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
              ),
            )
          ],
        ),


      ),
    ),
  );
}
showToastAddEvent(BuildContext context, String msg){
  return showDialog(
    context: context,
    builder: (_) =>  Padding(
      padding:  EdgeInsets.only(top: 150.h,bottom: 150.h),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: ColorsManager.primary, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(getTranslated(context, "EVENT ${msg}")!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp),)),
            SizedBox(
              height: 5.h,
            ),
            // Center(child: Text(getTranslated(context, "SUCCESSFULLY")!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp,color: Color.fromRGBO(241, 169, 70, 1)),)),
            // SizedBox(
            //   height: 10.h,
            // ),
            Center(child: Text(getTranslated(context, "Your Event ${msg} but it send")!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),)),
            SizedBox(
              height: 10.h,
            ),
            // Center(child: Text(getTranslated(context, "for app admins for approval")!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),)),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 50.h,
              width: 0.5.sw,

              decoration: BoxDecoration(
                color: ColorsManager.primary,
                borderRadius: BorderRadius.circular(10.sp),

              ),
              child: TextButton(
                child: Text(getTranslated(context, "Back To Home")!,style: TextStyle(color: ColorsManager.white),),
                onPressed : () {
                   Navigator.pop(context);
                   Navigator.of(context, rootNavigator: true).push( MaterialPageRoute(builder: (BuildContext context) =>ButtomNavBarScreen(intial:0)));

                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50.h,
              width: 0.5.sw,

              decoration: BoxDecoration(
                  color: ColorsManager.primary,
                borderRadius: BorderRadius.circular(10.sp),
                border: Border.all(
                  color: ColorsManager.primary,
                )

              ),
              child: TextButton(
                child: Text(getTranslated(context, "Back To Events")!,style: TextStyle(color: ColorsManager.white,),),
                onPressed : () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  Navigator.of(context, rootNavigator: true).push( MaterialPageRoute(
                      builder: (BuildContext context) => EventsScreen()));
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50.h,
              width: 0.5.sw,

              decoration: BoxDecoration(
                color: ColorsManager.primary,
                borderRadius: BorderRadius.circular(10.sp),

              ),
              child: TextButton(
                child: Text(getTranslated(context, "Back To My Events")!,style: TextStyle(color: ColorsManager.white),),
                onPressed : () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyEvents()));
                },
              ),
            ),
            Row(
              children: [
                SizedBox(width:220.w),

              ],
            )
          ],
        ),


      ),
    ),
  );
}
showToastLogin(BuildContext context, String msg){
  return showDialog(
      context: context,
      builder: (_) => Padding(
        padding:  EdgeInsets.only(top: 270.h,bottom: 270.h),
        child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: ColorsManager.primary, width: 2.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(child: Text(msg,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp),)),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(getTranslated(context, KeysManager.close)!,style: TextStyle(color: ColorsManager.primary),),
                      onPressed : () {
                        Navigator.of(context, rootNavigator: true).pop('dialog');
                      },
                    ),
                    SizedBox(width: 20.w,),
                    TextButton(
                      child: Text(getTranslated(context, "Sign In")!,style: TextStyle(color: ColorsManager.primary)),
                      onPressed : () {
                        Navigator.of(context, rootNavigator: true).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignInScreen(signUp: 'test',)));
                      },
                    ),
                  ],
                )
              ],
            ),


        ),
      ),
  );
}
showToastSetting(BuildContext context, String msg){
  return showDialog(
    context: context,
    builder: (_) => Padding(
      padding:  EdgeInsets.only(top: 280.h,bottom: 280.h),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: ColorsManager.primary, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(msg,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp),)),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(getTranslated(context, KeysManager.close)!,style: TextStyle(color: ColorsManager.primary),),
                  onPressed : () {
// Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                ),
                SizedBox(width: 20.w,),
                TextButton(
                  child: Text(getTranslated(context, "Sign In")!,style: TextStyle(color: ColorsManager.primary)),
                  onPressed : () {
// Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignInScreen(signUp: 'setting',)));
                  },
                ),
              ],
            )
          ],
        ),


      ),
    ),
  );
}
class CustomCircularUnborderImage extends StatelessWidget {

  double height;
  double width;
  String dir;


  CustomCircularUnborderImage(this.height, this.width,  this.dir);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xff7c94b6),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(dir),
          fit: BoxFit.fill,

        ),
        //borderRadius: BorderRadius.all( Radius.circular(50.0) ),
      ),
    );
  }
}
class LongCustomSimpleTextButton extends StatelessWidget {
  String txt;
  dynamic fun;

  LongCustomSimpleTextButton( this.txt,  this.fun);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width:  0.8.sw,
      child: TextButton(
          onPressed: fun,
          child: Center(child: Text(txt, style: TextStyle(color: Colors.white,fontSize: 16, height: 1), )),
          style: TextButton.styleFrom(
              backgroundColor:  ColorsManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.h)
              )

          )
      ),
    );
  }
}