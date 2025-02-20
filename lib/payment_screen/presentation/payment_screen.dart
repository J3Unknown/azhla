import 'dart:developer';

import 'package:azhlha/payment_screen/domain/payment_service.dart';
import 'package:azhlha/payment_screen/presentation/web_view_screen.dart';
import 'package:azhlha/shared/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../utill/localization_helper.dart';

class PaymentScreen extends StatefulWidget {
  late String address_id;
  late String total_price;
  late String order_id;
   PaymentScreen({Key? key,required this.address_id,required this.total_price,required this.order_id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _radioValue = 0;
  int _radioValuepay = 0;
  String amount = "10";
  bool isLoading = false;
  TextEditingController couponController = TextEditingController();
  final formGlobalKey = GlobalKey < FormState > ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
        title:  Text(getTranslated(context, "Payment")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: LoadingOverlay(
          progressIndicator: SpinKitSpinningLines(
            color: Color.fromRGBO(254, 222, 0, 1),
          ),
          color: Color.fromRGBO(254, 222, 0, 0.1),
          isLoading: isLoading,
          child: isLoading == true
              ? Container()

              : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    activeColor: Colors.white,
                    overlayColor: MaterialStateProperty.all(Colors.white),
                    fillColor: MaterialStateProperty.all(Colors.white),
                    focusColor: Colors.white,
                    value: 0,
                    groupValue: "",
                    onChanged: (value){
                      setState(() {

                      });
                    },
                  ),
                  // SizedBox(width: 35.w,),
                  Container(
                      height: 25.h,
                      width: 225.w,
                      child: Text(getTranslated(context, "Total Amount")!,style: TextStyle(fontWeight: FontWeight.bold),)),
                  // SizedBox(width: 200.w,),
                  Container(
                      height: 25.h,
                      width: 100.w,
                      child: Text("KWD ${widget.total_price}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),),

                ],
              ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  activeColor: Color.fromRGBO(170, 143, 10, 1),
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: (value){
                    setState(() {
                      amount = "10";
                      _radioValue = value!;
                    });
                  },
                ),
                Container(
                    height: 17.h,
                    width: 225.w,
                    child: Text(getTranslated(context, "Pay Minimum Amount")!,style: TextStyle(color:Color.fromRGBO(170, 143, 10, 1)),)),
                // SizedBox(width: 55.w,),
                Container(

                      height: 17.h,
                      width: 100.w,
                    child: Text( "(10 KWD)",style: TextStyle(color: Colors.red),)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  activeColor: Color.fromRGBO(170, 143, 10, 1),
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: (value){
                    setState(() {
                      amount = widget.total_price.toString();
                      log("total amount"+amount);
                      _radioValue = value!;
                    });

                  },
                ),
                Container(
                    height: 17.h,
                    width: 225.w,
                    child: Text(getTranslated(context, "Pay Full Amount")!,style: TextStyle(color:Color.fromRGBO(170, 143, 10, 1)),)),
                // SizedBox(width: 82.w,),
                Container(
                    height: 17.h,
                    width: 100.w,
                    child: Text( "(${widget.total_price} KWD)",style: TextStyle(color: Colors.red),)),
              ],
            ),
            SizedBox(height: 20.h,),
            Container(
                height: 20.h,
                width: 0.9.sw,
                child: Text(getTranslated(context, "Coupon Code")!,style: TextStyle(fontSize: 18.sp),)),
            SizedBox(height: 10.h,),
            Container(
              height: 50.h,
              width: 0.95.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                border: Border.all(color: Color.fromRGBO(193, 193, 193, 1),)
              ),
              child: Row(
                children: [
                  SizedBox(width:10.w),
                  Form(
                    key: formGlobalKey,
                    child: Container(
                      width:0.6.sw,
                      height: 70.h,
                      child: TextFormField(
                        controller: couponController,
                        textAlign: TextAlign.center,
                        validator: RequiredValidator(errorText: 'This field is required'),

                        decoration: InputDecoration(
                          contentPadding:(couponController.text.isNotEmpty)?EdgeInsets.only(top:30.sp):EdgeInsets.only(top:15.sp),

                          hintText: getTranslated(context,"Do You Have any Coupon Code?")!,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width:20.w),
                  Center(
                    child: InkWell(
                      child: Container(
                        height: 40.h,
                        width: 0.25.sw,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(170, 143, 10, 1),
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(
                              color: Color.fromRGBO(170, 143, 10, 1),
                            )
                        ),
                        child: Center(child: Text(getTranslated(context, "Next")!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                      ),
                      onTap: (){
                        if(!formGlobalKey.currentState!.validate())
                          return;
                        PaymentServcie.applyCopon(context,amount,couponController.text,).then((value){
                          log(value.toString());
                          setState(() {
                            if(value != null){
                              //showToast(context,"done");
                              // loadData();
                              amount = value.toString();
                            }
                          });
                          //log(basket.length.toString());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            Container(
                height: 20.h,
                width: 0.9.sw,
                child: Text(getTranslated(context, "Order Details")!,style: TextStyle(fontSize: 18.sp),)),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20.h,
                    width: 275.w,
                    child: Text(getTranslated(context, "Price")!,style: TextStyle(fontSize: 18.sp,color: Colors.grey),)),
                Container(
                    height: 20.h,
                    width: 75.w,
                    child: Text("$amount KWD",style: TextStyle(color: Colors.red),))
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20.h,
                    width: 275.w,
                    child: Text(getTranslated(context, "Shipping Charges")!,style: TextStyle(fontSize: 18.sp,color: Colors.grey),)),
                Container(
                    height: 20.h,
                    width: 75.w,
                    child: Text("1.5 KWD",style: TextStyle(color: Colors.red),))
              ],
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 1.h,
              width: 0.9.sw,
              color: Colors.grey,
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 25.h,
                    width: 230.w,
                    child: Text(getTranslated(context, "Bag Total")!,style: TextStyle(fontSize: 18.sp,color: Colors.grey),)),
                SizedBox(width: 30.w,),
                Container(
                    height: 20.h,
                    width: 110.w,
                    child: Text("KWD ${double.parse(amount.toString())+1.5}",style: TextStyle(color: Colors.red),))
              ],
            ),
            SizedBox(height: 40.h,),
            Container(
                height: 20.h,
                width: 0.9.sw,
                child: Text(getTranslated(context, "Payment")!,style: TextStyle(fontSize: 18.sp),)),
            SizedBox(height: 20.h,),
            InkWell(
              child: Container(
                height: 50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(
                        color: Color.fromRGBO(170, 143, 10, 1)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon(Icons.wallet,size: 35.sp,color: Colors.grey,),
                    SizedBox(width: 5.w,),
                    Container(
                        width: 300.w,
                        height: 25.h,

                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/image/credit.png"),
                                  )
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Text(getTranslated(context, "Credit")!,style: TextStyle(fontSize: 20.sp),),
                          ],
                        )),
                    // SizedBox(width: 200.w,),
                    Radio(
                      activeColor: Color.fromRGBO(170, 143, 10, 1),
                      value: 0,
                      groupValue: _radioValuepay,
                      onChanged: (value){


                      },
                    ),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  _radioValuepay = 0;
                });
              },
            ),
            SizedBox(height: 20.h,),
            InkWell(
              child: Container(
                height: 50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(
                        color: Color.fromRGBO(170, 143, 10, 1)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon(Icons.wallet,size: 35.sp,color: Colors.grey,),
                    SizedBox(width: 5.w,),
                    Container(
                        width: 300.w,
                        height: 25.h,
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/image/knet.png"),
                                )
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Text(getTranslated(context, "Knet")!,style: TextStyle(fontSize: 20.sp),),
                          ],
                        )),
                    // SizedBox(width: 215.w,),
                    Radio(
                      activeColor: Color.fromRGBO(170, 143, 10, 1),
                      value: 1,
                      groupValue: _radioValuepay,
                      onChanged: (value){
                        log(_radioValuepay.toString());
                        setState(() {
                          _radioValuepay = value!;
                        });

                      },
                    ),
                  ],
                ),
              ),
              onTap: (){
                setState(() {
                  _radioValuepay = 1;
                });
              },
            ),
            SizedBox(height: 15.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(170, 143, 10, 1),
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: Color.fromRGBO(170, 143, 10, 1),
                      )
                  ),
                  child: Center(child: Text( getTranslated(context, "Pay")!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                ),
                onTap: (){
                  setState(() {
                    isLoading = true;
                  });
                  log(widget.address_id);
                  PaymentServcie.getPaymentScreen(context,(_radioValuepay == 0)?"credit":"knet",widget.order_id,(amount == "10")?"0":"1" ).then((value){
                    log(value.toString());
                    setState(() {
                      // if(value == true){
                      setState(() {
                        isLoading = false;
                      });
                        log(value.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(url: value.toString(),address_id: widget.address_id,total_price: widget.total_price,type:(_radioValuepay == 0)?"credit":"knet"),
                          ),
                        );
                        //showToast(context,"done");
                        // loadData();
                      // }
                    });
                    //log(basket.length.toString());
                  });

                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DateTimeScreen(total_price: ((basket.isNotEmpty)?basket[0].totalPrice:0).toString(),)));
                  // PaymentServcie.confirmOrder(context,widget.address_id.toString(),"cash",widget.delivery_time).then((value){
                  //   log(value.toString());
                  //   setState(() {
                  //     if(value == true){
                  //       //showToast(context,"done");
                  //       // loadData();
                  //     }
                  //   });
                  //   //log(basket.length.toString());
                  // });
                },
              ),
            ),
            SizedBox(height: 30.h,),
          ],
        ),
      )),
    );
  }
}
