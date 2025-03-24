import 'dart:developer';
import 'dart:io';

import 'package:azhlha/events_screen/presentation/add_event_gender.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../address_screen/data/cities_object.dart';
import '../../address_screen/domain/address_service.dart';
import '../../shared/validations.dart';
import '../../utill/icons_manager.dart';
import '../../utill/localization_helper.dart';
import '../data/events_object.dart';
import '../data/famillies_object.dart';
import '../domain/events_service.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  String? selectedCategory;
  FamiliesObject? selectedFamily;
  EventsObject? selectedEvent;
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay.now();
  List<FamiliesObject> families = [];
  List<EventsObject> events = [];
  bool men = false;
  bool women = false;
  bool show = false;
  bool showImage = false;
  var personalPhoto;
  String image = '';
  String photopath = '';
  List<CitiesObject> regions = [];
  CitiesObject? selectedRegion;
  final ImagePicker picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool areaRequired = false;
  bool temp = true;

  @override
  void initState() {
    loadFamilies();
    loadEvents();
    loadRegions();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(IconsManager.backButtonIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          getTranslated(context, KeysManager.addEvent)!,
          style: TextStyle(
              color: ColorsManager.primary,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Form(
            key: formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: ColorsManager.white,
                              image: DecorationImage(
                                  image: (show == false)
                                      ? AssetImage(imagePath+AssetsManager.gallery)
                                      : FileImage(personalPhoto) as ImageProvider,
                                  fit: BoxFit.contain)),
                        ),
                        (showImage)?Center(
                          child: Text(getTranslated(context, KeysManager.requiredFieldMessage)!,style: TextStyle(color: ColorsManager.red),),
                        ):Container()
                      ],
                    ),
                  ),
                  onTap: () {
                    getFile();
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(getTranslated(context, KeysManager.title)!),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 60.h,
                  width: 0.98.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border:
                          Border.all(color: ColorsManager.primary)),
                  child: Center(
                    child: TextFormField(
                      validator: RequiredValidator(
                          errorText:
                              getTranslated(context, KeysManager.requiredFieldMessage)!),
                      controller: titleController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: getTranslated(context, KeysManager.title)!,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                        border:
                            Border.all(color: ColorsManager.primary)),
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
                        items: events
                            .map((EventsObject item) =>
                                DropdownMenuItem<EventsObject>(
                                  value: item,
                                  child: Text(
                                    item.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedEvent,
                        onChanged: (EventsObject? value) async {
                          //SharedPreferences prefs = await SharedPreferences.getInstance();

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
                SizedBox(height: 10),
                Text(getTranslated(context, KeysManager.familyName)!),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 60.h,
                  width: 0.98.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border:
                          Border.all(color: ColorsManager.primary)),
                  child: Center(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: RequiredValidator(
                          errorText:
                              getTranslated(context, KeysManager.requiredFieldMessage)!),
                      controller: familyNameController,
                      decoration: InputDecoration(
                          hintText: getTranslated(context, KeysManager.familyName)!,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, KeysManager.governance)!),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Container(
                    height: 60.h,
                    width: 0.98.sw,
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
                        items: regions
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
                        value: selectedRegion,
                        onChanged: (CitiesObject? value) async {

                          setState(() {
                            selectedRegion = value;
                            // prefs.setInt("selectedCity", selectedCity!.id!);
                            // log(selectedCity!.name!);
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
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, KeysManager.date)!),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 60.h,
                  width: 0.98.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: ColorsManager.primary)),
                  child: GestureDetector(
                    child: AbsorbPointer(
                      child: Center(
                        child: TextFormField(
                          validator: RequiredValidator(errorText: getTranslated(context, KeysManager.requiredFieldMessage)!),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: getTranslated(context, KeysManager.date),
                            //labelText: "Date",
                            suffixIcon:  Icon(Icons.calendar_today),

                          ),
                          readOnly: true,
                          controller: TextEditingController(
                              text: "   ${"${selectedDate.toLocal()}".split(StringsManager.space)[0]}"),
                        ),
                      ),
                    ),
                    onTap: () async{
                      log("3l2");
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
                ),
                SizedBox(height: 10),
                Text(getTranslated(context, KeysManager.time)!),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 60.h,
                  width: 0.98.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border:
                          Border.all(color: ColorsManager.primary)),
                  child: GestureDetector(
                    child: AbsorbPointer(
                      child: Center(
                        child: TextFormField(
                          validator: RequiredValidator(
                              errorText:
                                  getTranslated(context, KeysManager.requiredFieldMessage)!),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: getTranslated(context, KeysManager.time)!,
                            suffixIcon: Icon(IconsManager.accessTimeIcon),


                          ),
                          readOnly: true,
                          controller: TextEditingController(
                              text: "   ${selectedTime.format(context)}"),
                        ),
                      ),
                    ),
                    onTap: () async{
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (pickedTime != null && pickedTime != selectedTime) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, KeysManager.description)!),
                const SizedBox(height: 10),
                Container(
                  height: 100.h,
                  width: 0.98.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border:
                          Border.all(color: ColorsManager.primary)),
                  child: TextFormField(
                    controller: descriptionController,
                    textAlign: TextAlign.center,
                    validator: RequiredValidator(
                        errorText:
                            getTranslated(context, KeysManager.requiredFieldMessage)!),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: getTranslated(context, KeysManager.description)!,
                    ),
                    maxLines: 5,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      log(areaRequired.toString());
                      log(showImage.toString());
                      log(formGlobalKey.currentState!.validate().toString());
                      if (!formGlobalKey.currentState!.validate() ||
                          !areaRequired || !show ) {
                        log("${KeysManager.showImage} : $showImage");
                        setState(() {
                          if(showImage || !show){
                            showImage = true;

                          }
                          if(!areaRequired ) {
                            temp = false;
                          }
                        });
                        log("area true");
                        return;
                      }
                      String date =selectedDate.year.toString()+StringsManager.dash+selectedDate.month.toString()+StringsManager.dash+selectedDate.day.toString();
                      String time = selectedTime.hour.toString()+StringsManager.colon+selectedTime.minute.toString();
                      log(date);
                      log(time);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddEventGender(
                            imgPath: photopath,
                            title: titleController.text,
                            category: selectedEvent!.id.toString(),
                            familyName: familyNameController.text,
                            area: selectedRegion!.id.toString(),
                            date: date.toString(),
                            time: time.toString(),
                            description: descriptionController.text,
                          )
                        )
                      );
                    },
                    child: Text(getTranslated(context, KeysManager.next)!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.3, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
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

  Future<void> getFile() async {
    // ignore: deprecated_member_use
    await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 480,
      imageQuality: 75,
    ).then((result) {
      if (result != null) {
        setState(() {
          showImage = false;
          show = true;
          personalPhoto = File(result.path);
          photopath = result.path;
        });
      }
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
    EventsService.getEvents(context).then((value) {
      log(value.toString());
      setState(() {
        events = value!;
      });
      log(events.length.toString());
    });
  }
}
