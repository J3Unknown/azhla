import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class FifthWelcomeScreen extends StatefulWidget {
  const FifthWelcomeScreen({Key? key}) : super(key: key);

  @override
  _FifthWelcomeScreenState createState() => _FifthWelcomeScreenState();
}

class _FifthWelcomeScreenState extends State<FifthWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation:0,
          actions: [
            Padding(
              padding:  EdgeInsets.only(top:15.h,right: 10.w,left: 10.w),
              child: InkWell(
                child: Text(
                  getTranslated(context, "Skip")!,style: TextStyle(color: Color.fromRGBO(137, 137, 137, 1),fontSize: 18.sp),
                ),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
                },
              ),
            )
          ],
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 250.h,
                width: 0.8.sw,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/manandwonman2.png"),
                        fit: BoxFit.contain
                    )
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            // Text(getTranslated(context, "Congratulation")!,style: TextStyle(color: Colors.black87,fontSize: 22.sp,),),
            Center(child: Text( "With Maras,",style: TextStyle(color: Colors.black87,fontSize: 22.sp,),)),
            Center(child: Text( "save your time and effort",style: TextStyle(color: Colors.black87,fontSize: 22.sp,),)),
            SizedBox(height: 10.h,),
            // Text("ازهلها",style: TextStyle(color: Colors.black87,fontSize: 22.sp,),),
            Text("مع معرس وفر وقتك ومجهودك",style: TextStyle(color: Colors.black87,fontSize: 22.sp,),),
            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(32, 79, 56, 1),
                      borderRadius: BorderRadius.circular(5.sp)
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.h,),
            InkWell(
              child: Container(
                height: 50.h,
                width: 150.w,
                decoration: BoxDecoration(
                    color: ColorsManager.primary,
                    borderRadius: BorderRadius.circular(10.sp)
                ),
                child: Center(
                  child: Text(
                    getTranslated(context, "Next")!,style: TextStyle(color: Colors.white,fontSize: 24.sp),
                  ),
                ),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
              },
            )
          ],)
    );
  }
}
