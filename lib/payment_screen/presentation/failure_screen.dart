import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../buttom_nav_bar/presentation/buttom_nav_screen.dart';
import '../../utill/localization_helper.dart';

class FailureScreen extends StatefulWidget {
  String MSG;
  FailureScreen({Key? key,required this.MSG}) : super(key: key);

  @override
  _FailureScreenState createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){
          Navigator.pop(context);
          },),
        title:  Text(getTranslated(context, "Payment Status")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h,),
            Center(
              child: Container(
                height: 250.h,
                width: 0.8.sw,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image:AssetImage("assets/image/failure.png"),
                    )
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            Text(widget.MSG,style: TextStyle(fontSize: 25.sp,color: Color.fromRGBO(241 , 88, 70, 1)),),
            SizedBox(height: 10.h,),
            Text(getTranslated(context, "Please Try Again")!,style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(101, 101, 101, 1)),),

            SizedBox(height: 20.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(170, 143, 10, 1),
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: Color.fromRGBO(170, 143, 10, 1),
                      )
                  ),
                  child: Center(child: Text(getTranslated(context, "Go to Basket")!,style: TextStyle(color: Colors.white),)

                  ),
                ),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ButtomNavBarScreen(intial: 2)));
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
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: Color.fromRGBO(170, 143, 10, 1),
                      )
                  ),
                  child: Center(child: Text(getTranslated(context, "Home")!)),
                ),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ButtomNavBarScreen(intial: 0)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
