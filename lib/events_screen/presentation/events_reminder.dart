import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/app_constants.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';
import '../data/EventReminderObject.dart';
import '../domain/events_service.dart';
import 'event_details.dart';

class EventReminders extends StatefulWidget {
  const EventReminders({Key? key}) : super(key: key);

  @override
  _EventRemindersState createState() => _EventRemindersState();
}

class _EventRemindersState extends State<EventReminders> {
  List<EventReminderObject> events = [];
  @override
  void initState() {
    loadALLEventReminders();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(child:Icon(CupertinoIcons.back),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title:  Text(getTranslated(context, "Event Reminders")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 40.h,
            width: 0.9.sw,
            child: Text(getTranslated(context, "Upcoming Events")!,style: TextStyle(color: Color.fromRGBO(52, 21, 87 , 1),fontSize: 24.sp),),
          ),
          Container(
            height: 0.7.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300.sp),
              // boxShadow:[
              //   BoxShadow(
              //     color: Colors.white,
              //     blurRadius: 7,
              //   ),
              // ],

            ),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: events.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding:  EdgeInsets.only(left: 20.w,right:20.w ,top: 10.h,bottom: 10.h),
                  child: InkWell(
                    child: Container(
                      width: 0.75.sw,
                      height: 150.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorsManager.primary
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.sp),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5,
                          ),
                        ],

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10.w,),
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(AppConstants.MAIN_URL_IMAGE+events[position]!.image!),
                                )
                            ),
                          ),
                          SizedBox(width: 50.w,),
                          Container(
                            height: 200.h,
                            width: 200.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  events[position]!.name!,
                                  style: TextStyle(fontSize: 20.sp,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Text(
                                      events[position]!.dailyEvent!.nameEn!,
                                      style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                    ),
                                    SizedBox(width: 5.w,),
                                    Text(
                                      events[position]!.familyName!,
                                      style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.location_solid,size: 15.sp,color: ColorsManager.primary,),
                                    Text(
                                      events[position]!.address!,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.calendar,size: 15.sp,),
                                    Text(
                                      events[position]!.date!,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: Container(
                                height: 30.h,
                                width:30.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child:
                                Center(child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.white,size: 20.sp,),)
                            ),
                            onTap: () async{
                              await showDialog<void>(
                                  context: context,
                                  builder: (context) => Container(
                                    height: 200.h,
                                    width: 0.8.sw,
                                    decoration: BoxDecoration(

                                    ),
                                    child: AlertDialog(
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
                                            Text(getTranslated(context, "Cancel Reminder")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
                                            SizedBox(height: 20.h,),
                                            // Text(getTranslated(context,"Are you sure?\nYou want to delete\nThis Event")!,style: TextStyle(color: Color.fromRGBO(101, 101, 101, 1),fontSize: 16.sp,),textAlign: TextAlign.center,),
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
                                                  EventsService.deleteReminder(context,events[position].userDailyEventId.toString()).then((value){
                                                    log(value.toString());
                                                    setState(() {
                                                      if(value == true){
                                                        loadALLEventReminders();
                                                        //Navigator.of(context, rootNavigator: true).pop('dialog');
                                                      }
                                                    });
                                                    //log(basket.length.toString());
                                                  });
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
                                    ),
                                  )
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventDetails(eventsDetailsObject: events[position]!.toEventsDetailsObject(),)));

                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void loadALLEventReminders() {
    EventsService.getEventReminders(context).then((value) {
      log(value.toString());
      setState(() {
        events = value!;
      });
      log(events.length.toString());
    });
  }
}
