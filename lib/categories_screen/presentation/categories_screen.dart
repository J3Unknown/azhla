import 'dart:developer';

import 'package:azhlha/categories_screen/domain/categories_service.dart';
import 'package:azhlha/date_time_screen/presentation/seller_date_screen.dart';
import 'package:azhlha/home_screen/data/home_object.dart';
import 'package:azhlha/product_screen/presentation/product_screen.dart';
import 'package:azhlha/stores_screen/presentation/stores_screen.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../date_time_screen/presentation/order_seller_screen.dart';
import '../../home_screen/domain/home_service.dart';
import '../../shared/alerts.dart';
import '../../utill/colors_manager.dart';

class CategoriesScreen extends StatefulWidget {
  late List<Children> children;
  late String catName;

  late String? govId;


   CategoriesScreen({Key? key,required this.children,required this.govId,required this.catName}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  String date = '';
  DateTime dateTime = DateTime.now();

  List<Sellers> sellers=[];
  List<Sellers> sellers2=[];
  List<Children> sellersChildern=[];
  HomeObject sellersall=HomeObject();
  List <bool> show = [];
  List <dynamic>? intList;
  bool showAll = true;
  List <int> allList=[];
  bool isLoading = false;
  bool isLoading2 = false;
  @override
  void initState() {
    loadSellersDataAll();
    loadData();
    super.initState();
  }
  void loadData() async{
   // isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      CategoriesService.basket(context).then((value) {
        log(value.toString());
        setState(() {
          intList = value!;
          log("intList"+intList!.length.toString());
          log("seller length"+sellers2!.length.toString());
          allList.clear();
          for (int i = 0; i < sellers2.length; i++) {
            int temp = 0;
            for (int j = 0; j < intList!.length; j++) {
              log("seller id "+sellers2[i].id.toString());
              log("id "+intList![j].toString());
              if (sellers2[i].id == intList![j]) {
                log("inside");
                temp = 1;
              }
            }
            allList.add(temp);
          }
           isLoading =false;
        });
        log(intList!.length.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
        title:  Text(widget.catName,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        // actions: [InkWell(child:Icon(CupertinoIcons.search),),
        //   SizedBox(width: 10.w,)
        // ],
        backgroundColor: Colors.white,
      ),
      body: LoadingOverlay(
          progressIndicator: SpinKitSpinningLines(
            color: Color.fromRGBO(254, 222, 0, 1),
          ),
          color: Color.fromRGBO(254, 222, 0, 0.1),
          isLoading: isLoading,
          child: isLoading == true
              ? Container()

              :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          SizedBox(height: 10.h,),
          // Center(
          //   child: Container(
          //     height: 35.h,
          //     width: 200.w,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.sp),
          //       border: Border.all(
          //         color: ColorsManager.primary
          //       )
          //     ),
          //     child: DropdownButtonHideUnderline(
          //       child: DropdownButton2<String>(
          //         isExpanded: true,
          //         hint: Text(
          //           getTranslated(context, "All Areas")!,
          //           style: TextStyle(
          //             fontSize: 14,
          //             color: Theme.of(context).hintColor,
          //           ),
          //         ),
          //         items: items
          //             .map((String item) => DropdownMenuItem<String>(
          //           value: item,
          //           child: Text(
          //             item,
          //             style: const TextStyle(
          //               fontSize: 14,
          //             ),
          //           ),
          //         ))
          //             .toList(),
          //         value: selectedValue,
          //         onChanged: (String? value) {
          //           setState(() {
          //             selectedValue = value;
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
          // SizedBox(height: 10.h,),
          Padding(
            padding: EdgeInsets.only(left: 10.w,right: 10.w),
            child: Text(getTranslated(context, "Categories")!,style: TextStyle(fontSize: 20.sp),),
          ),
          SizedBox(height: 20.h,),
          Center(
            child: Row(
              children: [
                SizedBox(width: 20.w,),
                InkWell(
                  child: Container(
                    width: 90.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                          color:  (showAll != true)?ColorsManager.grey1:ColorsManager.primary
                      ),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                        ),
                      ],

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath+AssetsManager.calender,),
                              )
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          getTranslated(context, "All")!,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    if(showAll == false){
                      loadSellersDataAll();
                      setState(() {
                        showAll = true;
                        for(int i =0 ;i<show.length;i++){
                          show[i] = false;
                        }
                        sellers2 =[];
                        for(int i =0;i<sellersChildern.length;i++)
                        {
                          sellers2.addAll( sellersChildern![i].sellers!);
                        }
                        loadData();
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 100.h,
                  width: 0.7.sw,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sellersChildern.length,
                    itemBuilder: (context, position) {
                      return Padding(
                        padding:  EdgeInsets.only(right: 10.w,left: 10.w),
                        child: InkWell(
                          child: Container(
                            width: 90.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: (show[position] != true)? ColorsManager.grey1:ColorsManager.primary
                              ),
                              // border: Border.all(
                              //       color: ColorsManager.primary
                              //   ),
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(5.sp),
                              boxShadow:[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.sp),
                                      border: Border.all(
                                          color: ColorsManager.primary
                                      ),
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+ sellersChildern![position].image!),
                                    )
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  sellersChildern![position].name!,
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            if(show[position] == true){
                              setState(() {

                                show[position] = false;
                              });
                            }
                            if(show[position] == false){
                              setState(() {
                                for(int i =0 ;i<show.length;i++){
                                  show[i] = false;
                                }
                                showAll = false;
                                show[position] = true;
                              });
                            }
                            setState(() {
                               loadSellersData(sellersChildern[position].id.toString());
                              sellers2 = sellersChildern![position].sellers!;
                              loadData();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.only(left: 10.w,right: 10.w),
            child: Text(getTranslated(context, "Stores")!,style: TextStyle(fontSize: 20.sp),),
          ),
          SingleChildScrollView(
            child: Container(
              height: 0.55.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300.sp),
                // boxShadow:[
                //   BoxShadow(
                //     color: Colors.white,
                //     blurRadius: 7,
                //   ),
                // ],

              ),
              child:  LoadingOverlay(
                progressIndicator: SpinKitSpinningLines(
                  color: ColorsManager.primary,
                ),
                color: ColorsManager.primary0_1Transparency,
                isLoading: isLoading2,
                child: isLoading2 == true ? Container()
                :ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: sellers2.length,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
                      child: InkWell(
                        child: Container(
                          width: 0.75.sw,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.sp),
                            border: Border.all(color: ColorsManager.primary.withOpacity(0.3)),
                            boxShadow:[
                              BoxShadow(
                                color: ColorsManager.black.withOpacity(0.2),
                                offset: const Offset(3, 4),
                                blurRadius: 5,
                              ),
                            ],

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Container(
                                height: 50.h,
                                width: 50.w,

                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+sellers2[position]!.imgPath!),
                                    ),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    border: Border.all(
                                        color: ColorsManager.primary
                                    )
                                ),
                              ),
                              SizedBox(width: 20.w,),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 0.55.sw,
                                  maxHeight: 150.h,
                                ),
                                //width: 0.55.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sellers2[position].name.toString(),
                                      style: TextStyle(fontSize: 24.sp,color: ColorsManager.deepBlue,fontWeight: FontWeight.bold),
                                    ),
                                    // Text(
                                    //   sellers[position].name.toString(),
                                    //   style: TextStyle(fontSize: 15.0),
                                    // ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.location_solid,color: ColorsManager.primary,),
                                        Text(
                                          sellers2[position].details.toString(),
                                          style: TextStyle(fontSize: 15.sp,color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //SizedBox(width: 50.w,),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width:30.w,
                                      decoration: BoxDecoration(
                                        color: ColorsManager.primary,
                                        borderRadius: BorderRadius.circular(15.sp),
                                      ),
                                      child: Center(child: Text("35%",style: TextStyle(fontSize: 10.sp,color: Colors.white),),)
                                    ),
                                    InkWell(child: (allList.isNotEmpty&&allList[position] == 1)? Icon(CupertinoIcons.heart_solid ,size: 30.sp,color:Colors.red):Icon(CupertinoIcons.heart ,size: 30.sp,color: ColorsManager.primary,),
                                      onTap: () async{
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        if(prefs.containsKey("token")) {
                                          if (allList![position] == 0) {
                                            CategoriesService.AddSellerFav(context, sellers2[position].id.toString()).then((value) {
                                              log(value.toString());
                                              setState(() {
                                                if (value == true) {
                                                  loadData();
                                                }
                                              });
                                              //log(basket.length.toString());
                                            });
                                          }
                                          else {
                                            CategoriesService.DeleteSellerFav(context, sellers2[position].id.toString()).then((value) {
                                              log(value.toString());
                                              setState(() {
                                                if (value == true) {
                                                  loadData();
                                                }
                                              });
                                              //log(basket.length.toString());
                                            });
                                          }
                                        }else{
                                          showToastLogin(context,getTranslated(context, "please login")!);
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  OrderSellerScreen(categoryId: sellers![position].pivot!.categoryId!, sellerId: sellers![position].pivot!.sellerId!, imgPath: sellers![position].imgPath!,)));

                          if(prefs.containsKey("OrderDate")){
                            date = prefs.getString("OrderDate")!;}
                          else{
                            date =dateTime.year.toString()+"-"+dateTime.month.toString()+"-"+dateTime.day.toString();
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StoresScreen(categoryId: sellers2![position].pivot!.categoryId!, catName: widget.catName,sellerId: sellers2![position].pivot!.sellerId!, imgPath: sellers2![position].imgPath!,date: date,)));
                        },
                      ),
                    );
                  },
                )
              ),
            ),
          ),
          SizedBox(height: 10.h,),
        ],
        ),
      )),
    );
  }
  void loadSellersData(String catId){
    setState(() {
      isLoading2 = true;
    });
    HomeService.home(context,catId,widget.govId).then((value){
      log(value.toString());
      setState(() {
        sellers2 = value!.categories![0].children![0].sellers!;
        // initawaits();
        setState(() {
          isLoading2 = false;
        });
      });
      // log(homeObject.categories!.length.toString());
    });
  }
  void loadSellersDataAll(){
    setState(() {
      isLoading2 = true;
    });
    HomeService.home(context,null,widget.govId).then((value){
      log(value.toString());
      setState(() {
        sellersall = value!;
        for(int i =0 ;i<sellersall.categories!.length;i++){
          if(sellersall.categories![i].name == widget.catName){
            sellersChildern = sellersall.categories![i].children!;
          }
        }
        sellers2.clear();
        for(int i = 0;i<sellersChildern.length;i++){
          sellers2.addAll(sellersChildern![i].sellers!);
          show.add(false);
        }
        // initawaits();
        setState(() {
          isLoading2 = false;
        });
      });
      // log(homeObject.categories!.length.toString());
    });
  }
}
