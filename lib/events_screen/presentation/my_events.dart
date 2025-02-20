import 'dart:developer';

import 'package:azhlha/events_screen/data/MyEventsDTO.dart';
import 'package:azhlha/events_screen/domain/events_service.dart';
import 'package:azhlha/events_screen/presentation/edit_events.dart';
import 'package:azhlha/favourite_screen/data/FavoriteProduct.dart';
import 'package:azhlha/favourite_screen/domain/favorite_srevice.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../favourite_screen/data/favorite_sellers.dart';
import '../../product_screen/presentation/product_screen.dart';
import '../../shared/alerts.dart';
import '../../stores_screen/presentation/stores_screen.dart';
import '../../utill/app_constants.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  bool isLoading =true;
  MyEventsDTO myEventDTOs = MyEventsDTO();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String token = '';

  void initawaits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      loadMyEvents();
      token = prefs.getString("token")!;
    } else {
      setState(() {
        // isLoading = false;
      });
      showToastLogin(context, getTranslated(context, "please login")!);
    }
  }

  @override
  void initState() {
    initawaits();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                getTranslated(context, "My EVents")!,
                style: TextStyle(
                    color: Color.fromRGBO(170, 143, 10, 1),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                InkWell(
                  child: Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/image/refresh.png"),
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                  onTap: (){
                    _onRefresh();
                  },
                ),
                SizedBox(width: 10.w,)
              ],
              backgroundColor: Colors.white,
            ),
            body:   LoadingOverlay(
                progressIndicator: SpinKitSpinningLines(
                  color: Color.fromRGBO(254, 222, 0, 1),
                ),
                color: Color.fromRGBO(254, 222, 0, 0.1),
                isLoading: isLoading,
                child: isLoading == true
                    ? Container()
                    :SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 0.99.sw,
                      height: 50.h,
                      child: TabBar(
                          indicatorColor: Color.fromRGBO(175, 147, 92, 1),
                          tabs: <Widget>[
                            Center(
                              child: Container(
                                height: 40.h,
                                width: 0.45.sw,
                                child: Center(
                                    child: Text(
                                  getTranslated(context, "Approved")!,
                                  style: TextStyle(
                                      color: Color.fromRGBO(52, 21, 87, 1),
                                      fontSize: 16.sp),
                                )),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 40.h,
                                width: 0.45.sw,
                                child: Center(
                                    child: Text(
                                  getTranslated(context, "UnderReview")!,
                                  style: TextStyle(
                                      color: Color.fromRGBO(52, 21, 87, 1),
                                      fontSize: 15.sp),
                                )),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 40.h,
                                width: 0.35.sw,
                                child: Center(
                                    child: Text(
                                  getTranslated(context, "Expired")!,
                                  style: TextStyle(
                                      color: Color.fromRGBO(52, 21, 87, 1),
                                      fontSize: 16.sp),
                                )),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 0.7.sh,
                    child: TabBarView(children: [
                      Container(
                        height: 0.4.sh,
                        width: 1.sw,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: myEventDTOs.approved!.length,
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                              child: InkWell(
                                child: Container(
                                  width: 0.75.sw,
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(170, 143, 10, 1),
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.sp)),
                                            image: DecorationImage(
                                              image: NetworkImage(AppConstants
                                                  .MAIN_URL_IMAGE +
                                                  myEventDTOs
                                                      .approved![position]
                                                      .image!),
                                            ),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    170, 143, 10, 1))),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 0.55.sw,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              myEventDTOs
                                                  .approved![position].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 24.sp,
                                                  color: Color.fromRGBO(
                                                      13, 24, 99, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Text(
                                              myEventDTOs
                                                  .approved![position].familyName.toString() +" - "+ myEventDTOs
                                                  .approved![position].eventCategory!.name.toString()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color.fromRGBO(
                                                      166, 139, 12, 1),
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  myEventDTOs
                                                      .approved![position]
                                                      .address
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          13, 24, 99, 1)
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  decoration: BoxDecoration(
//color: Colors.black87,
                                                      image: DecorationImage(
                                                          image:  AssetImage("assets/image/events-calendar-events-calendar.png"),
                                                          fit: BoxFit.contain
                                                      )
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  myEventDTOs
                                                      .approved![position]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          13, 24, 99, 1)
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 20.w,
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              CupertinoIcons.xmark_circle,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                              await showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (context) => Container(
                                                    height: 200.h,
                                                    width: 0.8.sw,
                                                    decoration:
                                                    BoxDecoration(),
                                                    child: AlertDialog(
                                                        scrollable:
                                                        true,
                                                        content: Column(
                                                          children: [
                                                            Container(
                                                                height: 50
                                                                    .h,
                                                                width: 50
                                                                    .w,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color:
                                                                  Colors.red,
                                                                  borderRadius:
                                                                  BorderRadius.circular(25.sp),
                                                                ),
                                                                child:
                                                                Center(
                                                                  child:
                                                                  Icon(
                                                                    CupertinoIcons.xmark_circle_fill,
                                                                    color:
                                                                    Colors.white,
                                                                    size:
                                                                    30.sp,
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height:
                                                              20.h,
                                                            ),
                                                            Text(
                                                              getTranslated(
                                                                  context,
                                                                  "delete Event")!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                  20.sp),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              20.h,
                                                            ),
                                                            Center(
                                                              child:
                                                              InkWell(
                                                                child:
                                                                Container(
                                                                  height:
                                                                  50.h,
                                                                  width:
                                                                  0.4.sw,
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromRGBO(170, 143, 10, 1),
                                                                      borderRadius: BorderRadius.circular(10.sp),
                                                                      border: Border.all(
                                                                        color: Color.fromRGBO(170, 143, 10, 1),
                                                                      )),
                                                                  child: Center(
                                                                      child: Text(
                                                                        getTranslated(context,
                                                                            "Confirm")!,
                                                                        style:
                                                                        TextStyle(color: Colors.white),
                                                                      )),
                                                                ),
                                                                onTap:
                                                                    () {
                                                                  EventsService.deleteEvent(context, myEventDTOs.approved![position].id.toString())
                                                                      .then((value) {
                                                                    log(value.toString());
                                                                    setState(() {
                                                                      if (value == true) {
                                                                        loadMyEvents();
// loadFavoriteSellers();
                                                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                      }
                                                                    });
//log(basket.length.toString());
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              30.h,
                                                            ),
                                                            Center(
                                                              child:
                                                              InkWell(
                                                                child:
                                                                Container(
                                                                  height:
                                                                  50.h,
                                                                  width:
                                                                  0.4.sw,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10.sp),
                                                                      border: Border.all(
                                                                        color: Color.fromRGBO(170, 143, 10, 1),
                                                                      )),
                                                                  child:
                                                                  Center(child: Text(getTranslated(context, "Cancel")!)),
                                                                ),
                                                                onTap:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ));
                                            },
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                          InkWell(
                                            child: Container(
                                              height: 20.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage("assets/image/edit.png"),
                                                      fit: BoxFit.contain
                                                  )
                                              ),
                                            ),
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (BuildContext context) => EditEventPage(underReview:  myEventDTOs.approved![position]!)));
                                            },
                                          )
// SizedBox(height: 50.h,),
// Container(
//     height: 25.h,
//     width:25.w,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15.sp),
//       boxShadow:[
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           blurRadius: 2,
//         ),
//       ],
//     ),
//     child:
//     Center(child: Icon(CupertinoIcons.forward,color: Colors.black87,size: 25.sp,))
// ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 0.4.sh,
                        width: 1.sw,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: myEventDTOs.underReview!.length,
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                              child: InkWell(
                                child: Container(
                                  width: 0.75.sw,
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(170, 143, 10, 1),
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.sp)),
                                            image: DecorationImage(
                                              image: NetworkImage(AppConstants
                                                      .MAIN_URL_IMAGE +
                                                  myEventDTOs
                                                      .underReview![position]
                                                      .image!),
                                            ),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    170, 143, 10, 1))),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 0.55.sw,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              myEventDTOs
                                                  .underReview![position].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 24.sp,
                                                  color: Color.fromRGBO(
                                                      13, 24, 99, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Text(
                                              myEventDTOs
                                                  .underReview![position].familyName.toString() +" - "+ myEventDTOs
                                                  .underReview![position].eventCategory!.name.toString()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color.fromRGBO(
                                                      166, 139, 12, 1),
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  myEventDTOs
                                                      .underReview![position]
                                                      .address
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          13, 24, 99, 1)
                                                     ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  decoration: BoxDecoration(
                                                    //color: Colors.black87,
                                                    image: DecorationImage(
                                                      image:  AssetImage("assets/image/events-calendar-events-calendar.png"),
                                                      fit: BoxFit.contain
                                                    )
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  myEventDTOs
                                                      .underReview![position]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          13, 24, 99, 1)
                                                      ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 10.w,
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              CupertinoIcons.xmark_circle,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                              await showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (context) => Container(
                                                            height: 200.h,
                                                            width: 0.8.sw,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: AlertDialog(
                                                                scrollable:
                                                                    true,
                                                                content: Column(
                                                                  children: [
                                                                    Container(
                                                                        height: 50
                                                                            .h,
                                                                        width: 50
                                                                            .w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.red,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.sp),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Icon(
                                                                            CupertinoIcons.xmark_circle_fill,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                30.sp,
                                                                          ),
                                                                        )),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                    Text(
                                                                      getTranslated(
                                                                          context,
                                                                          "delete Event")!,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              20.sp),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          InkWell(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              0.4.sw,
                                                                          decoration: BoxDecoration(
                                                                              color: Color.fromRGBO(170, 143, 10, 1),
                                                                              borderRadius: BorderRadius.circular(10.sp),
                                                                              border: Border.all(
                                                                                color: Color.fromRGBO(170, 143, 10, 1),
                                                                              )),
                                                                          child: Center(
                                                                              child: Text(
                                                                            getTranslated(context,
                                                                                "Confirm")!,
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          )),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                              EventsService.deleteEvent(context, myEventDTOs.underReview![position].id.toString())
                                                                                  .then((value) {
                                                                                log(value.toString());
                                                                                setState(() {
                                                                                  if (value == true) {
                                                                                    loadMyEvents();
                                                                                    // loadFavoriteSellers();
                                                                                    Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                  }
                                                                                });
                                                                                //log(basket.length.toString());
                                                                              });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30.h,
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          InkWell(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              0.4.sw,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10.sp),
                                                                              border: Border.all(
                                                                                color: Color.fromRGBO(170, 143, 10, 1),
                                                                              )),
                                                                          child:
                                                                              Center(child: Text(getTranslated(context, "Cancel")!)),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ));
                                            },
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                          InkWell(
                                            child: Container(
                                              height: 20.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage("assets/image/edit.png"),
                                                  fit: BoxFit.contain
                                                )
                                              ),
                                            ),
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (BuildContext context) => EditEventPage(underReview:  myEventDTOs.underReview![position]!)));
                                            },
                                          )
// SizedBox(height: 50.h,),
// Container(
//     height: 25.h,
//     width:25.w,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15.sp),
//       boxShadow:[
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           blurRadius: 2,
//         ),
//       ],
//     ),
//     child:
//     Center(child: Icon(CupertinoIcons.forward,color: Colors.black87,size: 25.sp,))
// ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 0.35.sh,
                        width: 1.sw,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: myEventDTOs.expired!.length,
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                              child: InkWell(
                                child: Container(
                                  width: 0.75.sw,
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(170, 143, 10, 1),
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.sp)),
                                            image: DecorationImage(
                                              image: NetworkImage(AppConstants
                                                  .MAIN_URL_IMAGE +
                                                  myEventDTOs
                                                      .expired![position]
                                                      .image!),
                                            ),
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    170, 143, 10, 1))),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 0.55.sw,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              myEventDTOs
                                                  .expired![position].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 24.sp,
                                                  color: Color.fromRGBO(
                                                      13, 24, 99, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Text(
                                              myEventDTOs
                                                  .expired![position].familyName.toString() +" - "+ myEventDTOs
                                                  .expired![position].eventCategory!.name.toString()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color.fromRGBO(
                                                      166, 139, 12, 1),
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  myEventDTOs
                                                      .expired![position]
                                                      .address
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          13, 24, 99, 1)
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  decoration: BoxDecoration(
//color: Colors.black87,
                                                      image: DecorationImage(
                                                          image:  AssetImage("assets/image/events-calendar-events-calendar.png"),
                                                          fit: BoxFit.contain
                                                      )
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  myEventDTOs
                                                      .expired![position]
                                                      .date
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color.fromRGBO(
                                                          13, 24, 99, 1)
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 20.w,
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              CupertinoIcons.xmark_circle,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                              await showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (context) => Container(
                                                    height: 200.h,
                                                    width: 0.8.sw,
                                                    decoration:
                                                    BoxDecoration(),
                                                    child: AlertDialog(
                                                        scrollable:
                                                        true,
                                                        content: Column(
                                                          children: [
                                                            Container(
                                                                height: 50
                                                                    .h,
                                                                width: 50
                                                                    .w,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color:
                                                                  Colors.red,
                                                                  borderRadius:
                                                                  BorderRadius.circular(25.sp),
                                                                ),
                                                                child:
                                                                Center(
                                                                  child:
                                                                  Icon(
                                                                    CupertinoIcons.xmark_circle_fill,
                                                                    color:
                                                                    Colors.white,
                                                                    size:
                                                                    30.sp,
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height:
                                                              20.h,
                                                            ),
                                                            Text(
                                                              getTranslated(
                                                                  context,
                                                                  "delete Event")!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                  20.sp),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              20.h,
                                                            ),
                                                            Center(
                                                              child:
                                                              InkWell(
                                                                child:
                                                                Container(
                                                                  height:
                                                                  50.h,
                                                                  width:
                                                                  0.4.sw,
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromRGBO(170, 143, 10, 1),
                                                                      borderRadius: BorderRadius.circular(10.sp),
                                                                      border: Border.all(
                                                                        color: Color.fromRGBO(170, 143, 10, 1),
                                                                      )),
                                                                  child: Center(
                                                                      child: Text(
                                                                        getTranslated(context,
                                                                            "Confirm")!,
                                                                        style:
                                                                        TextStyle(color: Colors.white),
                                                                      )),
                                                                ),
                                                                onTap:
                                                                    () {
                                                                  EventsService.deleteEvent(context, myEventDTOs.expired![position].id.toString())
                                                                      .then((value) {
                                                                    log(value.toString());
                                                                    setState(() {
                                                                      if (value == true) {
                                                                        loadMyEvents();
// loadFavoriteSellers();
                                                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                      }
                                                                    });
//log(basket.length.toString());
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              30.h,
                                                            ),
                                                            Center(
                                                              child:
                                                              InkWell(
                                                                child:
                                                                Container(
                                                                  height:
                                                                  50.h,
                                                                  width:
                                                                  0.4.sw,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10.sp),
                                                                      border: Border.all(
                                                                        color: Color.fromRGBO(170, 143, 10, 1),
                                                                      )),
                                                                  child:
                                                                  Center(child: Text(getTranslated(context, "Cancel")!)),
                                                                ),
                                                                onTap:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ));
                                            },
                                          ),



                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            )),
          )),
    );
  }

  void loadMyEvents() {
    setState(() {
      isLoading = true;
    });
    EventsService.getMyEvents(context).then((value) {
      log(value.toString());
      setState(() {
        myEventDTOs = value!;
        isLoading = false;
      });
      // log(myEventDTOs.length.toString());
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    initawaits();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
