import 'dart:developer';

import 'package:azhlha/notifications/Data/notifications_dto.dart';
import 'package:azhlha/notifications/domain/notifiactions_service.dart';
import 'package:azhlha/notifications/presentation/notification_detials_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationsDTO> notifications = [];
  bool isLoading = true;
  late BuildContext _safeContext; // Store a safe reference to context
  @override
  void initState() {
    loadNotificationsData();
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _safeContext = context; // Store context safely
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
        title:  Text(getTranslated(context, "Notifications")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: LoadingOverlay(
          progressIndicator: SpinKitSpinningLines(
            color: Color.fromRGBO(254, 222, 0, 1),
          ),
          color: Color.fromRGBO(254, 222, 0, 0.1),
          isLoading: isLoading,
          child: isLoading == true
              ? Container():Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: notifications.length,
          itemBuilder: (context, position) {
            return Padding(
              padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h,bottom: 10.h),
              child: InkWell(
                child: Container(
                  width: 100.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color:notifications[position].read == "0"?Color.fromRGBO(240, 240, 240, 1):Colors.white,
                    borderRadius: BorderRadius.circular(15.sp),
                    boxShadow:[
                      BoxShadow(
                        color: ColorsManager.primary,
                        blurRadius: 2,
                      ),
                    ],

                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 70.h,
                      width: 70.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.sp),
                        image: DecorationImage(
                          image: AssetImage("assets/image/1024.png")
                        )
                      ),
                    ),
                    SizedBox(width: 30.w,),
                    Container(
                      width: 0.65.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notifications[position].name.toString(),style: TextStyle(fontSize: 24.sp,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),),
                          SizedBox(height: 5.h,),
                          Text(notifications[position].description.toString(),style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(13, 24, 99, 1)),),
                          SizedBox(height: 10.h,),
                          Text(notifications[position].updatedAt.toString(),style: TextStyle(fontSize: 16.sp,color: Color.fromRGBO(13, 24, 99, 1)),)

                        ],
                      ),
                    )
                  ],
                ),
                ),

                  onTap: () async {
                    setState(() {
                      isLoading = true; // Start loading
                    });

                    bool? value = await NotificationsService.markAsRead(
                      context,
                      notifications[position].id.toString(),
                    );

                    log("value: $value");

                    if (value == true) {
                      setState(() {
                        notifications[position].read = "1"; // Mark as read
                        isLoading = false; // Stop loading before navigating
                      });

                      log("Navigating to details screen");

                      Future.delayed(Duration(milliseconds: 100), () {
                        Navigator.of(_safeContext, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => NotificationDetailsScreen(
                              name: notifications[position].name.toString(),
                              disc: notifications[position].description.toString(),
                              updatedAt: notifications[position].updatedAt.toString(),
                            ),
                          ),
                        );
                      });
                    } else {
                      log("Failed to mark as read");
                      setState(() {
                        isLoading = false; // Stop loading if failed
                      });
                    }
                  },
              ),
            );
          },

        ),
      )),
    );
  }
  void loadNotificationsData(){
    NotificationsService.getAllNotifications(context).then((value){
      log(value.toString());
      setState(() {
        isLoading = false;
        notifications = value!;

      });
      log(notifications.length.toString());
    });
    setState(() {
      isLoading = false;
    });
  }
}
