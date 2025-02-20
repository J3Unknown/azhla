import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../utill/localization_helper.dart';
import 'date_time_screen.dart';

class TimeScreen extends StatefulWidget {
  late String total_price;
  late String order_id;
   TimeScreen({Key? key,required this.total_price,required this.order_id}) : super(key: key);

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  DateTime dateTime = DateTime.now();
  late String finalTime;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.45.h,
        width: 0.95.sw,
        child: AlertDialog(
          scrollable: true,
          content:  Center(
            child: Container(
              height: 0.35.sh,
              width: 0.7.sw,
              child: Column(
                children: [
                  Center(
                    child: TimePickerSpinner(
                      locale: const Locale('en', ''),
                      time: dateTime,
                      is24HourMode: false,
                      isShowSeconds: false,
                      itemHeight: 60,
                      itemWidth: 60.w,

                      normalTextStyle: const TextStyle(
                        color: Color.fromRGBO(146, 143, 143, 1),
                        fontSize: 24,
                      ),
                      highlightedTextStyle:
                      const TextStyle(fontSize: 24, color: Colors.black87),
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          dateTime = time;
                          finalTime = time.hour.toString()+":"+time.minute.toString()+":"+time.second.toString();
                          log(finalTime);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    height: 60.h,
                    width: 0.85.sw,
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 50.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.sp),
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromRGBO(170, 143, 10, 1),
                              ),

                            ),
                            child: Center(child: Text(getTranslated(context, "Cancel")!)),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10.w,),
                        InkWell(
                          child: Container(
                            height: 50.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.sp),
                              color: Color.fromRGBO(170, 143, 10, 1),
                            ),
                            child: Center(child: Text(getTranslated(context, "Done")!,style: TextStyle(color: Colors.white),)),
                          ),
                          onTap: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("Time", finalTime);
                            //Navigator.pop(context);
                            Navigator.of(context, rootNavigator: true).pushReplacement( MaterialPageRoute(builder: (BuildContext context) =>DateTimeScreen(total_price: widget.total_price,order_id: widget.order_id,)));

                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
