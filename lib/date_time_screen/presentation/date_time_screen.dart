import 'dart:developer';

import 'package:azhlha/date_time_screen/presentation/date_screen.dart';
import 'package:azhlha/date_time_screen/presentation/time_screen.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../address_screen/presentation/address_screen.dart';
import '../../utill/localization_helper.dart';

class DateTimeScreen extends StatefulWidget {
  late String total_price;
  late String order_id;
   DateTimeScreen({Key? key,required this.total_price,required this.order_id}) : super(key: key);

  @override
  _DateTimeScreenState createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  DateTime focusedDaySelected = DateTime.now();
  DateTime dateTime = DateTime.now();
  late String date =focusedDaySelected.year.toString()+"-"+focusedDaySelected.month.toString()+"-"+focusedDaySelected.day.toString();
  late String finalTime;
  @override
  void initState() {
    finalTime = dateTime.hour.toString()+":"+dateTime.minute.toString()+":"+dateTime.second.toString();

    initAwaits();
    // TODO: implement initState
    super.initState();
  }
  void initAwaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    date = prefs.getString("Date")!;
    finalTime = prefs.getString("Time")!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
        title:  Text(getTranslated(context, "Date - Time")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     child: Icon(CupertinoIcons.search),
        //   ),
        //   SizedBox(width: 10.w,),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h,),
            Center(child: Text(getTranslated(context, "Please Select desired date and Time")!,style: TextStyle(color: Color.fromRGBO(13, 24, 99, 1),fontSize: 20.sp),)),
            SizedBox(height: 30.h,),
            Container(
                height:30.h,
                width: 0.9.sw,
                child: Text(getTranslated(context, "Date")!,style: TextStyle(color: Colors.grey,fontSize: 20.sp),)),
            SizedBox(height: 10.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(170, 143, 10, 1),
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(date),
                      SizedBox(width: 0.55.sw,),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/image/Calender.png"),
                            fit: BoxFit.contain
                          )
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()async{
                  await showDialog<void>(
                  context: context,
                  builder: (context) => DateScreen(total_price: widget.total_price,order_id: widget.order_id,)
                  );
                },
              ),
            ),

            SizedBox(height: 30.h,),
            // Text(getTranslated(context, "Please Select Available Time")!,style: TextStyle(color: Color.fromRGBO(13, 24, 99, 1),fontSize: 20.sp),),
            Container(
                height:30.h,
                width: 0.9.sw,
                child: Text(getTranslated(context, "Time")!,style: TextStyle(color: Colors.grey,fontSize: 20.sp),)),
            SizedBox(height: 10.h,),
            Center(
              child: InkWell(
              child: Container(
                height: 50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(170, 143, 10, 1),
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(finalTime),
                    SizedBox(width: 0.6.sw,),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/image/Time.png"),
                              fit: BoxFit.contain
                          )
                      ),
                    )
                  ],
                ),
              ),
              onTap: ()async{
                await showDialog<void>(
                    context: context,
                    builder: (context) => TimeScreen(total_price: widget.total_price,order_id: widget.order_id,)
                );
              },
          ),
            ),
            SizedBox(height: 250.h,),
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
                  child: Center(child: Text(getTranslated(context, "Next")!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                ),
                onTap: (){
                  log(date+" "+finalTime);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>AddressScreen( total_price: widget.total_price,order_id: widget.order_id,)));

                },
              ),
            ),
          SizedBox(height: 30.h,)
          ],
        ),
      ),
    );
  }
  void setDate(String date){
    this.date = date;
  }
}
