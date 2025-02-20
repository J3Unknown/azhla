import 'dart:developer';

import 'package:azhlha/address_screen/presentation/add_address.dart';
import 'package:azhlha/payment_screen/presentation/payment_screen.dart';
import 'package:azhlha/profile_screen/data/profile_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../profile_screen/domain/profile_service.dart';
import '../../utill/localization_helper.dart';

class AddressScreen extends StatefulWidget {
  late String total_price;
  late String order_id;
   AddressScreen({Key? key,required this.total_price,required this.order_id}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}


class _AddressScreenState extends State<AddressScreen> {
  int _radioValue = 0; //Initial definition of radio button value
  String choice = '';
  List<Address> address=[];
  String name ='';
  String phone ='';
  String id = '';
  @override
  void initState() {

    getProfileDate();
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
        title:  Text(getTranslated(context, "Address")!,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Center(child: Text(getTranslated(context, "Select Delivery Address")!,style: TextStyle(fontSize: 20.sp),)),
          SizedBox(height: 10.h,),
          Center(
            child: InkWell(
              child: Container(
                height: 50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                    color: Color.fromRGBO(193, 193, 193, 1)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.plus),
                    SizedBox(width: 5.h,),
                    Text(getTranslated(context, "Add New Address")!,style: TextStyle(fontSize: 20.sp),)
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>AddAddress(total_price: widget.total_price,order_id: widget.order_id,)));

              },
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 0.5.sh,
            width: 0.9.sw,
            child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: address.length,
            itemBuilder: (context, position) {

              return Padding(
                padding:  EdgeInsets.only(top: 15.h),
                child: Container(
                  height: 200.h,
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(
                      color: Color.fromRGBO(170, 143, 10, 1)
                    )
                  ),
                  child: Row(

                    children: <Widget>[

                      Container(
                          height: 150.h,
                          width: 250.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined,size: 20.sp,),
                                  SizedBox(width: 5.w,),
                                  Text("Address ${position+1}",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  SizedBox(width: 10.w,),
                                  Text(name,style: TextStyle(color: Colors.black87,fontSize: 20.sp),),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  SizedBox(width: 10.w,),
                                  Text(phone,style: TextStyle(color: Colors.black87,fontSize: 20.sp),),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  SizedBox(width: 10.w,),
                                  Text((address[position].floorNo == null||address[position].floorNo!.isEmpty )?"":(address[position].floorNo!+" - "+address[position].buildingNo!),style: TextStyle(fontSize: 20.sp,color: Colors.grey),),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10.w,),
                                  Text((address[position].blockNo!+" - "+address[position].region!.name!),style: TextStyle(fontSize: 20.sp,color: Colors.grey),),
                                ],
                              ),
                            ],
                          )),

                      SizedBox(width: 50.w,),
                      Transform.scale(
                    scale: 1.5,
                     child: Radio(
                        activeColor: Color.fromRGBO(170, 143, 10, 1),
                        value: position,
                        groupValue: _radioValue,
                          onChanged: (value){
                          setState(() {
                            _radioValue = value!;
                            id =address[position].id.toString();
                            log(id);
                          });

                          },
                      )),

                    ],
                  ),
                ),
              );
              }
            ),

          ),
          SizedBox(height: 40.h,),
          Center(
            child: InkWell(
              child: Container(
                height: 50.h,
                width: 0.8.sw,
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
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>PaymentScreen(address_id: id ,total_price: widget.total_price,order_id: widget.order_id,)));

              },
            ),
          ),
          SizedBox(height: 30.h,),
        ],
      ),
    );
  }
  void getProfileDate(){
    ProfileService.profile().then((data) {
      if(data == null){

      }
      else{
        setState(() {
          id = data.address![0].id.toString();
          address = data.address!;
          name = data.name!;
          phone = data.phone!;
        });

      }
    });
  }
}
