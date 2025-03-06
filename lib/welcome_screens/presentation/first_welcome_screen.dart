import 'package:azhlha/utill/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstWelcomeScreen extends StatefulWidget {
  const FirstWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<FirstWelcomeScreen> createState() => _FirstWelcomeScreenState();
}

class _FirstWelcomeScreenState extends State<FirstWelcomeScreen> {
  @override
  void initState() {
    initAwaits();
    super.initState();
  }
  void initAwaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("FirstTime", "true");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              const Positioned.fill(
                child: Image(
                  image: AssetImage(imagePath+AssetsManager.welcomeScreen1),
                  fit: BoxFit.cover,
                )
              ),
              Align(
                alignment: Alignment(0,0.6.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Select Your section",
                      style: TextStyle(color: Colors.black87, fontSize: 22.sp),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "اختر القسم بين الرجالي والنسائي",
                      style: TextStyle(color: Colors.black87, fontSize: 22.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
