import 'dart:developer';

import 'package:azhlha/date_time_screen/presentation/date_time_screen.dart';
import 'package:azhlha/date_time_screen/presentation/order_seller_screen.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../stores_screen/presentation/stores_screen.dart';

class SellerDateScreen extends StatefulWidget {
  // late String total_price;
  // late String order_id;
  // late int categoryId;
  // late int sellerId;
  // late String imgPath;
  final Function(String) onDateSelected;

  SellerDateScreen({Key? key, required this.onDateSelected}) : super(key: key);


  @override
  _SellerDateScreentate createState() => _SellerDateScreentate();
}

class _SellerDateScreentate extends State<SellerDateScreen> {
  DateTime focusedDaySelected = DateTime.now();
  late String date =focusedDaySelected.year.toString()+"-"+focusedDaySelected.month.toString()+"-"+focusedDaySelected.day.toString();
   String lang = 'en';
  @override
  void initState() {
    initawaits();
  // TODO: implement initState
    super.initState();
  }
  void initawaits () async{
    Locale locale = await getLocale();
    setState(() {
      lang = locale.languageCode;

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 0.55.h,
        width: 1.sw,
        child: AlertDialog(
          scrollable: true,
          content:  Center(
            child: Container(
              height: 0.4.sh,
              width: 1.sw,
              child: Column(
                children: [
                  Container(
                    height: 0.3.sh,
                    width: 1.sw,
                    child: TableCalendar(
                      locale: lang == 'ar'?'ar':'en',
                      shouldFillViewport:true,
                      daysOfWeekHeight: 20.h,

                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible : false,
                      ),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: focusedDaySelected, // This ensures that the correct date is always focused
                      onPageChanged: (focusedDay) {
                        setState(() {
                          final lastDayOfNewMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);

                          // If the previously selected day does not exist in the new month, adjust it
                          if (focusedDaySelected.day > lastDayOfNewMonth.day) {
                            focusedDaySelected = lastDayOfNewMonth;
                          } else {
                            focusedDaySelected = DateTime(focusedDay.year, focusedDay.month, focusedDaySelected.day);
                          }
                        });
                      },

                      daysOfWeekStyle: DaysOfWeekStyle(
                        dowTextFormatter: (date, locale) => lang == 'ar'?DateFormat.EEEE(locale).format(date):DateFormat.E(locale).format(date), // Ensure full day name
                        weekdayStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold), // Adjust font size
                        weekendStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                      ),
                      enabledDayPredicate: (day){
                        final now = DateTime.now();
                        // Create a DateTime object for the start of today (midnight)
                        final today = DateTime(now.year, now.month, now.day);

                        // Allow today and future days
                        return !day.isBefore(today);

                      },
                      selectedDayPredicate: (day) =>isSameDay(day, focusedDaySelected),
                      calendarStyle: CalendarStyle(
                          markerDecoration: BoxDecoration(
                              color: Colors.red
                          )
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          focusedDaySelected = selectedDay;
                          date = "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";
                        });

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
                                  color: ColorsManager.primary,
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
                                color: ColorsManager.primary,
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
                              color: ColorsManager.primary,
                            ),
                            child: Center(child: Text(getTranslated(context, "Done")!,style: TextStyle(color: Colors.white),)),
                          ),
                          onTap: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            log(date);
                            prefs.setString("OrderDate", date);
                            widget.onDateSelected(date);
                            Navigator.pop(context);
                            // Navigator.of(context, rootNavigator: true).pushReplacement( MaterialPageRoute(builder: (BuildContext context) =>DateTimeScreen(total_price: widget.total_price,order_id: widget.order_id)));
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OrderSellerScreen(categoryId: widget.categoryId, sellerId: widget.sellerId, imgPath:widget.imgPath)));

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
