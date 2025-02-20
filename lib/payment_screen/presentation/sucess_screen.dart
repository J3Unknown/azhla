import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'package:azhlha/home_screen/presentation/home_screen.dart';
import 'package:azhlha/my_reservations/presentation/my_reservations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/localization_helper.dart';

class SuccessScreen extends StatefulWidget {
  String MSG;
  SuccessScreen({Key? key,required this.MSG}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
        title:  Text(getTranslated(context, "Payment Status")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80.h,),
            Center(
              child: Container(
                height: 250.h,
                width: 0.8.sw,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/image/success.png"),
                  )
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            Text( widget.MSG,style: TextStyle(fontSize: 25.sp,color: Color.fromRGBO(32, 79, 56, 1)),),
            SizedBox(height: 10.h,),
            // Text("Your order code: #243188",style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(101, 101, 101, 1)),),
            // Text("From (Seller Name)",style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(101, 101, 101, 1)),),
            // Text("Confirmed",style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(101, 101, 101, 1)),),
            Text("Thank you for choosing our products!",style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(101, 101, 101, 1)),),
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
                  child: Center(child: Text(getTranslated(context, "Home")!,style: TextStyle(color: Colors.white),)),
                ),
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ButtomNavBarScreen(intial: 0)));
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
                  child: Center(child: Text(getTranslated(context, "My Reservations")!)),
                ),
                onTap: (){
                  
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(
                            builder: (BuildContext context) => ButtomNavBarScreen(intial: 1)));
                    //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()) );
                  
                 
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
