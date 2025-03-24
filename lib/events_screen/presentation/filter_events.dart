import 'dart:developer';

import 'package:azhlha/events_screen/domain/events_service.dart';
import 'package:azhlha/events_screen/presentation/events_screen.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../address_screen/data/cities_object.dart';
import '../../address_screen/domain/address_service.dart';
import '../../utill/localization_helper.dart';
import '../data/famillies_object.dart';

class FilterEvents extends StatefulWidget {
  const FilterEvents({Key? key}) : super(key: key);

  @override
  _FilterEventsState createState() => _FilterEventsState();
}

class _FilterEventsState extends State<FilterEvents> {
  List<CitiesObject> cities = [];
  List<CitiesObject> regions = [];
  CitiesObject? selectedRegion;
  CitiesObject? selectedCity;
  List<FamiliesObject> families = [];
  FamiliesObject? selectedFamily;
  String? selectedValue;
  List<String> items = [
  ];
  String dateSelected = 'select Date';
  @override
  void initState() {
    loadFamilies();
    loadCities();
    iniAwaits();
    // TODO: implement initState
    super.initState();
  }
  void iniAwaits() async{
    Locale locale = await getLocale();
    log(locale.toString());
    if(locale.languageCode == 'ar'){
      setState(() {
        items = ["للأثنين","للرجال","للنساء"];

      });
    }else{
      setState(() {
        items = ["Both","For Men","For Women"];

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 0.8.sw,
      decoration: BoxDecoration(

      ),
      child: AlertDialog(
          scrollable: true,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, "Governance")!),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  height: 35.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: ColorsManager.primary
                      )
                  ),
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
                          item.name.toString(),
                          style:  TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedCity,
                      onChanged: (CitiesObject? value) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        setState(() {
                          selectedCity = value;
                          selectedRegion = null;
                          loadRegions();
                          prefs.setInt("selectedCity", selectedCity!.id!);
                          log(selectedCity!.name!);
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
              SizedBox(height: 10.h,),
              // Text(getTranslated(context, "Area")!),
              // SizedBox(height: 10.h,),
              // Center(
              //   child: Container(
              //     height: 35.h,
              //     width: 0.8.sw,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10.sp),
              //         border: Border.all(
              //             color: Color.fromRGBO(170, 143, 10, 1)
              //         )
              //     ),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton2<CitiesObject>(
              //         isExpanded: true,
              //         hint: Text(
              //           getTranslated(context, "All Areas")!,
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: Theme.of(context).hintColor,
              //           ),
              //         ),
              //         items: regions
              //             .map((CitiesObject item) => DropdownMenuItem<CitiesObject>(
              //           value: item,
              //           child: Text(
              //             item.name.toString(),
              //             style: const TextStyle(
              //               fontSize: 14,
              //             ),
              //           ),
              //         ))
              //             .toList(),
              //         value: selectedRegion,
              //         onChanged: (CitiesObject? value) async{
              //           SharedPreferences prefs = await SharedPreferences.getInstance();
              //
              //           setState(() {
              //             selectedRegion = value;
              //             // selectedCity = value;
              //             // selectedRegion = null;
              //             // loadRegions(selectedCity!.id!);
              //             prefs.setInt("selectedCity", selectedRegion!.id!);
              //             log(selectedCity!.name!);
              //           });
              //         },
              //         buttonStyleData: const ButtonStyleData(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           height: 40,
              //           width: 140,
              //         ),
              //         menuItemStyleData: const MenuItemStyleData(
              //           height: 40,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10.h,),
              Text(getTranslated(context, "Family Name")!),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  height: 35.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: ColorsManager.primary
                      )
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<FamiliesObject>(
                      isExpanded: true,
                      hint: Text(
                        getTranslated(context, "All Families")!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: families
                          .map((FamiliesObject item) => DropdownMenuItem<FamiliesObject>(
                        value: item,
                        child: Text(
                          item.familyName.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedFamily,
                      onChanged: (FamiliesObject? value) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        setState(() {
                          selectedFamily = value!;
                          prefs.setString("selectedFamily", selectedFamily!.familyName!);
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
              SizedBox(height: 10.h,),
              Text(getTranslated(context, "Gender")!),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  height: 35.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: ColorsManager.primary
                      )
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        getTranslated(context, "Gender")!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        setState(() {
                          selectedValue = value; // Assign directly from the dropdown menu items
                          if (selectedValue == KeysManager.forWomen || selectedValue == "للنساء") {
                            prefs.setString("selectedValue", KeysManager.female);
                          } else if (selectedValue == "Both" || selectedValue == "للأثنين") {
                            prefs.setString("selectedValue", 'both');
                          } else {
                            prefs.setString("selectedValue", KeysManager.male);
                          }
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
              SizedBox(height: 10.h,),
              SizedBox(height: 10.h,),
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
                    child: Center(child: Text(getTranslated(context, KeysManager.next)!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EventsScreen()));

                  },
                ),
              ),
              SizedBox(height: 10.h,),
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
                    child: Center(child: Text( getTranslated(context, KeysManager.cancel)!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
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
  void loadRegions() {
    AddressService.getRegions(context).then((value) {
      log(value.toString());
      setState(() {
        regions = value!;
      });
      log(regions.length.toString());
    });
  }
  void loadFamilies() {
    EventsService.getFamilies(context).then((value) {
      log(value.toString());
      setState(() {
        families = value!;
      });
      log(families.length.toString());
    });
  }
}
