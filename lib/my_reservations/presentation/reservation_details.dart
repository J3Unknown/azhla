import 'dart:developer';

import 'package:azhlha/utill/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../buttom_nav_bar/presentation/buttom_nav_screen.dart';
import '../../favourite_screen/presentation/favorite_screen.dart';
import '../../product_screen/presentation/product_screen.dart';
import '../../utill/app_constants.dart';
import '../../utill/localization_helper.dart';
import '../data/reservations_object.dart';
import '../domain/reservations_service.dart';

class ReservationDetails extends StatefulWidget {
  late ReservationsObject reservationsObject;
  ReservationDetails({Key? key,required this.reservationsObject}) : super(key: key);

  @override
  _ReservationDetailsState createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  TextEditingController cancellationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
         leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){
           Navigator.pop(context);
         },),
        title:  Text(
          getTranslated(context, "Order No")!+widget.reservationsObject.orderNumber.toString(),
          style: TextStyle(color: ColorsManager.primary, fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          (widget.reservationsObject.status != 'cancel')?InkWell(
            child: Padding(
              padding:  EdgeInsets.only(top: 10.h,bottom: 10.h),
              child: Container(
                  height: 30.h,
                  width:30.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child:
                  Center(child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.white,size: 20.sp,),)
              ),
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
                                      ReservationService.cancelOrders(context,widget.reservationsObject.id.toString(),cancellationController.text).then((value){
                                        log(value.toString());
                                        setState(() {
                                          if(value == true){
                                            Navigator.of(context, rootNavigator: true).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (BuildContext context) => ButtomNavBarScreen(intial: 1)));
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
          SizedBox(width: 10.w,)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10.w,),
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.reservationsObject.seller!.imgPath!),
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
                      getTranslated(context, "Order No")!+widget.reservationsObject.orderNumber.toString(),
                      style: TextStyle(fontSize: 18.0,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h,),
                    Text(
                      getTranslated(context, "Date")!+ widget.reservationsObject.updatedAt.toString(),
                      style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(13, 24, 99, 1),),
                    ),
                    SizedBox(height: 5.h,),
                    Text(
                      getTranslated(context, "From")!+ widget.reservationsObject.seller!.name!,
                      style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(13, 24, 99, 1),),
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      children: [
                        Text(getTranslated(context, "Order Status")!+" ",style: TextStyle(fontSize: 15.0,color: (widget.reservationsObject.status! != "cancel")?Color.fromRGBO(13, 24, 99, 1):Colors.red,)),
                        Text(
                          (widget.reservationsObject.status! == "cancel")?getTranslated(context, "Canceled")!:(widget.reservationsObject.status! == "order_placed")?getTranslated(context, "order_placed")!:(widget.reservationsObject.status! == "out_for_delivery")?getTranslated(context, "out_for_delivery")!:(widget.reservationsObject.status! == "delivered")?getTranslated(context, "delivered")!:getTranslated(context, "Confirmed")!,
                          style: TextStyle(fontSize: 15.0,color: (widget.reservationsObject.status! != "cancel")?Color.fromRGBO(13, 24, 99, 1):Colors.red,),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(width: 30.w,),
            ],

          ),
          SizedBox(height: 30.h,),
          Container(
              height: 30.h,
              width: 0.9.sw,
              child: Text(getTranslated(context, "Order Details")!,style: TextStyle(color: Color.fromRGBO(13, 24, 99, 1),fontSize: 24.sp),)),
            Container(
              height: 0.5.sh,
              width: 1.sw,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:(widget.reservationsObject.orderDetails != null)?widget.reservationsObject.orderDetails!.length:0,
                itemBuilder: (context, position) {
                  return Padding(
                    padding:  EdgeInsets.all(20.sp),
                    child: InkWell(
                      child: Container(
                        width: 0.75.sw,
                        height: 120.h,
                        decoration: BoxDecoration(
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
                                  borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstants.MAIN_URL_IMAGE+ widget.reservationsObject.orderDetails![position].product!.mainImage!),
                                  )
                              ),
                            ),
                            SizedBox(width: 30.w,),
                            Container(
                              height: 90.h,
                              width: 0.5.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                              widget.reservationsObject.orderDetails![position].product!.name.toString(),
                                    style: TextStyle(fontSize: 24.sp,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.reservationsObject.orderDetails![position].product!.title.toString(),
                                    style: TextStyle(fontSize: 12.0,color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.reservationsObject.orderDetails![position]!.product!.price!+" KWD",
                                        style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(43, 190, 186, 1),fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 30.w,),
                                      Padding(
                                        padding:  EdgeInsets.only(top: 10.h),
                                        child: Stack(
                                          children: [
                                            Text(
                                              widget.reservationsObject.orderDetails![position]!.product!.oldPrice!+" KWD",
                                              style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(224 , 100, 78, 1),fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 30,
                                              //color: Colors.yellow,
                                              child: CustomPaint(painter: LinePainter()),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: 20.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // InkWell(child: Icon(CupertinoIcons.heart)),
                                // SizedBox(height: 50.h,),
                                Container(
                                    height: 25.h,
                                    width:25.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.sp),
                                      boxShadow:[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child:
                                    Center(child: Icon(CupertinoIcons.forward,color: Colors.black87,size: 25.sp,))
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w,),
                            // InkWell(
                            //   child: Container(
                            //     height: 30.h,
                            //     width: 30.w,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: AssetImage("assets/image/basket.png"),
                            //         )
                            //     ),
                            //   ),
                            //   onTap: (){
                            //     setState(() {
                            //       isLoading = true;
                            //     });
                            //
                            //     BasketService.deleteFromBasket(context,basket[0].orderDetails![position]!.id.toString()).then((value){
                            //       log(value.toString());
                            //       setState(() {
                            //         if(value == true){
                            //           loadData();
                            //
                            //         }
                            //       });
                            //       log(basket.length.toString());
                            //     });
                            //   },
                            // )
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductScreen(Id: widget.reservationsObject.orderDetails![position].product!.id!,catName: getTranslated(context,"Maras")!,)));

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
}
