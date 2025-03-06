import 'dart:developer';

import 'package:azhlha/events_screen/presentation/events_screen.dart';
import 'package:azhlha/home_screen/data/home_object.dart';
import 'package:azhlha/home_screen/domain/home_service.dart';
import 'package:azhlha/notifications/presentation/notifications_screen.dart';
import 'package:azhlha/special_request/presentation/special_requests_list.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../categories_screen/presentation/categories_screen.dart';
import '../../date_time_screen/presentation/order_seller_screen.dart';
import '../../events_screen/presentation/events_reminder.dart';
import '../../shared/alerts.dart';
import '../../utill/colors_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int index =0;
  HomeObject homeObject = HomeObject();
  bool isLoading = true;
  String token = '';
  Locale? locale;
  void initawaits() async{
     locale = await getLocale();
  }
  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          child:Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 5.w,
            height: 5.h,
            decoration: const BoxDecoration(
              //color: ColorsManager.primary,
              image: DecorationImage(
                image: AssetImage(imagePath + AssetsManager.calender),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        onTap: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if(prefs.containsKey("token")) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>EventReminders()));
            token = prefs.getString("token")!;
          }else{
            setState(() {
              // isLoading = false;
            });
           showToastLogin(context,getTranslated(context, "please login")!);
          }


        },
        ),
        title:  Text(getTranslated(context,"Maras")!,style: TextStyle(color: Color.fromRGBO(116, 3, 60, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),), // Color changed
        centerTitle: false, //changed
        actions: [
          InkWell(child:
        Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/notifications.png"),
              fit: BoxFit.contain
            )
          ),
        ),
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>NotificationsScreen()));

            },
        ),
        SizedBox(width: 10.w,)
        ],
        backgroundColor: Colors.white,
      ),
      body:  LoadingOverlay(
        progressIndicator: SpinKitSpinningLines(
        color: ColorsManager.primary,
        ),
        color: ColorsManager.primary0_1Transparency,
        isLoading: isLoading,
        child: isLoading == true ? Container()
        : Column(
          children: [
            SizedBox(height: 15.h,),
            CarouselSlider.builder(
              itemCount: homeObject.sliders!.length,
              carouselController: buttonCarouselController,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(
                    child: Container(
                      height: 130.h,
                      width: 0.85.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                          border: Border.all(
                              color: ColorsManager.primary
                          ),
                       // color: Colors.black87,
                        image: DecorationImage(
                            image:NetworkImage(AppConstants.MAIN_URL_IMAGE+homeObject.sliders![itemIndex].name!),
                          fit: BoxFit.fill
                        )
                      ),
                     // child: Text(itemIndex.toString()),
                    ),
                    onTap: (){
                      log("Link"+homeObject.sliders![itemIndex].link.toString());
                      launchURL(homeObject.sliders![itemIndex].link!);
                    },
                  ), options: CarouselOptions(
                    onPageChanged: (pageIndex,reason){
                      setState(() {
                        log(pageIndex.toString());
                        index = pageIndex;
                      });
                    },
                    autoPlay: false,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                    initialPage: 0,
                  ),
            ),
            SizedBox(height: 10.h,),
            AnimatedSmoothIndicator(
              activeIndex: index,
              count: homeObject.sliders!.length,
              effect: SlideEffect(
                activeDotColor: ColorsManager.primary,
                dotWidth:25.w,
                dotHeight:5.h
              ),
            ),
            SizedBox(height: 20.h,),
            SizedBox(
              height: 180.h,
              width: 1.sw,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: homeObject.categories!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: SizedBox(
                      height: 150.h,
                      width: 0.2.sw,
                      //color: Colors.black87,
                      child: Column(
                        children: [
                          Container(
                              height:130.h,
                              width: 150.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(AppConstants.MAIN_URL_IMAGE+homeObject.categories![index].image!),
                              ),
                              borderRadius: BorderRadius.circular(30.sp),
                              border: Border.all(
                                color: ColorsManager.primary
                              )
                            ), ),
                            SizedBox(height: 10.h,),
                            Text(homeObject.categories![index].name!,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20.sp),),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderSellerScreen(catName: homeObject.categories![index].name!,children: homeObject.categories![index].children!,)));
                    },
                  );
                }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _eventBuilder(AssetsManager.specialRequest, AssetsManager.specialRequest, const SpecialRequestsList(), KeysManager.specialRequest),
                _eventBuilder(AssetsManager.dailyEvents, AssetsManager.dailyEvents, const EventsScreen(), KeysManager.dailyEvents),
              ],
            ),
          ],
        ),
      )
    );
  }
  Future<void> launchURL(String url) async {
    launch(url);
  }

  Widget _eventBuilder(arabicAsset, englishAsset, navigationScreen, key) {
    return InkWell(
      child: Column(
        children: [
          Container(
            height: 150.h,
            width: 0.45.sw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(
                    color: ColorsManager.primary
                ),
                image: DecorationImage(
                    image: AssetImage((locale!.languageCode == KeysManager.ar) ? imagePath + arabicAsset : imagePath + englishAsset),
                    fit: BoxFit.cover
                )
            ),
          ),
          SizedBox(height: 10.h,),
          Text(getTranslated(context, key)!, style: TextStyle(color: Colors.black87, fontSize: 20.sp, fontWeight: FontWeight.bold),),
          SizedBox(height: 10.h,),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => navigationScreen));
      },
    );
  }

  void loadData(){
    HomeService.home(context,null,null).then((value){
      log(value.toString());
      setState(() {
        homeObject = value!;
        initawaits();
        setState(() {
          isLoading = false;
        });
      });
      log(homeObject.categories!.length.toString());
    });
  }
}
