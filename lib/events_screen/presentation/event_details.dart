import 'dart:developer';
import 'dart:ui';

import 'package:azhlha/events_screen/data/events_details_object.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../shared/alerts.dart';
import '../../sign_in_screen/presentation/sign_in_screen.dart';
import '../../utill/localization_helper.dart';
import '../domain/events_service.dart';

class EventDetails extends StatefulWidget {
  late EventsDetailsObject eventsDetailsObject;
   EventDetails({super.key,required this.eventsDetailsObject});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  String token = '';
  void initawaits() async{

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: InkWell(child:Icon(CupertinoIcons.back),
        onTap: (){
          Navigator.pop(context);
        },
        ),
        title:  Text(getTranslated(context, KeysManager.events)!,style: TextStyle(color: ColorsManager.primary, fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [

        ],
        backgroundColor: ColorsManager.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: Image(
                    image:  NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.image!),
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: 200.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorsManager.primary,
                        ),
                      image: DecorationImage(
                        image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.image!),
                        fit: BoxFit.fitHeight
                      )
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30.h,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 80.h,
                      ),
                      decoration:BoxDecoration(
                        border: Border.all(
                          color: ColorsManager.primary,
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: IntrinsicWidth(
                          child: Image(image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.image!))
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40.h,),
            SizedBox(
              height: 30.h,
              width: 0.9.sw,
              child: Text(
                widget.eventsDetailsObject.name!,style: TextStyle(color: ColorsManager.deepBlue,fontSize: 24.sp),
              ),
            ),
            SizedBox(height: 10.h,),
            SizedBox(
              height: 30.h,
              width: 0.9.sw,
              child: Row(
                children: [
                  Icon(CupertinoIcons.calendar,size: 15.sp,),
                  SizedBox(width: 5.w,),
                  Text(
                    widget.eventsDetailsObject.date!,style: TextStyle(color: ColorsManager.deepBlue, fontSize: 20.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            SizedBox(
              height: 100.h,
              width: 0.9.sw,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.eventsDetailsObject.description!,style: TextStyle(fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            (widget.eventsDetailsObject.type! == KeysManager.male)?Padding(
              padding:  EdgeInsets.all(20.sp),
              child: InkWell(
                child: Container(
                  width: 0.9.sw,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.sp),
                    boxShadow: const [
                       BoxShadow(
                        color: ColorsManager.primary,
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
                              image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.eventCategory!.image!),
                            )
                        ),
                      ),
                      SizedBox(width: 30.w,),
                      SizedBox(
                        height: 200.h,
                        width: 220.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h,),
                            Text(
                              getTranslated(context, KeysManager.forMen)!,
                              style: const TextStyle(fontSize: 15.0, color: ColorsManager.deepBlue, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.sp),
                                      // border: Border.all(
                                      //   color: Colors.black87
                                      // ),
                                      image: const DecorationImage(
                                        image: AssetImage(imagePath+AssetsManager.whats),
                                        fit: BoxFit.contain
                                      )
                                    ),
                                  ),
                                  onTap: (){
                                    launchWhatsApp(widget.eventsDetailsObject.whatsAppNumber!);
                                  },
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.sp),
                                        // border: Border.all(
                                        //     color: Colors.black87
                                        // ),
                                        image: const DecorationImage(
                                            image: AssetImage(imagePath+AssetsManager.location),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: (){
                                    launchLocation(widget.eventsDetailsObject.latitude!,widget.eventsDetailsObject.longitude!);
                                  },
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.sp),
                                        // border: Border.all(
                                        //     color: Colors.black87
                                        // ),
                                        image: const DecorationImage(
                                            image: AssetImage(imagePath + AssetsManager.call),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: (){
                                    _callNumber(widget.eventsDetailsObject.phone!);
                                  },
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(imagePath+AssetsManager.reminder),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: () async{
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    if(prefs.containsKey(AppConstants.TOKEN)) {
                                      await showDialog<void>(
                                          context: context,
                                          builder: (context) => SizedBox(
                                            height: 200.h,
                                            width: 0.8.sw,
                                            child: AlertDialog(
                                                scrollable: true,
                                                content: Column(
                                                  children: [
                                                    Container(
                                                      height: 30.h,
                                                      width: 30.w,
                                                      decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(imagePath+AssetsManager.reminder),
                                                              fit: BoxFit.contain
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(height: 20.h,),
                                                    Text(getTranslated(context, KeysManager.eventReminder)!,style: TextStyle(color: ColorsManager.red,fontSize: 20.sp),),
                                                    SizedBox(height: 20.h,),
                                                    // Text(getTranslated(context,"Are you sure?\nto set a reminder for this event")!,style: TextStyle(color: Color.fromRGBO(101, 101, 101, 1),fontSize: 16.sp,),textAlign: TextAlign.center,),
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
                                                          child: Center(child: Text(getTranslated(context, KeysManager.confirm)!,style: TextStyle(color: ColorsManager.white),)),
                                                        ),
                                                        onTap: (){
                                                          //Navigator.of(context, rootNavigator: true).pop('dialog');
                                                          //Navigator.pop(context);
                                                          EventsService.addReminder(context,widget.eventsDetailsObject.id.toString()).then((value){
                                                            // log(value.toString());
                                                            log("pop");

                                                            setState(() {
                                                              if(value == true){
                                                                log("added");
                                                                //showToast(context, "added successfully");

                                                                // loadData();
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
                                                          child: Center(child: Text(getTranslated(context, KeysManager.cancel)!)),
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
                                      token = prefs.getString(AppConstants.TOKEN)!;
                                    }else{
                                      setState(() {
                                        // isLoading = false;
                                      });
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                          builder: (BuildContext context) => SignInScreen(signUp: 'test',)));
                                    }


                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.location_solid,size: 15.sp,color: ColorsManager.primary,),
                                Text(
                                  widget.eventsDetailsObject.address!,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       eventDetails[position]!.eventCategory!.name!,
                            //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                            //     ),
                            //     SizedBox(width: 5.w,),
                            //     Text(
                            //       eventDetails[position]!.familyName!,
                            //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 5.h,),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Icon(CupertinoIcons.location_solid,size: 15.sp,color: Color.fromRGBO(166, 139, 12, 1),),
                            //     Text(
                            //       eventDetails[position]!.address!,
                            //       style: TextStyle(fontSize: 15.0),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 5.h,),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Icon(CupertinoIcons.calendar,size: 15.sp,),
                            //     Text(
                            //       eventDetails[position]!.date!,
                            //       style: TextStyle(fontSize: 15.0),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // Icon(CupertinoIcons.chevron_forward),
                    ],
                  ),
                ),
                // onTap: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventDetails(eventsDetailsObject: eventDetails[position]!,)));
                //
                // },
              ),
            ):(widget.eventsDetailsObject.type! == KeysManager.female)?
            Padding(
              padding:  EdgeInsets.all(20.sp),
              child: InkWell(
                child: Container(
                  width: 0.9.sw,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.sp),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorsManager.primary,
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
                              image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.eventCategory!.image!),
                            )
                        ),
                      ),
                      SizedBox(width: 30.w,),
                      SizedBox(
                        height: 200.h,
                        width: 220.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h,),
                            Text(
                              getTranslated(context, KeysManager.forWomen)!,
                              style: const TextStyle(fontSize: 15.0,color: ColorsManager.deepBlue, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.sp),
                                        // border: Border.all(
                                        //   color: Colors.black87
                                        // ),
                                        image: const DecorationImage(
                                            image: AssetImage(imagePath + AssetsManager.whats),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: (){
                                    launchWhatsApp(widget.eventsDetailsObject.fWhatsAppNumber!);
                                  },
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.sp),
                                        // border: Border.all(
                                        //     color: Colors.black87
                                        // ),
                                        image: const DecorationImage(
                                            image: AssetImage(imagePath + AssetsManager.location),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: (){
                                    launchLocation(widget.eventsDetailsObject.fLatitude!,widget.eventsDetailsObject.fLongitude!);
                                  },
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.sp),
                                        // border: Border.all(
                                        //     color: Colors.black87
                                        // ),
                                        image: const DecorationImage(
                                            image: AssetImage(imagePath + AssetsManager.call),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: (){
                                    _callNumber(widget.eventsDetailsObject.fPhone!);
                                  },
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(imagePath + AssetsManager.reminder),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  onTap: () async{
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    if(prefs.containsKey(AppConstants.TOKEN)) {
                                      await showDialog<void>(
                                          context: context,
                                          builder: (context) => SizedBox(
                                            height: 200.h,
                                            width: 0.8.sw,
                                            child: AlertDialog(
                                                scrollable: true,
                                                content: Column(
                                                  children: [
                                                    Container(
                                                      height: 30.h,
                                                      width: 30.w,
                                                      decoration: const  BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(imagePath + AssetsManager.reminder),
                                                              fit: BoxFit.contain
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(height: 20.h,),
                                                    Text(getTranslated(context, KeysManager.eventReminder)!,style: TextStyle(color: ColorsManager.red,fontSize: 20.sp),),
                                                    SizedBox(height: 20.h,),
                                                    // Text(getTranslated(context,"Are you sure?\nto set a reminder for this event")!,style: TextStyle(color: Color.fromRGBO(101, 101, 101, 1),fontSize: 16.sp,),textAlign: TextAlign.center,),
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
                                                          child: Center(child: Text(getTranslated(context, KeysManager.confirm)!,style: TextStyle(color: ColorsManager.white),)),
                                                        ),
                                                        onTap: (){
                                                          log("function");
                                                          EventsService.addReminder(context,widget.eventsDetailsObject.id.toString()).then((value){
                                                             log(value.toString());
                                                            setState(() {
                                                              if(value == true){
                                                                log("value sa7");
                                                               // showToast(context, "added successfully");
                                                                // loadData();
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
                                                          child: Center(child: Text(getTranslated(context, KeysManager.cancel)!)),
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
                                      token = prefs.getString(AppConstants.TOKEN)!;
                                    }else{
                                      setState(() {
                                        // isLoading = false;
                                      });
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                          builder: (BuildContext context) => SignInScreen(signUp: 'test',)));
                                    }


                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.location_solid,size: 15.sp,color: ColorsManager.primary,),
                                Text(
                                  widget.eventsDetailsObject.fAddress!,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       eventDetails[position]!.eventCategory!.name!,
                            //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                            //     ),
                            //     SizedBox(width: 5.w,),
                            //     Text(
                            //       eventDetails[position]!.familyName!,
                            //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 5.h,),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Icon(CupertinoIcons.location_solid,size: 15.sp,color: Color.fromRGBO(166, 139, 12, 1),),
                            //     Text(
                            //       eventDetails[position]!.address!,
                            //       style: TextStyle(fontSize: 15.0),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 5.h,),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Icon(CupertinoIcons.calendar,size: 15.sp,),
                            //     Text(
                            //       eventDetails[position]!.date!,
                            //       style: TextStyle(fontSize: 15.0),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // Icon(CupertinoIcons.chevron_forward),
                    ],
                  ),
                ),
                // onTap: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventDetails(eventsDetailsObject: eventDetails[position]!,)));
                //
                // },
              ),
            ):Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:20.w,right: 20.w,top: 10.h,bottom: 10.h),
                  child: InkWell(
                    child: Container(
                      width: 0.9.sw,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(20.sp),
                        boxShadow: const [
                          BoxShadow(
                            color: ColorsManager.primary,
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
                                  image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.eventCategory!.image!),
                                )
                            ),
                          ),
                          SizedBox(width: 30.w,),
                          SizedBox(
                            height: 200.h,
                            width: 220.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30.h,),
                                Text(
                                  getTranslated(context, KeysManager.forMen)!,
                                  style: const TextStyle(fontSize: 15.0,color: ColorsManager.deepBlue,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.sp),
                                            // border: Border.all(
                                            //   color: Colors.black87
                                            // ),
                                            image: const DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.whats),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: (){
                                        launchWhatsApp(widget.eventsDetailsObject.whatsAppNumber!);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.sp),
                                            // border: Border.all(
                                            //     color: Colors.black87
                                            // ),
                                            image: const DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.location),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: (){
                                        launchLocation(widget.eventsDetailsObject.latitude!,widget.eventsDetailsObject.longitude!);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.sp),
                                            // border: Border.all(
                                            //     color: Colors.black87
                                            // ),
                                            image: const DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.call),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: (){
                                        _callNumber(widget.eventsDetailsObject.phone!);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      child: Container(
                                        height: 35.h,
                                        width: 35.w,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.reminder),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: () async{
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        if(prefs.containsKey(AppConstants.TOKEN)) {
                                          await showDialog<void>(
                                              context: context,
                                              builder: (context) => SizedBox(
                                                height: 200.h,
                                                width: 0.8.sw,
                                                child: AlertDialog(
                                                    scrollable: true,
                                                    content: Column(
                                                      children: [
                                                        Container(
                                                          height: 30.h,
                                                          width: 30.w,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(imagePath + AssetsManager.reminder),
                                                                  fit: BoxFit.contain
                                                              )
                                                          ),
                                                        ),
                                                        SizedBox(height: 20.h,),
                                                        Text(getTranslated(context, KeysManager.eventReminder)!,style: TextStyle(color: ColorsManager.red,fontSize: 20.sp),),
                                                        SizedBox(height: 20.h,),
                                                        // Text(getTranslated(context,"Are you sure?\nto set a reminder for this event")!,style: TextStyle(color: Color.fromRGBO(101, 101, 101, 1),fontSize: 16.sp,),textAlign: TextAlign.center,),
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
                                                              child: Center(child: Text(getTranslated(context, KeysManager.confirm)!,style: TextStyle(color: ColorsManager.white),)),
                                                            ),
                                                            onTap: (){
                                                              EventsService.addReminder(context,widget.eventsDetailsObject.id.toString()).then((value){
                                                                // log(value.toString());
                                                                setState(() {
                                                                  if(value == true){
                                                                    // loadData();
                                                                    //showToast(context, "added successfully");

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
                                                              child: Center(child: Text(getTranslated(context, KeysManager.cancel)!)),
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
                                          token = prefs.getString(AppConstants.TOKEN)!;
                                        }else{
                                          setState(() {
                                            // isLoading = false;
                                          });
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (BuildContext context) => SignInScreen(signUp: 'test',)));
                                        }


                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.location_solid,size: 15.sp,color: ColorsManager.primary,),
                                    Text(
                                      widget.eventsDetailsObject.address!,
                                      style: const TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       eventDetails[position]!.eventCategory!.name!,
                                //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                //     ),
                                //     SizedBox(width: 5.w,),
                                //     Text(
                                //       eventDetails[position]!.familyName!,
                                //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 5.h,),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Icon(CupertinoIcons.location_solid,size: 15.sp,color: Color.fromRGBO(166, 139, 12, 1),),
                                //     Text(
                                //       eventDetails[position]!.address!,
                                //       style: TextStyle(fontSize: 15.0),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 5.h,),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Icon(CupertinoIcons.calendar,size: 15.sp,),
                                //     Text(
                                //       eventDetails[position]!.date!,
                                //       style: TextStyle(fontSize: 15.0),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          // Icon(CupertinoIcons.chevron_forward),
                        ],
                      ),
                    ),
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventDetails(eventsDetailsObject: eventDetails[position]!,)));
                    //
                    // },
                  ),
                ),
                // SizedBox(height: 20.h,),
                Padding(
                  padding:  EdgeInsets.only(left:20.w,right: 20.w,top: 10.h,bottom: 10.h),
                  child: InkWell(
                    child: Container(
                      width: 0.9.sw,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(20.sp),
                        boxShadow: const [
                          BoxShadow(
                            color: ColorsManager.primary,
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
                                  image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.eventsDetailsObject.eventCategory!.image!),
                                )
                            ),
                          ),
                          SizedBox(width: 30.w,),
                          SizedBox(
                            height: 200.h,
                            width: 220.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30.h,),
                                Text(
                                  getTranslated(context, KeysManager.forWomen)!,
                                  style: const TextStyle(fontSize: 15.0,color: ColorsManager.deepBlue,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.sp),
                                            // border: Border.all(
                                            //   color: Colors.black87
                                            // ),
                                            image: const DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.whats),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: (){
                                        launchWhatsApp(widget.eventsDetailsObject.fWhatsAppNumber!);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.sp),
                                            // border: Border.all(
                                            //     color: Colors.black87
                                            // ),
                                            image: const DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.location),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: (){
                                        launchLocation(widget.eventsDetailsObject.fLatitude!,widget.eventsDetailsObject.fLongitude!);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.sp),
                                            // border: Border.all(
                                            //     color: Colors.black87
                                            // ),
                                            image: const DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.call),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: (){
                                        _callNumber(widget.eventsDetailsObject!.fPhone!);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                      child: Container(
                                        height: 35.h,
                                        width: 35.w,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(imagePath + AssetsManager.reminder),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                      onTap: () async{
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        if(prefs.containsKey(AppConstants.TOKEN)) {
                                          await showDialog<void>(
                                              context: context,
                                              builder: (context) => SizedBox(
                                                height: 200.h,
                                                width: 0.8.sw,
                                                child: AlertDialog(
                                                    scrollable: true,
                                                    content: Column(
                                                      children: [
                                                        Container(
                                                          height: 30.h,
                                                          width: 30.w,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(imagePath + AssetsManager.reminder),
                                                                  fit: BoxFit.contain
                                                              )
                                                          ),
                                                        ),
                                                        SizedBox(height: 20.h,),
                                                        Text(getTranslated(context, KeysManager.eventReminder)!,style: TextStyle(color: ColorsManager.red,fontSize: 20.sp),),
                                                        SizedBox(height: 20.h,),
                                                        // Text(getTranslated(context,"Are you sure?\nto set a reminder for this event")!,style: TextStyle(color: Color.fromRGBO(101, 101, 101, 1),fontSize: 16.sp,),textAlign: TextAlign.center,),
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
                                                              child: Center(child: Text(getTranslated(context, KeysManager.confirm)!,style: const TextStyle(color: ColorsManager.white),)),
                                                            ),
                                                            onTap: (){
                                                              EventsService.addReminder(context,widget.eventsDetailsObject.id.toString()).then((value){
                                                                // log(value.toString());
                                                                setState(() {
                                                                  if(value == true){
                                                                    // loadData();
                                                                    //showToast(context, "added successfully");

                                                                    // Navigator.of(context, rootNavigator: true).pop('dialog');
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
                                                              child: Center(child: Text(getTranslated(context, KeysManager.cancel)!)),
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
                                          token = prefs.getString(AppConstants.TOKEN)!;
                                        }else{
                                          setState(() {
                                            // isLoading = false;
                                          });
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (BuildContext context) => SignInScreen(signUp: 'test',)));
                                        }


                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.location_solid,size: 15.sp,color: ColorsManager.primary),
                                    Text(
                                      widget.eventsDetailsObject.fAddress!,
                                      style: const TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       eventDetails[position]!.eventCategory!.name!,
                                //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                //     ),
                                //     SizedBox(width: 5.w,),
                                //     Text(
                                //       eventDetails[position]!.familyName!,
                                //       style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 5.h,),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Icon(CupertinoIcons.location_solid,size: 15.sp,color: Color.fromRGBO(166, 139, 12, 1),),
                                //     Text(
                                //       eventDetails[position]!.address!,
                                //       style: TextStyle(fontSize: 15.0),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 5.h,),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Icon(CupertinoIcons.calendar,size: 15.sp,),
                                //     Text(
                                //       eventDetails[position]!.date!,
                                //       style: TextStyle(fontSize: 15.0),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          // Icon(CupertinoIcons.chevron_forward),
                        ],
                      ),
                    ),
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventDetails(eventsDetailsObject: eventDetails[position]!,)));
                    //
                    // },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Future<void> launchWhatsApp(String phone) async {
    final link = WhatsAppUnilink(
      phoneNumber: '${phone}',
      text: "",
    );
    await launch('$link');
  }
  Future<void> launchLocation(String lat,String long) async {
    String url = "https://www.google.com/maps/search/?api=1&query=" + lat+ ","+ long  ;
    launch(url);
  }
  _callNumber(String phone) async{
    const number = '08592119XXXX'; //set the number here
    bool ?res = await FlutterPhoneDirectCaller.callNumber(phone);
  }
}
