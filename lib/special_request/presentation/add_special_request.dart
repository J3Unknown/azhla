import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:azhlha/special_request/domain/special_request_list_services.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../address_screen/data/cities_object.dart';
import '../../address_screen/domain/address_service.dart';
import '../../events_screen/data/events_object.dart';
import '../../events_screen/data/famillies_object.dart';
import '../../events_screen/domain/events_service.dart';
import '../../shared/validations.dart';
import '../../utill/assets_manager.dart';
import '../../utill/icons_manager.dart';

class AddSpecialRequest extends StatefulWidget {
  AddSpecialRequest({super.key});

  @override
  State<AddSpecialRequest> createState() => _AddSpecialRequestState();
}

class _AddSpecialRequestState extends State<AddSpecialRequest> {
  final TextEditingController _budgetController = TextEditingController();
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  final TextEditingController _timeController = TextEditingController(text: DateFormat('HH:mm').format(DateTime.now()).toString());
  final TextEditingController _descriptionController = TextEditingController();

  CitiesObject? selectedCity;
  EventsObject? selectedEvent;
  FamiliesObject? selectedFamily;
  CitiesObject? selectedRegion;
  List<FamiliesObject> families = [];
  List<CitiesObject> cities = [];
  List<EventsObject> events = [];
  List<CitiesObject> regions = [];
  @override

  void initState() {
    loadFamilies();
    loadCities();
    loadEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsManager.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsManager.backButtonIcon),
        ),
        title: Text(getTranslated(context, KeysManager.specialRequest)!, style: const TextStyle(color: ColorsManager.primary),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, KeysManager.governance)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  height: 50.h,
                  width: 0.9.sw,
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
                        getTranslated(context, KeysManager.governance)!,
                        style: TextStyle(
                          //fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: cities.map((CitiesObject item) => DropdownMenuItem<CitiesObject>(
                        value: item,
                        child: Text(
                          item.name.toString(),
                          style:  TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      )).toList(),
                      value: selectedCity,
                      onChanged: (CitiesObject? value) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        setState(() {
                          selectedCity = value;
                          selectedRegion = null;
                          loadRegions(selectedCity!.id!);
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
              SizedBox(height: 20.h,),
              Text(getTranslated(context, KeysManager.familyName)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  height: 50.h,
                  width: 0.9.sw,
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
                        getTranslated(context, KeysManager.allFamilies)!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: families.map((FamiliesObject item) => DropdownMenuItem<FamiliesObject>(
                        value: item,
                        child: Text(
                          item.familyName.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                      value: selectedFamily,
                      onChanged: (FamiliesObject? value) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        setState(() {
                          selectedFamily = value!;
                          prefs.setString(KeysManager.selectedFamily, selectedFamily!.familyName!);
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
              SizedBox(height: 20.h,),
              Text(getTranslated(context, KeysManager.area)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  height: 50.h,
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: ColorsManager.primary)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<CitiesObject>(
                      isExpanded: true,
                      hint: Text(
                        getTranslated(context, KeysManager.allAreas)!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: regions.map((CitiesObject item) => DropdownMenuItem<CitiesObject>(
                        value: item,
                        child: Text(
                          item.name.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                      value: selectedRegion,
                      onChanged: (CitiesObject? value) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        setState(() {
                          selectedRegion = value!;
                          prefs.setString(KeysManager.selectedArea, selectedRegion!.name!);
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
              SizedBox(height: 20.h,),
              Text(getTranslated(context, KeysManager.categories)!),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Container(
                  height: 60.h,
                  width: 0.98.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: ColorsManager.primary)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<EventsObject>(
                      isExpanded: true,
                      hint: Text(
                        getTranslated(context, KeysManager.categories)!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: events.map((EventsObject item) =>
                        DropdownMenuItem<EventsObject>(
                          value: item,
                          child: Text(
                            item.name.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
                      value: selectedEvent,
                      onChanged: (EventsObject? value) async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                        setState(() {
                          selectedEvent = value!;
                          //prefs.setString("selectedFamily", selectedFamily!.familyName!);
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
              Text(getTranslated(context, KeysManager.expectedBudget)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              TextFormField(
                controller: _budgetController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorsManager.primary),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorsManager.primary)
                  ),
                  hintText: getTranslated(context, KeysManager.typeHere)!,
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: ColorsManager.black),
                cursorHeight: 30.h,
                cursorColor: ColorsManager.primary,
              ),
              SizedBox(height: 20.h,),
              Text(getTranslated(context, KeysManager.date)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              GestureDetector(
                child: AbsorbPointer(
                  child: Center(
                    child: TextFormField(
                      validator: RequiredValidator(errorText: getTranslated(context, KeysManager.requiredFieldMessage)!),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorsManager.primary),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: getTranslated(context, KeysManager.date),
                        //labelText: "Date",
                        suffixIcon:  Icon(IconsManager.calenderIcon),
                      ),
                      readOnly: true,
                      controller: TextEditingController(text: "   ${"${selectedDate.toLocal()}".split(StringsManager.space)[0]}"),
                    ),
                  ),
                ),
                onTap: () async{
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != selectedDate)
                    setState(() {
                      selectedDate = pickedDate;
                    });
                },
              ),
              SizedBox(height: 20.h,),
              Text(getTranslated(context, KeysManager.time)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              GestureDetector(
                child: AbsorbPointer(
                  child: Center(
                    child: TextFormField(
                      validator: RequiredValidator(
                          errorText:
                          getTranslated(context, KeysManager.requiredFieldMessage)!),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorsManager.primary),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: getTranslated(context, KeysManager.time)!,
                        suffixIcon: const Icon(IconsManager.accessTimeIcon),


                      ),
                      readOnly: true,
                      controller: _timeController,
                    ),
                  ),
                ),
                onTap: () async{
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        _timeController.text = value.format(context).toString();
                        log(_timeController.text);
                      });
                    }
                  });
                },
              ),
              SizedBox(height: 20.h,),
              Text(getTranslated(context, KeysManager.description)!, style: const TextStyle(color: ColorsManager.grey1),),
              SizedBox(height: 10.h,),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorsManager.primary),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  hintText: getTranslated(context, KeysManager.typeHere)!,
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ColorsManager.primary)
                  ),
                ),
                style: const TextStyle(color: ColorsManager.black),
                cursorHeight: 30.h,
                cursorColor: ColorsManager.primary,
              ),
              SizedBox(height: 35.h,),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primary,
                    foregroundColor: ColorsManager.white,
                    padding: EdgeInsets.symmetric(horizontal: 0.17.sw, vertical: 0.02.sh),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  onPressed: () {
                    log(_timeController.text);
                    SpecialRequestListServices.sendSpecialRequest(
                      context,
                      categoryId: selectedEvent!.id!,
                      areaId: selectedRegion!.id!,
                      familyName: selectedFamily!.familyName!,
                      budget: int.parse(_budgetController.text),
                      date: selectedDate.toString(),
                      time: _timeController.text.substring(0,5),
                      description: _descriptionController.text,
                    );
                  },
                  child: Text(getTranslated(context, KeysManager.confirm)!)
                ),
              ),
            ],
          ),
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
  void loadFamilies() {
    EventsService.getFamilies(context).then((value) {
      log(value.toString());
      setState(() {
        families = value!;
      });
      log(families.length.toString());
    });
  }
  void loadEvents() {
    EventsService.getMainEventsCategories(context).then((value) {
      log(value.toString());
      setState(() {
        events = value!;
      });
      log(events.length.toString());
    });
  }
}
