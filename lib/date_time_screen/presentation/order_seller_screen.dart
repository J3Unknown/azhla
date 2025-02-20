import 'dart:developer';

import 'package:azhlha/date_time_screen/presentation/date_screen.dart';
import 'package:azhlha/date_time_screen/presentation/seller_date_screen.dart';
import 'package:azhlha/date_time_screen/presentation/time_screen.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/icons_manager.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../address_screen/data/cities_object.dart';
import '../../address_screen/domain/address_service.dart';
import '../../address_screen/presentation/address_screen.dart';
import '../../categories_screen/presentation/categories_screen.dart';
import '../../home_screen/data/home_object.dart';
import '../../home_screen/domain/home_service.dart';
import '../../stores_screen/presentation/stores_screen.dart';
import '../../utill/localization_helper.dart';

class OrderSellerScreen extends StatefulWidget {
  late String catName;
  late List<Children> children;
  OrderSellerScreen({Key? key,required this.catName,required this.children}) : super(key: key);

  @override
  _OrderSellerScreenState createState() => _OrderSellerScreenState();
}

class _OrderSellerScreenState extends State<OrderSellerScreen> {
  DateTime focusedDaySelected = DateTime.now();
  List<CitiesObject> cities = [];
  DateTime dateTime = DateTime.now();
  late String date = focusedDaySelected.year.toString()+"-"+focusedDaySelected.month.toString()+"-"+focusedDaySelected.day.toString();
  late String finalTime;
  CitiesObject? selectedCity;
  HomeObject homeObject = HomeObject();

  @override
  void initState() {
    loadCities();
    initAwaits();
    // TODO: implement initState
    super.initState();
  }
  void initAwaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("OrderDate")){
      prefs.remove("OrderDate");
    }
    // date = prefs.getString("OrderDate")!;
    // finalTime = prefs.getString("Time")!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        leading: InkWell(child: const Icon(IconsManager.backButtonIcon),onTap: (){Navigator.pop(context);},),
        title:  Text(getTranslated(context, '${KeysManager.date} ${StringsManager.dash} ${KeysManager.time}')!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h,),
            Center(child: Text(getTranslated(context, KeysManager.selectDateMessage)!,style: TextStyle(color: ColorsManager.deepBlue,fontSize: 18.sp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 30.h,),
            SizedBox(
              height:30.h,
              width: 0.9.sw,
              child: Text(getTranslated(context, KeysManager.date)!,style: TextStyle(color: ColorsManager.grey1,fontSize: 20.sp),)
            ),
            SizedBox(height: 10.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: ColorsManager.white,
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(date),
                      SizedBox(width: 0.55.sw,),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imagePath + AssetsManager.calender),
                                fit: BoxFit.contain
                            )
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()async{
                  await showDialog<void>(
                      context: context,
                      builder: (context) => SellerDateScreen(
                        onDateSelected: updateDate, // Pass the callback here
                      )
                  );
                },
              ),
            ),
            SizedBox(height: 30.h,),
            SizedBox(
              height:30.h,
              width: 0.9.sw,
              child: Text(getTranslated(context, KeysManager.location)!,style: TextStyle(color: ColorsManager.grey1,fontSize: 20.sp),)
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Container(
                height:50.h,
                width: 0.9.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border:
                    Border.all(color: ColorsManager.primary)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<CitiesObject>(
                    isExpanded: true,
                    hint: Text(
                      getTranslated(context, KeysManager.governance)!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: cities
                        .map((CitiesObject item) =>
                        DropdownMenuItem<CitiesObject>(
                          value: item,
                          child: Text(
                            item.name.toString(),
                            style:  TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedCity,
                    onChanged: (CitiesObject? value) async {

                      setState(() {
                        selectedCity = value;
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
            SizedBox(height: 250.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      color: ColorsManager.primary,
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Text(getTranslated(context, KeysManager.next)!,style: TextStyle(fontSize: 20.sp,color: ColorsManager.white),)),
                ),
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if(prefs.containsKey(KeysManager.orderDate)){
                  date = prefs.getString(KeysManager.orderDate)!;}
                  else{
                    date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                  }
                  log(date);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CategoriesScreen(children: widget.children!,govId: (selectedCity == null || selectedCity?.id == 0)?null:selectedCity!.id.toString(),catName: widget.catName,)));

                },
              ),
            ),
            SizedBox(height: 30.h,)
          ],
        ),
      ),
    );
  }

  void loadCities() async{
    Locale locale = await getLocale();
    AddressService.getCities(context).then((value) {
      log(value.toString());
      setState(() {
        cities = [
          CitiesObject(id: 0, name: (locale.languageCode == KeysManager.en)?KeysManager.all:KeysManager.allAr), // Add the desired entry at the start
          ...value!,
        ];
      });
      log(cities.length.toString());
    });
  }

  void updateDate(String newDate) {
    setState(() {
      date = newDate;
    });
  }

  void setDate(String date){
    this.date = date;
  }
}
