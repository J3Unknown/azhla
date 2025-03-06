import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/colors_manager.dart';
import 'package:azhlha/utill/icons_manager.dart';
import 'package:azhlha/welcome_screens/presentation/first_welcome_screen.dart';
import 'package:azhlha/welcome_screens/presentation/second_welcome_screen.dart';
import 'package:azhlha/welcome_screens/presentation/third_welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../buttom_nav_bar/presentation/buttom_nav_screen.dart';

import '../../utill/localization_helper.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});
  final PageController _controller = PageController();
  bool isLast = false;
  List<Widget> onBoardingScreens = const [
    FirstWelcomeScreen(),
    SecondWelcomeScreen(),
    ThirdWelcomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemBuilder: (context, index) {
                index == onBoardingScreens.length -1 ? isLast = true: isLast = false;
                return onBoardingScreens[index];
              },
              itemCount: onBoardingScreens.length,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:  EdgeInsets.only(top:15.h,right: 10.w,left: 10.w),
                child: TextButton(
                  child: Text(getTranslated(context, KeysManager.skip)!,style: TextStyle(color: ColorsManager.grey,fontSize: 18.sp),),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            effect: const WormEffect(
                              dotColor: ColorsManager.grey2,
                              activeDotColor: ColorsManager.primary,
                              spacing: 15,
                              dotHeight: 10,
                              dotWidth: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60.w,
                        child: ElevatedButton(
                          onPressed: (){
                            if(!isLast) {
                              _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
                              //_controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                            }
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: ColorsManager.primary,
                            foregroundColor: ColorsManager.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Icon(IconsManager.rightArrowIcon),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
