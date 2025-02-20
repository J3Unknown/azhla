import 'dart:developer';

import 'package:azhlha/events_screen/data/events_object.dart';
import 'package:azhlha/events_screen/domain/events_service.dart';
import 'package:azhlha/events_screen/presentation/add_events.dart';
import 'package:azhlha/events_screen/presentation/event_details.dart';
import 'package:azhlha/events_screen/presentation/filter_events.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../address_screen/data/cities_object.dart';
import '../../address_screen/domain/address_service.dart';
import '../../shared/alerts.dart';
import '../../utill/localization_helper.dart';
import '../data/events_details_object.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  List <EventsObject> events =[];
  List <EventsDetailsObject> eventDetails =[];
  String? selectedValue;
  List<CitiesObject> cities = [];
  CitiesObject? selectedCity;
  List <bool> show = [];
  bool showAll = true;
  String token = '';
  bool isLoading = true;
  bool isLoading2 = false;
  void initawaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      token = prefs.getString("token")!;
      setState(() {
      //  word = "Log Out";
      });

    }
  }
  @override
  void initState() {
    loadCities();
    loadEvents();
    initawaits();
    loadALLEventsDetails();
    // loadEventsDetails(1);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(child:Icon(CupertinoIcons.back),
        onTap: (){
          Navigator.pop(context);
        },
        ),
        title:  Text(getTranslated(context, "Events")!,style: TextStyle(color: ColorsManager.primary ,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          InkWell(
            child: Container(
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath + AssetsManager.filter),
                  fit: BoxFit.contain
                )
              ),
            ),
            onTap: () async{
              await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return FilterEvents();
                  }
              );
            },
          ),
          SizedBox(width: 10.w,),
         // InkWell(child:Icon(CupertinoIcons.search),),
          //SizedBox(width: 10.w,)
        ],
        backgroundColor: Colors.white,
      ),
      body: LoadingOverlay(
    progressIndicator: SpinKitSpinningLines(
    color: ColorsManager.primary,
    ),
    color: Color.fromRGBO(254, 222, 0, 0.1),
    isLoading: isLoading,
    child: isLoading == true
    ? Container():SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              child: Text(getTranslated(context, KeysManager.categories)!,style: TextStyle(fontSize: 20.sp),),
            ),
            SizedBox(height: 10.h,),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 10.w,),
                  InkWell(
                    child: Container(
                      width: 110.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: (showAll != true)?ColorsManager.white: ColorsManager.primary,
                        borderRadius: BorderRadius.circular(5.sp),
                        boxShadow:[
                          BoxShadow(
                            color: ColorsManager.primary,
                            blurRadius: 2,
                          ),
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath + AssetsManager.all),
                                )
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Text(
                            getTranslated(context, "All")!,
                            style: TextStyle(fontSize: 15.0, color: ColorsManager.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        isLoading2 = true;
                      });
                      if(showAll == false){
                        setState(() {
                          showAll = true;
                          for(int i =0 ;i<show.length;i++){
                            show[i] = false;
                          }
                          loadALLEventsDetails();
                        });
                      }
                    },
                  ),
                  Container(
                    height: 100.h,
                    width: 0.65.sw,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, position) {
                        return Padding(
                          padding:  EdgeInsets.only(left: 10.w),
                          child: InkWell(
                            child: Container(
                              width: 110.w,
                              height: 100.h,
                              decoration: BoxDecoration(

                                border: Border.all(
                                      color: ColorsManager.primary
                                  ),
                                color: (show[position] == true)?ColorsManager.white:ColorsManager.primary,
                                borderRadius: BorderRadius.circular(5.sp),
                                boxShadow:[
                                  BoxShadow(
                                    color: ColorsManager.primary,
                                    blurRadius: 3,
                                  ),
                                ],

                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(AppConstants.MAIN_URL_IMAGE+events[position].image!),
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text(
                                    events[position].name!,
                                    style: TextStyle(fontSize: 15.0, color: ColorsManager.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                isLoading2 = true;
                              });
                              if(show[position] == true){
                                setState(() {

                                  show[position] = false;
                                });
                              }
                              if(show[position] == false){
                                setState(() {
                                  for(int i =0 ;i<show.length;i++){
                                    show[i] = false;
                                  }
                                  showAll = false;
                                  show[position] = true;
                                });
                              }
                              // setState(() {
                              //   isLoading2 = true;
                              // });
                              loadEventsDetails(events[position].id!);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding:  EdgeInsets.only(left: 10.w,right: 10.w),
              child: Text(getTranslated(context, KeysManager.events)!,style: TextStyle(fontSize: 20.sp),),
            ),
          SingleChildScrollView(
              child: Container(
                height: 0.58.sh,
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
                child:   LoadingOverlay(
                    progressIndicator: SpinKitSpinningLines(
                      color: ColorsManager.primary,
                    ),
                    color: ColorsManager.primary0_1Transparency,
                    isLoading: isLoading2,
                    child: isLoading2 == true
                        ? Container():ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: eventDetails.length,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                      child: InkWell(
                        child: Container(
                          width: 0.75.sw,
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.sp),
                            boxShadow:[
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
                                height: 80.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+eventDetails[position].image!),
                                    ),
                                    borderRadius: BorderRadius.circular(50.sp),
                                    border: Border.all(
                                        color: ColorsManager.primary
                                    )
                                ),
                              ),
                              SizedBox(width: 20.w,),
                              Container(
                                height: 200.h,
                                width: 200.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      eventDetails[position].name!,
                                      style: TextStyle(fontSize: 20.sp,color: ColorsManager.deepBlue, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Text(
                                          eventDetails[position].eventCategory!.name!,
                                          style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                        ),
                                        SizedBox(width: 5.w,),
                                        Text(
                                          eventDetails[position].familyName!,
                                          style: TextStyle(fontSize: 15.0,color: Colors.grey,),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.location_solid,size: 15.sp,color: ColorsManager.primary,),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(maxWidth: 150.h),
                                          child: Text(
                                            eventDetails[position].address!,
                                            style: TextStyle(fontSize: 15.0, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.calendar,size: 15.sp,),
                                        Text(
                                          eventDetails[position].date!,
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 15.h,
                                width: 15.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imagePath+ AssetsManager.forward)
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventDetails(eventsDetailsObject: eventDetails[position],)));

                        },
                      ),
                    );
                  },
                )),
              ),
            ),

          ],),
      )),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: ColorsManager.primary,
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if(prefs.containsKey("token")) {
                token = prefs.getString("token")!;
                setState(() {
                  //  word = "Log Out";
                });

              }
              if(token != '') {
                Navigator.push(
                    context,MaterialPageRoute(
                        builder: (BuildContext context) => AddEventPage()));
              }
              else {
                showToastLogin(context,getTranslated(context, "please login")!);
              }
            }
        )
    );
  }
  void loadCities() {
    AddressService.getCities(context).then((value) {
      log(value.toString());
      setState(() {
        cities = value!;
      });
      log(cities.length.toString());
    });
  }
  void loadEvents() {
    EventsService.getEvents(context).then((value) {
      log(value.toString());
      setState(() {
        events = value!;
       // show.add(true);
        for(int i =0 ;i <events.length;i++){
          show.add(false);
        }
        isLoading = false;
      });
      log(events.length.toString());
    });
  }
  void loadEventsDetails(int? event_category_id) {
    EventsService.getEventsDetails(context,event_category_id).then((value) {
      log(value.toString());
      setState(() {
        eventDetails = value!;
        isLoading2 = false;
      });
      log(events.length.toString());
    });
  }
  void loadALLEventsDetails() {
    EventsService.getAllEventsDetails(context).then((value) {
      log(value.toString());
      setState(() {
        eventDetails = value!;
        isLoading2 = false;
      });
      log(events.length.toString());
    });
  }

}
