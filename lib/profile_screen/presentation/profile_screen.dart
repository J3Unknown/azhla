import 'dart:developer';
import 'dart:io';

import 'package:azhlha/address_screen/presentation/add_address_profile.dart';
import 'package:azhlha/profile_screen/data/profile_object.dart';
import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../buttom_nav_bar/presentation/buttom_nav_screen.dart';
import '../../utill/app_constants.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';
import '../domain/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  var personalPhoto;
  bool show = false;
  String image = '';
  final ImagePicker picker = ImagePicker();
  String photopath ='';
  @override
  void initState() {
    // TODO: implement initState
    getProfileDate();
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
        title:  Text(getTranslated(context, "Profile")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.h,),
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(254, 254, 254, 1),
                        borderRadius: BorderRadius.circular(50.sp),
                        border: Border.all(
                            color: Color.fromRGBO(149, 156, 168, 1)
                        ),
                        image: DecorationImage(
                            image: (show == false) ?NetworkImage(AppConstants.MAIN_URL_IMAGE+image):FileImage(personalPhoto)as ImageProvider,
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 80.h,left: 50.w),
                    child: CustomRectangleIconButton(20.h, 20.w, Colors.white,
                        Icons.camera_alt_outlined, Colors.black, 5,15.sp,
                            (){
                          getFile();
                          //showToastImage(context);
                          setState(() {

                          });
                        }
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, "Full Name")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                SizedBox(height: 5.h,),
                Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: ColorsManager.primary
                      )
                  ),
                  child: TextFormField(
                    controller: fullNameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: getTranslated(context, "First and Last Name")!,
                        contentPadding: EdgeInsets.all(5.w),
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, "Phone Number with Whatsapp")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                SizedBox(height: 5.h,),
                Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: ColorsManager.primary
                      )
                  ),
                  child: TextFormField(
                    controller: phoneController,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(

                        border: InputBorder.none,
                        hintText: getTranslated(context, "Mobile Number")!,
                        contentPadding: EdgeInsets.all(5.w),
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, "password")!,style: TextStyle(color: Color.fromRGBO(136, 144, 156, 1)),),
                SizedBox(height: 5.h,),
                Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                          color: ColorsManager.primary
                      )
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: getTranslated(context, "password")!,
                        contentPadding: EdgeInsets.all(5.w),
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: 50.h,),
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
                  child: Center(child: Text(getTranslated(context, "Update")!,style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold),)),
                ),
                onTap: (){
                  onUpdateClick();
                },
              ),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: ColorsManager.primary,
                      )
                  ),
                  child: Center(child: Text(getTranslated(context, "Add New Address")!)),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>AddAddressProfile()));

                },
              ),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: InkWell(
                child: Container(
                  height: 50.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(
                        color: Colors.red,
                      )
                  ),
                  child: Center(child: Text(getTranslated(context, "Delete Account")!,style: TextStyle(color: Colors.red),)),
                ),
                onTap: () async{
                  await showDialog<void>(
                  context: context,
                  builder: (context) => Container(
                  height: 200.h,
                  width: 0.8.sw,
                  decoration: BoxDecoration(

                  ),
                  child:
                  AlertDialog(
                      scrollable: true,
                      content: Column(
                        children: [
                          Container(
                              height: 50.h,
                              width:50.w,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(25.sp),
                              ),
                              child:
                              Center(child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.white,size: 30.sp,),)
                          ),
                          SizedBox(height: 20.h,),
                          Text(getTranslated(context, "delete user")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
                          SizedBox(height: 20.h,),
                          Center(
                            child: InkWell(
                              child: Container(
                                height: 50.h,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                    color: ColorsManager.primary,
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(
                                      color: ColorsManager.primary,
                                    )
                                ),
                                child: Center(child: Text(getTranslated(context, "Confirm")!,style: TextStyle(color: Colors.white),)),
                              ),
                              onTap: (){
                                deleteOutOnClick();

                              },
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          Center(
                            child: InkWell(
                              child: Container(
                                height: 50.h,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(
                                      color: ColorsManager.primary,
                                    )
                                ),
                                child: Center(child: Text(getTranslated(context, "Cancel")!)),
                              ),
                              onTap: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                  )));
                },
              ),
            ),
            SizedBox(height: 30.h,),

          ],
        ),
      ),
    );
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
    }});
    // FilePickerResult? result = await FilePicker.platform.pickFiles();


  }
  void getProfileDate(){
    ProfileService.profile().then((data) {
      if(data == null){

      }
      else{
        setState(() {
          fullNameController.text = data.name!;
          phoneController.text = data.phone!;
          passwordController.text = data.phone!;
          image = data.image.toString();
        });

        log("logged image"+image);
      }
    });
  }
  void onUpdateClick(){
    String? personal = '';
    if(show == true) {
      personal = photopath;
    }else{
      personal = null;
    }
    ProfileService.editProfile(context,fullNameController.text,phoneController.text,passwordController.text,personal).then((data) async {
      if(data == null){
        setState(() {
          //isLoading = false;
        });
      }
      else{
       // ProfileObject user = data;
        log("token!");
        SharedPreferences.getInstance().then((prefs){
          prefs.remove('name');
          prefs.remove('phone');
          prefs.setString( 'name' , fullNameController.text );
          prefs.setString( 'phone' , phoneController.text );
        });
        setState(() {
          //isLoading = false;
        });

        Navigator.pop(context);
      }
    });
  }
  void deleteOutOnClick() {
    ProfileService.deleteAccount(context).then((value) {
      if (value == true)
        SharedPreferences.getInstance().then((prefs) {
          prefs.remove('token');
          prefs.remove('phone');
          prefs.remove('name');
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SignInScreen(signUp: 'delete user',)));
        });
    });
  }
}
class CustomRectangleIconButton extends StatefulWidget {
  CustomRectangleIconButton(this.btnHeight, this.btnWidth, this.btnColor,this.icon, this.iconColor,this.radius, this.iconSize, this.fun);
  double btnHeight;
  double btnWidth;
  Color btnColor;
  Color iconColor;
  double iconSize;
  double radius;
  IconData icon;
  VoidCallback fun;

  @override
  State<CustomRectangleIconButton> createState() => _CustomRectangleIconButtonState();
}
class _CustomRectangleIconButtonState extends State<CustomRectangleIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.fun,
      child: Container(
        height: widget.btnHeight,
        width: widget.btnWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.btnColor
        ),
        child: Center(
          child: Icon(widget.icon, color: widget.iconColor, size: widget.iconSize,),
        ),
      ),
    );
  }
}
