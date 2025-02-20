import 'dart:developer';

import 'package:azhlha/date_time_screen/presentation/date_time_screen.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class DateScreen extends StatefulWidget {
  late String total_price;
  late String order_id;
   DateScreen({Key? key,required this.total_price,required this.order_id}) : super(key: key);

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DateTime focusedDaySelected = DateTime.now();
  late String date =focusedDaySelected.year.toString()+"-"+focusedDaySelected.month.toString()+"-"+focusedDaySelected.day.toString();

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 0.55.h,
        width: 0.95.sw,
        child: AlertDialog(
          scrollable: true,
          content:  Center(
            child: Container(
              height: 0.4.sh,
              width: 0.7.sw,
              child: Column(
                children: [
                  Container(
                    height: 0.3.sh,
                    width: 0.7.sw,
                    child: TableCalendar(
                      shouldFillViewport:true,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible : false,
                      ),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: focusedDaySelected,
                      selectedDayPredicate: (day) =>isSameDay(day, focusedDaySelected),
                      calendarStyle: CalendarStyle(
                          markerDecoration: BoxDecoration(
                              color: Colors.red
                          )
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          focusedDaySelected = selectedDay;
                          date = selectedDay.year.toString()+"-"+selectedDay.month.toString()+"-"+selectedDay.day.toString();


                          //setDate(date);
                        });
                        //log(selectedDay.timeZoneName);
                        log(date);
                      },

                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          //use to change the style of all days
                        },
                        headerTitleBuilder:(context, day)  {

                        },
                        todayBuilder: (context, day, focusedDay) {
                          return Center(
                            child: Text(
                              focusedDay.day.toString(),
                              style: TextStyle(color: Colors.black87),
                            ),
                          );
                        },
                        selectedBuilder: (context, day, focusedDay) {

                          //  final text = DateFormat.E().format(focusedDay);

                          return Center(
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(170, 143, 10, 1),
                                  borderRadius: BorderRadius.circular(20.sp)
                              ),

                              child: Center(
                                child: Text(
                                  focusedDay.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );

                        } ,

                      ),
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
                            prefs.setString("Date", date);
                            //Navigator.pop(context);
                            Navigator.of(context, rootNavigator: true).pushReplacement( MaterialPageRoute(builder: (BuildContext context) =>DateTimeScreen(total_price: widget.total_price,order_id: widget.order_id)));

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
