import 'dart:developer';

import 'package:azhlha/events_screen/data/MyEventsDTO.dart';
import 'package:azhlha/events_screen/domain/events_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/validations.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class EditEventGender extends StatefulWidget {
  String imgPath;
  String title;
  String category;
  String familyName;
  String area;
  String date;
  String time;
  String description;

  UnderReview underReview;
  EditEventGender({Key? key,required this.imgPath,required this.title,required this.category,required this.familyName,required this.area,required this.date,required this.time,required this.description,required this.underReview}) : super(key: key);
  @override
  _EditEventGenderState createState() => _EditEventGenderState();
}

class _EditEventGenderState extends State<EditEventGender> {
  TextEditingController mWhatsappController = TextEditingController();
  TextEditingController fWhatsappController = TextEditingController();
  TextEditingController mCallController = TextEditingController();
  TextEditingController fCallController = TextEditingController();
  TextEditingController mAddressController = TextEditingController();
  TextEditingController fAddressController = TextEditingController();
  bool men = false;
  bool women = false;
  String manWord = "";
  String womanWord = "";
  String mLong = '';
  String fLong = '';
  String mLat = '';
  String fLat = '';
  String? selectedValue;
  List<String> items = [
  ];
  @override
  void initState() {
    iniAwaits();
    // TODO: implement initState
    super.initState();
  }
  void iniAwaits() async{
    Locale locale = await getLocale();
    log(locale.toString());
    if(locale.languageCode == 'ar'){
      setState(() {
        items = ["للرجال","للنساء","للاثنين"];
      });
     if(widget.underReview.type == 'male'){
       setState(() {
         selectedValue = "للرجال";
         mWhatsappController.text = widget.underReview.whatsAppNumber.toString();
         mCallController.text = widget.underReview.phone.toString();
         mAddressController.text = widget.underReview.address.toString();
         mLat = widget.underReview.latitude.toString();
         mLong = widget.underReview.longitude.toString();
         manWord = widget.underReview.address.toString();
       });
     }else if(widget.underReview.type == 'female'){
       setState(() {
         selectedValue = "للنساء";
         fWhatsappController.text = widget.underReview.fWhatsAppNumber.toString();
         fCallController.text = widget.underReview.fPhone.toString();
         fAddressController.text = widget.underReview.fAddress.toString();
         fLat = widget.underReview.fLatitude.toString();
         fLong = widget.underReview.fLongitude.toString();
         womanWord = widget.underReview.fAddress.toString();
       });
     }else{
       setState(() {
         selectedValue = "للاثنين";
         fWhatsappController.text = widget.underReview.fWhatsAppNumber.toString();
         fCallController.text = widget.underReview.fPhone.toString();
         fAddressController.text = widget.underReview.fAddress.toString();
         mWhatsappController.text = widget.underReview.whatsAppNumber.toString();
         mCallController.text = widget.underReview.phone.toString();
         mAddressController.text = widget.underReview.address.toString();
         mLat = widget.underReview.latitude.toString();
         mLong = widget.underReview.longitude.toString();
         fLat = widget.underReview.fLatitude.toString();
         fLong = widget.underReview.fLongitude.toString();
         manWord = widget.underReview.address.toString();
         womanWord = widget.underReview.fAddress.toString();
       });
     }
    } else{
      setState(() {
        items = ["For Men","For Women","Both"];
      });
      if(widget.underReview.type == 'male'){
        setState(() {
          selectedValue = "For Men";

          mWhatsappController.text = widget.underReview.whatsAppNumber.toString();
          mCallController.text = widget.underReview.phone.toString();
          mAddressController.text = widget.underReview.address.toString();
          mLat = widget.underReview.latitude.toString();
          mLong = widget.underReview.longitude.toString();
          manWord = widget.underReview.address.toString();
        });
      }
      else if(widget.underReview.type == 'female'){
        setState(() {
          selectedValue = "For Women";
          fWhatsappController.text = widget.underReview.fWhatsAppNumber.toString();
          fCallController.text = widget.underReview.fPhone.toString();
          fAddressController.text = widget.underReview.fAddress.toString();
          fLat = widget.underReview.fLatitude.toString();
          fLong = widget.underReview.fLongitude.toString();
          womanWord = widget.underReview.fAddress.toString();
        });
      }else{
        setState(() {
          selectedValue = "Both";
          fWhatsappController.text = widget.underReview.fWhatsAppNumber.toString();
          fCallController.text = widget.underReview.fPhone.toString();
          fAddressController.text = widget.underReview.fAddress.toString();
          mWhatsappController.text = widget.underReview.whatsAppNumber.toString();
          mCallController.text = widget.underReview.phone.toString();
          mAddressController.text = widget.underReview.address.toString();
          mLat = widget.underReview.latitude.toString();
          mLong = widget.underReview.longitude.toString();
          fLat = widget.underReview.fLatitude.toString();
          fLong = widget.underReview.fLongitude.toString();
          manWord = widget.underReview.address.toString();
          womanWord = widget.underReview.fAddress.toString();
        });
      }
    }
  }
  String ?type;
  final formManGlobalKey = GlobalKey < FormState > ();
  final formWomanGlobalKey = GlobalKey < FormState > ();
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(getTranslated(context, "Add Event")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Container(
                height: 60.h,
                width: 0.9.sw,
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
                    onChanged: (String? value) async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                      setState(() {
                        selectedValue = value;
                        prefs.setString("selectedValue", selectedValue!);
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
            // For Men Section
            (selectedValue == "For Men" ||selectedValue == "Both" || selectedValue == "للرجال"||selectedValue == "للاثنين")?Form(
              key: formManGlobalKey,
              child: Column(
                children: [
                  Text(getTranslated(context, "For Men")!, style: TextStyle(fontWeight: FontWeight.bold)),
                  // CheckboxListTile(
                  //   activeColor: Color.fromRGBO(170, 143, 10, 1),
                  //   title:
                  //   value: men, // Update with state management later
                  //   onChanged: (bool? value) {
                  //     setState(() {
                  //       men= value!;
                  //     });
                  //
                  //   },
                  //   secondary: Padding(
                  //     padding:  EdgeInsets.all(10.sp),
                  //     child: Image(
                  //       image: AssetImage("assets/image/formen.png"),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 60.h,
                    width: 0.98.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: ColorsManager.primary
                        )
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: RequiredValidator(errorText: getTranslated(context, "This field is required")!),
                      textAlign: TextAlign.center,
                      controller: mWhatsappController,
                      maxLength: 8,

                      // readOnly: men?false:true,
                      decoration: InputDecoration(
                          counterText: "", // Hide the maxLength counter
                          border:InputBorder.none,
                          hintText: getTranslated(context, "Whatsapp number")!),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 60.h,
                    width: 0.98.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: ColorsManager.primary
                        )
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: RequiredValidator(errorText: getTranslated(context, "This field is required")!),
                      textAlign: TextAlign.center,
                      controller: mCallController,
                      maxLength: 8,
                      // readOnly: men?false:true,
                      decoration: InputDecoration(
                          counterText: "", // Hide the maxLength counter
                          border:InputBorder.none,
                          hintText: getTranslated(context, "Calling Number")!),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 60.h,
                    width: 0.98.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: ColorsManager.primary
                        )
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: RequiredValidator(errorText: getTranslated(context, "This field is required")!),
                      controller: mAddressController,
                      // readOnly: men?false:true,
                      decoration: InputDecoration(
                          border:InputBorder.none,
                          hintText: getTranslated(context, "Full Address")!),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                    child: Container(
                      height: 60.h,
                      width: 0.98.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                              color: ColorsManager.primary
                          )
                      ),
                      child: Center(child: Text((manWord == "")? getTranslated(context, "location")!:manWord)),
                    ),
                    onTap: () async{
                      log("message here");
                      LocationResult result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            "AIzaSyCnunDtY9avk3j2i53PpDxsPShrAwKLczo",
                            //  displayLocation: customLocation,
                          )));
                      setState(() {
                        manWord = result.formattedAddress.toString();
                        mLong = result.latLng!.longitude.toString();
                        mLat = result.latLng!.latitude.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ):Container(),

            (selectedValue == "For Women" ||selectedValue == "Both" || selectedValue == "للنساء"||selectedValue == "للاثنين")? Form(
              key: formWomanGlobalKey,
              child: Column(
                children: [
                  Text(getTranslated(context, "For Women")!, style: TextStyle(fontWeight: FontWeight.bold)),
                  // For Women Section
                  // CheckboxListTile(
                  //   activeColor: Color.fromRGBO(170, 143, 10, 1),
                  //   title:
                  //   value: women, // Update with state management later
                  //   onChanged: (bool? value) {
                  //     setState(() {
                  //       women = value!;
                  //     });
                  //
                  //   },
                  //   secondary: Padding(
                  //     padding:  EdgeInsets.all(10.sp),
                  //     child: Image(
                  //       image: AssetImage("assets/image/forwomen.png"),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 60.h,
                    width: 0.98.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: ColorsManager.primary
                        )
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      validator: RequiredValidator(errorText: getTranslated(context, "This field is required")!),
                      controller: fWhatsappController,
                      // readOnly: women?false:true,
                      maxLength: 8,
                      decoration: InputDecoration(
                          counterText: "", // Hide the maxLength counter
                          border:InputBorder.none,
                          hintText: getTranslated(context, "Whatsapp number")!),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 60.h,
                    width: 0.98.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: ColorsManager.primary
                        )
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      validator: RequiredValidator(errorText: getTranslated(context, "This field is required")!),
                      controller: fCallController,
                      //readOnly: women?false:true,
                      maxLength: 8,
                      decoration: InputDecoration(
                          counterText: "", // Hide the maxLength counter
                          border:InputBorder.none,
                          hintText: getTranslated(context, "Calling Number")!),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                    height: 60.h,
                    width: 0.98.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: ColorsManager.primary
                        )
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: RequiredValidator(errorText: getTranslated(context, "This field is required")!),
                      controller: fAddressController,
                      // readOnly: women?false:true,
                      decoration: InputDecoration(
                          border:InputBorder.none,
                          hintText: getTranslated(context, "Full Address")!),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                    child: Container(
                      height: 60.h,
                      width: 0.98.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(
                              color: ColorsManager.primary
                          )
                      ),
                      child: Center(child: Text((womanWord == "")? getTranslated(context, "location")!:womanWord)),
                    ),
                    onTap: () async{
                      log("message here");
                      LocationResult result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            "AIzaSyCnunDtY9avk3j2i53PpDxsPShrAwKLczo",
                            //  displayLocation: customLocation,
                          )));
                      setState(() {
                        womanWord = result.formattedAddress.toString();
                        fLong = result.latLng!.longitude.toString();
                        fLat = result.latLng!.latitude.toString();
                      });
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ) :Container(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  log(women.toString());
                  log(men.toString());
                  if(selectedValue == "For Women" || selectedValue == "للنساء" ||selectedValue == "Both" || selectedValue == "للاثنين"){
                    if(!formWomanGlobalKey.currentState!.validate()){
                      log("inside");
                      return;
                    }}

                  if(selectedValue == "For Men" || selectedValue == "للرجال" ||selectedValue == "Both" || selectedValue == "للاثنين"){
                    if(!formManGlobalKey.currentState!.validate()){
                      log("inside");
                      return;
                    }}
                  // if(!formManGlobalKey.currentState!.validate()&&men){
                  //   return;
                  // }

                  if(selectedValue == "Both" || selectedValue == "للاثنين"){
                    type = 'both';
                  }else if( selectedValue == "For Women" || selectedValue == "للنساء"){
                    type = 'female';
                  }else{
                    type = 'male';
                  }
                  onClick();

                },
                child: Text(getTranslated(context, "Confirm")!),
                style: ElevatedButton.styleFrom(
                  primary:  ColorsManager.primary,
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
    );
  }

  void onClick(){
    log(widget.title.toString());
    log(widget.description.toString());
    EventsService.editEvent(context,
        widget.underReview.id.toString(),
        widget.imgPath,
        widget.title,
        widget.category,
        widget.familyName,
        widget.area,
        widget.date,
        widget.time,
        widget.description,
        mWhatsappController.text,
        fWhatsappController.text,
        mCallController.text,
        fCallController.text,
        mAddressController.text,
        fAddressController.text,
        mLong,
        fLong,
        mLat,
        fLat,
        type.toString()
    ).then((data) async {
      if(data == null){
        setState(() {
          //isLoading = false;
        });
      }
      else{

      }
    });
  }
}
