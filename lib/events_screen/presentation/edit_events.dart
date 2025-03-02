import 'dart:developer';
import 'dart:io';

import 'package:azhlha/events_screen/presentation/add_event_gender.dart';
import 'package:azhlha/events_screen/presentation/edit_event_gender.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../address_screen/data/cities_object.dart';
import '../../address_screen/domain/address_service.dart';
import '../../shared/validations.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';
import '../data/MyEventsDTO.dart';
import '../data/events_object.dart';
import '../data/famillies_object.dart';
import '../domain/events_service.dart';

class EditEventPage extends StatefulWidget {
  late UnderReview underReview;
  EditEventPage({Key? key,required this.underReview}) : super(key: key);
  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
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
  var personalPhoto;
  String image = '';
  String photopath = '';
  List<CitiesObject> cities = [];
  List<CitiesObject> regions = [];
  CitiesObject? selectedRegion;
  CitiesObject? selectedCity;
  final ImagePicker picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool areaRequired = false;
  bool temp = true;
  TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(":"); // Split the string by ":"
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
  @override
  void initState() {
    loadFamilies();
    loadEvents();
    loadCities();
    setState(() {
      titleController.text = widget.underReview.name.toString();

      familyNameController.text = widget.underReview.familyName.toString();
      selectedDate =DateTime.parse(widget.underReview.date.toString());
      TimeOfDay time = stringToTimeOfDay(widget.underReview.time.toString());
      selectedTime = time;
      descriptionController.text = widget.underReview.description.toString();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, "Add Event")!,
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
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(254, 254, 254, 1),
                          //borderRadius: BorderRadius.circular(50.sp),
                          // border: Border.all(
                          //     color: Color.fromRGBO(149, 156, 168, 1)
                          // ),
                          image: DecorationImage(
                              image: (show == false)
                                  ? NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.underReview.image.toString())
                                  : FileImage(personalPhoto) as ImageProvider,
                              fit: BoxFit.contain)),
                    ),
                  ),
                  onTap: () {
                    getFile();
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(getTranslated(context, "Title")!),
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
                  child: TextFormField(
                    validator: RequiredValidator(
                        errorText:
                        getTranslated(context, "This field is required")!),
                    controller: titleController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: getTranslated(context, "Title")!,
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, "Categories")!),
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
                          getTranslated(context, "Categories")!,
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
                                style:  TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ))
                            .toList(),
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
                SizedBox(height: 10),
                Text(getTranslated(context, "Family Name")!),
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
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    validator: RequiredValidator(
                        errorText:
                        getTranslated(context, "This field is required")!),
                    controller: familyNameController,
                    decoration: InputDecoration(
                        hintText: getTranslated(context, "Family Name")!,
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, "Governance")!),
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
                          getTranslated(context, "Governance")!,
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
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();

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
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, "Area")!),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: 0.98.sw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(
                                color: ColorsManager.primary)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<CitiesObject>(
                            isExpanded: true,
                            hint: Text(
                              getTranslated(context, "All Areas")!,
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
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                              setState(() {
                                areaRequired = true;
                                selectedRegion = value;
                                // selectedCity = value;
                                // selectedRegion = null;
                                // loadRegions(selectedCity!.id!);
                                prefs.setInt(
                                    "selectedCity", selectedRegion!.id!);
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
                      (!temp)
                          ? Text(
                        getTranslated(context, "This field is required")!,
                        style: TextStyle(color: Colors.red),
                      )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(height: 10),
                Text(getTranslated(context, "Date")!),
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
                          getTranslated(context, "This field is required")!),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: getTranslated(context, "Date"),
                        //labelText: "Date",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
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
                      readOnly: true,
                      controller: TextEditingController(
                          text: "   "+"${selectedDate.toLocal()}".split(' ')[0]),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(getTranslated(context, "Time")!),
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
                          getTranslated(context, "This field is required")!),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: getTranslated(context, "Time")!,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (pickedTime != null && pickedTime != selectedTime)
                              setState(() {
                                selectedTime = pickedTime;
                              });
                          },
                        ),
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                          text: "   "+"${selectedTime.format(context)}"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(getTranslated(context, "Description")!),
                SizedBox(height: 10),
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
                        getTranslated(context, "This field is required")!),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: getTranslated(context, "Description")!,
                    ),
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      log(areaRequired.toString());
                      log(formGlobalKey.currentState!.validate().toString());
                      if (!formGlobalKey.currentState!.validate() ||
                          !areaRequired) {
                        setState(() {
                          temp = false;
                        });
                        log("area true");
                        return;
                      }
                      String date =selectedDate.year.toString()+'-'+selectedDate.month.toString()+'-'+selectedDate.day.toString();
                      String time = selectedTime.hour.toString()+':'+selectedTime.minute.toString();
                      log(date);
                      log(time);
                      if(show == false){
                        setState(() {
                          photopath = AppConstants.MAIN_URL_IMAGE+widget.underReview.image.toString();
                        });
                      }
                      //selectedDate =
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => EditEventGender(
                                imgPath: photopath,
                                title: titleController.text,
                                category: selectedEvent!.id.toString(),
                                familyName: familyNameController.text,
                                area: selectedRegion!.id.toString(),
                                date: date.toString(),
                                time: time.toString(),
                                description: descriptionController.text,
                                underReview: widget.underReview!,
                              )));
                    },
                    child: Text(getTranslated(context, "Next")!),
                    style: ElevatedButton.styleFrom(
                      primary: ColorsManager.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.3, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 400.h),
              ],
            ),
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
    AddressService.getRegions(context, id).then((value) {
      log(value.toString());
      setState(() {
        regions = value!;
      });
      log(regions.length.toString());
    });
  }

  Future<void> getFile() async {
    // ignore: deprecated_member_use
    await picker
        .pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 480,
      imageQuality: 75,
    )
        .then((result) {
      if (result != null) {
        setState(() {
          show = true;
          personalPhoto = File(result.path);
          photopath = result.path;
        });
      }
    });
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
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
        events = value ?? [];

        // Check if the event exists in the loaded list
        selectedEvent = events.firstWhere(
              (event) => event.id == widget.underReview.eventCategory?.id,
          orElse: () => EventsObject(),
        );

        selectedEvent!.name = widget.underReview.eventCategory?.name;
        selectedEvent!.image = widget.underReview.eventCategory?.image;

        log(selectedEvent.toString());
        log(events.length.toString());
      });
    });
  }

}
