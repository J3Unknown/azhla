import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utill/localization_helper.dart';
import '../data/cities_object.dart';
import '../domain/address_service.dart';
import 'address_screen.dart';

class AddAddress extends StatefulWidget {
  final String total_price;
  final String order_id;

  AddAddress({super.key, required this.total_price, required this.order_id});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  // Focus nodes for text fields
  FocusNode blockFocus = FocusNode();
  FocusNode streetFocus = FocusNode();
  FocusNode notesFocus = FocusNode();
  FocusNode floorFocus = FocusNode();
  FocusNode buildingFocus = FocusNode();

  // Text controllers
  TextEditingController blockController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController buildingController = TextEditingController();

  // Cities and regions data
  List<CitiesObject> cities = [];
  List<CitiesObject> regions = [];
  CitiesObject? selectedCity;
  CitiesObject? selectedRegion;

  @override
  void initState() {
    super.initState();
    loadCities();
    _addFocusListeners();
  }

  void _addFocusListeners() {
    // Scroll to the active field when it gains focus
    for (FocusNode focusNode in [
      blockFocus,
      streetFocus,
      notesFocus,
      floorFocus,
      buildingFocus
    ]) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          _scrollToFocusedField(focusNode);
        }
      });
    }
  }


  void _scrollToFocusedField(FocusNode focusNode) {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.pixels + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void loadCities() {
    AddressService.getCities(context).then((value) {
      setState(() {
        cities = value ?? [];
      });
    });
  }

  void loadRegions(int cityId) {
    AddressService.getRegions(context, cityId).then((value) {
      setState(() {
        regions = value ?? [];
      });
    });
  }

  void _submitForm() {
    if (selectedRegion == null ||
        blockController.text.isEmpty ||
        streetController.text.isEmpty ||
        buildingController.text.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(getTranslated(context, "Please fill all fields")!)),
      );
      return;
    }

    AddressService.addAdrees(
      context,
      selectedRegion!.id.toString(),
      floorController.text,
      streetController.text,
      blockController.text,
      buildingController.text,
      notesController.text,
    ).then((value) {
      if (value == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AddressScreen(
              total_price: widget.total_price,
              order_id: widget.order_id,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (FocusNode focusNode in [
      blockFocus,
      streetFocus,
      notesFocus,
      floorFocus,
      buildingFocus
    ]) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Important for keyboard handling
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(CupertinoIcons.back),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          getTranslated(context, "Address")!,
          style: TextStyle(
            color: Color.fromRGBO(170, 143, 10, 1),
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/Map.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildDropdownField(
                    label: getTranslated(context, "Governance")!,
                    hint: getTranslated(context, "Governance")!,
                    items: cities,
                    value: selectedCity,
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                        selectedRegion = null;
                        loadRegions(value!.id!);
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  _buildDropdownField(
                    label: getTranslated(context, "City")!,
                    hint: getTranslated(context, "City")!,
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value) {
                      setState(() {
                        selectedRegion = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    label: getTranslated(context, "Block")!,
                    focusNode: blockFocus,
                    controller: blockController,
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    label: getTranslated(context, "Street")!,
                    focusNode: streetFocus,
                    controller: streetController,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: getTranslated(context, "Building")!,
                          focusNode: buildingFocus,
                          controller: buildingController,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: _buildTextField(
                          label: getTranslated(context, "Floor")!,
                          focusNode: floorFocus,
                          controller: floorController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    label: getTranslated(context, "Special Mark")!,
                    focusNode: notesFocus,
                    controller: notesController,
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: InkWell(
                      onTap: _submitForm,
                      child: Container(
                        height: 50.h,
                        width: 0.8.sw,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(170, 143, 10, 1),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                          child: Text(
                            getTranslated(context, "Save and Continue")!,
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 300.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FocusNode focusNode,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1))),
        SizedBox(height: 5.h),
        Container(
          height: 50.h,
          width: 0.9.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: Color.fromRGBO(170, 143, 10, 1)),
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,
              contentPadding: EdgeInsets.all(10.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required List<CitiesObject> items,
    required CitiesObject? value,
    required void Function(CitiesObject?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1))),
        SizedBox(height: 10.h),
        Container(
          height: 50.h,
          width: 0.9.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: Color.fromRGBO(170, 143, 10, 1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<CitiesObject>(
              isExpanded: true,
              hint: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(hint),
              ),
              value: value,
              items: items
                  .map(
                    (item) => DropdownMenuItem<CitiesObject>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(item.name!,
    style:  TextStyle(
    fontSize: 16.sp,
    ),
                    ),
                  ),
                ),
              )
                  .toList(),
              onChanged: onChanged,
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
