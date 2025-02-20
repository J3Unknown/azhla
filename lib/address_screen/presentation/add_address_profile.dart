import 'dart:developer';

import 'package:azhlha/profile_screen/presentation/profile_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/localization_helper.dart';
import '../data/cities_object.dart';
import '../domain/address_service.dart';

class AddAddressProfile extends StatefulWidget {
  const AddAddressProfile({Key? key}) : super(key: key);

  @override
  _AddAddressProfileState createState() => _AddAddressProfileState();
}

class _AddAddressProfileState extends State<AddAddressProfile> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  List<CitiesObject> cities = [];
  List<CitiesObject> regions = [];
  CitiesObject? selectedCity;
  CitiesObject? selectedRegion;
  TextEditingController blockController = TextEditingController();
  TextEditingController streetCotroller = TextEditingController();
  TextEditingController notesCotroller = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController buildingController = TextEditingController();

  @override
  void initState() {
    loadCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(CupertinoIcons.back),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          getTranslated(context, "Address")!,
          style: TextStyle(
              color: Color.fromRGBO(170, 143, 10, 1),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/Map.png"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Text(getTranslated(context, "Governance")!),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Container(
                height: 50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: Color.fromRGBO(170, 143, 10, 1))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<CitiesObject>(
                    isExpanded: true,
                    hint: Text(
                      getTranslated(context, "Governance")!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: cities
                        .map((CitiesObject item) => DropdownMenuItem<CitiesObject>(
                      value: item,
                      child: Text(
                        item.name!,
                        style:  TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ))
                        .toList(),
                    value: selectedCity,
                    onChanged: (CitiesObject? value) {
                      setState(() {
                        selectedCity = value;
                        selectedRegion = null;
                        loadRegions(selectedCity!.id!);
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Text(getTranslated(context, "City")!),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Container(
                height: 50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: Color.fromRGBO(170, 143, 10, 1))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<CitiesObject>(
                    isExpanded: true,
                    hint: Text(
                      getTranslated(context, "City")!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: regions
                        .map((CitiesObject item) => DropdownMenuItem<CitiesObject>(
                      value: item,
                      child: Text(
                        item.name!,
                        style:  TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ))
                        .toList(),
                    value: selectedRegion,
                    onChanged: (CitiesObject? value) {
                      setState(() {
                        selectedRegion = value;

                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Form(
                child:
                Column(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated(context, "Block")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                          SizedBox(height: 5.h,),
                          Container(
                            height: 50.h,
                            width: 0.9.sw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                    color: Color.fromRGBO(170, 143, 10, 1)
                                )
                            ),
                            child: TextFormField(
                                controller: blockController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: getTranslated(context, "Block")!,
                                  contentPadding: EdgeInsets.all(5.w),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated(context, "Street")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                          SizedBox(height: 5.h,),
                          Container(
                            height: 50.h,
                            width: 0.9.sw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                    color: Color.fromRGBO(170, 143, 10, 1)
                                )
                            ),
                            child: TextFormField(
                                controller: streetCotroller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: getTranslated(context, "Street")!,
                                  contentPadding: EdgeInsets.all(5.w),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated(context, "Building")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                              SizedBox(height: 5.h,),
                              Container(
                                height: 50.h,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(
                                        color: Color.fromRGBO(170, 143, 10, 1)
                                    )
                                ),
                                child: TextFormField(
                                    controller: buildingController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getTranslated(context, "Building")!,
                                      contentPadding: EdgeInsets.all(5.w),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 40.w,),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated(context, "Floor")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                              SizedBox(height: 5.h,),
                              Container(
                                height: 50.h,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(
                                        color: Color.fromRGBO(170, 143, 10, 1)
                                    )
                                ),
                                child: TextFormField(
                                    controller: floorController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getTranslated(context, "Floor")!,
                                      contentPadding: EdgeInsets.all(5.w),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated(context, "Special Mark")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                          SizedBox(height: 5.h,),
                          Container(
                            height: 50.h,
                            width: 0.9.sw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                    color: Color.fromRGBO(170, 143, 10, 1)
                                )
                            ),
                            child: TextFormField(
                                controller: notesCotroller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: getTranslated(context, "Special Mark")!,
                                  contentPadding: EdgeInsets.all(5.w),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20.h),
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
                  child: Center(child: Text(getTranslated(context, "Submit")!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                ),
                onTap: (){
                  AddressService.addAdrees(context,selectedRegion!.id.toString(),floorController.text,streetCotroller.text,blockController.text,buildingController.text,notesCotroller.text).then((value){
                    log(value.toString());
                    setState(() {
                      if(value == true){
                        //showToast(context,"done");
                        // loadData();
                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>AddressScreen(dateTime: widget.delivery_time, total_price: widget.total_price,)));
                        //Navigator.pop(context);
                        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>ProfileScreen()));

                      }
                    });
                    //log(basket.length.toString());
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>PaymentScreen(address_id: id,delivery_time: widget.dateTime, total_price: widget.total_price,)));

                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
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
  void loadRegions(int id) {
    AddressService.getRegions(context,id).then((value) {
      log(value.toString());
      setState(() {
        regions = value!;
      });
      log(regions.length.toString());
    });
  }
}

