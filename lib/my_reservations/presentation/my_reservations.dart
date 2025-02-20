import 'dart:developer';

import 'package:azhlha/my_reservations/data/reservations_object.dart';
import 'package:azhlha/my_reservations/domain/reservations_service.dart';
import 'package:azhlha/my_reservations/presentation/reservation_details.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/alerts.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class MyReservations extends StatefulWidget {
  const MyReservations({Key? key}) : super(key: key);

  @override
  _MyReservationsState createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations>  with
    AutomaticKeepAliveClientMixin<MyReservations>{
  List<ReservationsObject> reservationsList = [];
  TextEditingController cancellationController = TextEditingController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isLoading = true;
  String token = '';
  @override
  void initState() {

    initawaits();
    // TODO: implement initState
    super.initState();
  }
  void initawaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      loadData();
      token = prefs.getString("token")!;
    }else{
      setState(() {
        isLoading = false;
      });
   showToastLogin(context,getTranslated(context, "please login")!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: InkWell(child:Icon(CupertinoIcons.back),),
        title:  Text(getTranslated(context, "My Reservations")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          InkWell(
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagePath+AssetsManager.refresh),
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
      ),
      body: LoadingOverlay(
    progressIndicator: SpinKitSpinningLines(
    color: ColorsManager.primary,
    ),
    color: ColorsManager.primary0_1Transparency,
    isLoading: isLoading,
    child: isLoading == true
    ? Container(): SmartRefresher(
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: Container(
          height: 0.9.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300.sp),
          ),
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              SizedBox(
                height: 0.8.sh,
                width: 1.sw,
                child: (reservationsList.isNotEmpty)?ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: reservationsList.length,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding:  EdgeInsets.all(20.sp),
                      child: InkWell(
                        child: Container(
                          width: 0.75.sw,
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(20.sp),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0.0, 1.0),
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
                                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+reservationsList[position].seller!.imgPath!),
                                    ),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    border: Border.all(
                                        color: ColorsManager.primary
                                    )
                                ),
                              ),
                              SizedBox(width: 30.w,),
                              Container(
                                height: 150.h,
                                width: 0.5.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(context, "Order No")!+reservationsList[position].orderNumber.toString(),
                                      style: TextStyle(fontSize: 18.0,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text(
                                      getTranslated(context, "Date")!+ " "+reservationsList[position].updatedAt.toString(),
                                      style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(13, 24, 99, 1),),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text(
                                      getTranslated(context, "From")!+  " "+reservationsList[position].seller!.name!,
                                      style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(13, 24, 99, 1),),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Text(getTranslated(context, "Order Status")!+" ",style: TextStyle(fontSize: 15.0,color: (reservationsList[position].status! != "cancel")?Color.fromRGBO(13, 24, 99, 1):Colors.red,)),
                                        Text(
                                          (reservationsList[position].status! == "cancel")?getTranslated(context, "Canceled")!:(reservationsList[position].status! == "order_placed")?getTranslated(context, "order_placed")!:(reservationsList[position].status! == "out_for_delivery")?getTranslated(context, "out_for_delivery")!:(reservationsList[position].status! == "delivered")?getTranslated(context, "delivered")!:getTranslated(context, "Confirmed")!,
                                          style: TextStyle(fontSize: 15.0,color: (reservationsList[position].status! != "cancel")?Color.fromRGBO(13, 24, 99, 1):Colors.red,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ( reservationsList[position].status! != "cancel")? InkWell(
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
                                          height: 300.h,
                                          width: 0.8.sw,
                                          decoration: BoxDecoration(

                                          ),
                                          child:  AlertDialog(
                                              scrollable: true,
                                              content: Column(
                                                children: [
                                                  Container(
                                                      height: 50.h,
                                                      width:50.w,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius: BorderRadius.circular(30.sp),
                                                      ),
                                                      child:
                                                      Center(child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.white,size: 30.sp,),)
                                                  ),
                                                  SizedBox(height: 10.h,),
                                                  Text(getTranslated(context, "Cancel order")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
                                                  SizedBox(height: 10.h,),
                                                  Text(getTranslated(context,"Are you sure?\nIn case yes the minimum amount\nFor reservation will not be refunded")!,style: TextStyle(color: Color.fromRGBO(101, 101, 101, 1),fontSize: 16.sp,),textAlign: TextAlign.center,),
                                                  SizedBox(height: 10.h,),
                                                  Container(
                                                    height: 100.h,
                                                    width: 0.8.sw,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.sp),
                                                        border: Border.all(
                                                            color: ColorsManager.primary
                                                        )
                                                    ),
                                                    child: TextFormField(
                                                        controller: cancellationController,
                                                        textAlign: TextAlign.center,
                                                        maxLines: 5,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          hintText: getTranslated(context, "Reason of cancelation")!,
                                                          contentPadding: EdgeInsets.all(5.w),
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.h,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Center(
                                                        child: InkWell(
                                                          child: Container(
                                                            height: 50.h,
                                                            width: 0.25.sw,
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
                                                            ReservationService.cancelOrders(context,reservationsList[position].id.toString(),cancellationController.text).then((value){
                                                              log(value.toString());
                                                              setState(() {
                                                                if(value == true){

                                                                      loadData();
                                                                      Navigator.of(context, rootNavigator: true).pop('dialog');

                                                                }
                                                              });
                                                              //log(basket.length.toString());
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 30.h,),
                                                      Center(
                                                        child: InkWell(
                                                          child: Container(
                                                            height: 50.h,
                                                            width: 0.25.sw,
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
                                                  ),
                                                  // Center(
                                                  //   child: InkWell(
                                                  //     child: Container(
                                                  //       height: 50.h,
                                                  //       width: 0.4.sw,
                                                  //       decoration: BoxDecoration(
                                                  //           color: Color.fromRGBO(170, 143, 10, 1),
                                                  //           borderRadius: BorderRadius.circular(10.sp),
                                                  //           border: Border.all(
                                                  //             color: Color.fromRGBO(170, 143, 10, 1),
                                                  //           )
                                                  //       ),
                                                  //       child: Center(child: Text(getTranslated(context, "Confirm")!,style: TextStyle(color: Colors.white),)),
                                                  //     ),
                                                  //     onTap: (){
                                                  //       ReservationService.cancelOrders(context,widget.reservationsObject.id.toString(),cancellationController.text).then((value){
                                                  //         log(value.toString());
                                                  //         setState(() {
                                                  //           if(value == true){
                                                  //             Navigator.of(context, rootNavigator: true).pushReplacement(
                                                  //                 MaterialPageRoute(
                                                  //                     builder: (BuildContext context) => ButtomNavBarScreen(intial: 1)));
                                                  //           }
                                                  //         });
                                                  //         //log(basket.length.toString());
                                                  //       });
                                                  //     },
                                                  //   ),
                                                  // ),
                                                  // SizedBox(height: 30.h,),
                                                  // Center(
                                                  //   child: InkWell(
                                                  //     child: Container(
                                                  //       height: 50.h,
                                                  //       width: 0.4.sw,
                                                  //       decoration: BoxDecoration(
                                                  //           borderRadius: BorderRadius.circular(10.sp),
                                                  //           border: Border.all(
                                                  //             color: Color.fromRGBO(170, 143, 10, 1),
                                                  //           )
                                                  //       ),
                                                  //       child: Center(child: Text(getTranslated(context, "Cancel")!)),
                                                  //     ),
                                                  //     onTap: (){
                                                  //       Navigator.pop(context);
                                                  //     },
                                                  //   ),
                                                  // ),
                                                ],
                                              )
                                          ),
                                        )
                                      );
                                    },
                                  ):Container(),
                                  ( reservationsList[position].status! != "cancel")?SizedBox(height: 50.h,):Container(),
                                  Icon(CupertinoIcons.forward)
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ReservationDetails(reservationsObject: reservationsList[position],)));

                        },
                      ),
                    );
                  },
                ):
                Center(
                  child: Text(getTranslated(context, "Sorry there is no reservations yet hurry up and reserve your event Now")!,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
    ),
    ));
  }
  void _onRefresh() async{
    setState(() {
      isLoading = true;
    });
    // monitor network fetch
    initawaits();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  @override
  bool get wantKeepAlive => true; // ** and here
  void loadData(){
    ReservationService.reservations(context).then((value){
      log(value.toString());
      setState(() {
        reservationsList = value!;
        isLoading = false;
      });
      log(reservationsList.length.toString());
    });
  }
}
