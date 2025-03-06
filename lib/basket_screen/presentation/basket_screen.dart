import 'dart:developer';

import 'package:azhlha/basket_screen/data/basket_object.dart';
import 'package:azhlha/basket_screen/domain/basket_service.dart';
import 'package:azhlha/date_time_screen/presentation/date_time_screen.dart';
import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../address_screen/presentation/address_screen.dart';
import '../../product_screen/presentation/product_screen.dart';
import '../../utill/colors_manager.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<BasketObject> basket = [];
  bool isLoading = true;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  String token = '';
  void initawaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      token = prefs.getString("token")!;
      loadData();
    }
    else{
      setState(() {
        isLoading =false;
      });
     showToastLogin(context,getTranslated(context, "please login")!);
    }
  }
  @override
  void initState() {
    initawaits();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
        title:  Text(getTranslated(context, "Basket")!,style: TextStyle(color: ColorsManager.primary, fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          InkWell(
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagePath+AssetsManager.refresh),
                      fit: BoxFit.contain
                  )
              ),
            ),
            onTap: (){
              _onRefresh();
            },
          ),
          SizedBox(width: 10.w,)
        ],
        // actions: [InkWell(child:Icon(CupertinoIcons.search),),
        //   SizedBox(width: 10.w,)
        // ],
        backgroundColor: Colors.white,
      ),
      body:
    LoadingOverlay(
      progressIndicator: SpinKitSpinningLines(
      color: ColorsManager.primary,
      ),
      color: ColorsManager.primary0_1Transparency,
      isLoading: isLoading,

      child: isLoading == true
      ? Container():
      SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child:(token != '')? (basket.isNotEmpty && basket[0].orderDetails!.isNotEmpty)?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            Center(
              child: Container(
                height: 80.h,
                width: 150.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/watnia.png"),
                      fit: BoxFit.contain
                    )
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Padding(
                padding: EdgeInsets.only(left: 20.w,right: 20.w),
              child: Text(
                getTranslated(context, "Your Selection")!,style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 10.h,),
            SizedBox(
              height: 0.4.sh,
              width: 1.sw,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: (basket.isNotEmpty)?basket[0].orderDetails!.length:0,
                itemBuilder: (context, position) {
                  return InkWell(
                    child: Padding(
                      padding:  EdgeInsets.all(20.sp),
                      child: Container(
                        width: 0.75.sw,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                          boxShadow:const [
                            BoxShadow(
                        color: ColorsManager.primary,
                              offset: Offset(0.0, 1.0),
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
                                borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstants.MAIN_URL_IMAGE+ basket[0].orderDetails![position].product!.mainImage!),
                                  ),
                                  border: Border.all(
                                      color: ColorsManager.primary
                                  )
                              ),
                            ),
                            SizedBox(width: 30.w,),
                            SizedBox(
                              height: 90.h,
                              width: 0.35.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    basket![0].orderDetails![position]!.product!.name.toString(),
                                    style: TextStyle(fontSize: 24.sp,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    basket![0].orderDetails![position]!.product!.title.toString(),
                                    style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        basket![0].orderDetails![position]!.price!,
                                        style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(43, 190, 186, 1),fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 30.w,),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: 20.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const InkWell(child: Icon(CupertinoIcons.heart)),
                                SizedBox(height: 50.h,),
                                Container(
                                    height: 25.h,
                                    width:25.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.sp),
                                      boxShadow:[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child:
                                    Center(child: Icon(CupertinoIcons.forward,color: Colors.black87,size: 25.sp,))
                                ),
                              ],
                            ),
                            SizedBox(width: 20.w,),
                            InkWell(
                              child: Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/image/basket.png"),
                                  )
                                ),
                              ),
                              onTap: () async{

                                await showDialog<void>(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 200.h,
                                      width: 0.8.sw,
                                      decoration: BoxDecoration(

                                      ),
                                      child: AlertDialog(
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
                                              Text(getTranslated(context, "delete product")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
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
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    BasketService.deleteFromBasket(context,basket[0].orderDetails![position]!.id.toString()).then((value){
                                                      log(value.toString());
                                                      setState(() {
                                                        if(value == true){
                                                          loadData();

                                                        }
                                                      });
                                                      log(basket.length.toString());
                                                    });
                                                    Navigator.of(context, rootNavigator: true).pop('dialog');

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
                                      ),
                                    )
                                );


                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductScreen(Id: basket[0].orderDetails![position].product!.id!,catName: getTranslated(context,"Maras")!,)));

                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(width: 20.w,),
                Container(
                    height: 20.h,
                    width: 250.w,
                    child: Text(getTranslated(context, "Total Items")!,style: (TextStyle(fontSize: 15.sp)),)),
                // SizedBox(width: 200.w,),
                Container(
                    height: 20.h,
                    width: 100.w,
                    child: Text("${(basket.isNotEmpty)?basket[0].orderDetails!.length!.toString():0} ",style: TextStyle(color: Colors.blue,fontSize: 15.sp),))
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20.h,
                    width: 250.w,
                    child: Text(getTranslated(context, "Total")!,style: (TextStyle(fontSize: 15.sp)),)),
                // SizedBox(width: 200.w,),
                Container(
                    height: 20.h,
                    width: 100.w,
                    child: Text("${(basket.isNotEmpty)?basket[0].totalPrice:0} KWD",style: TextStyle(color: Colors.red,fontSize: 15.sp),))
              ],
            ),
            SizedBox(height: 20.h,),
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
                  child: Center(child: Text( getTranslated(context, "Next")!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                ),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DateTimeScreen(total_price: basket[0].totalPrice.toString(),order_id: basket[0].id.toString(),)));
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>AddressScreen( total_price: basket[0].totalPrice.toString(),order_id: basket[0].id.toString(),)));

                },
              ),
            ),
            SizedBox(height: 30.h,)
          ],
        ):
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 100.h,),
            Center(
              child: Container(
                height: 150.h,
                width: 150.w,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage("assets/image/cart.png")
                 )
               ),
              ),
            ),
            SizedBox(height: 20.h,),
            Center(child: Text(getTranslated(context, "The cart is empty")!,style: TextStyle(fontSize: 24.sp),))
          ],
        ):Container(),
      ),
    ));
  }
  void _onRefresh() async{
    setState(() {
      isLoading = true;

    });
    // monitor network fetch
    initawaits();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void loadData(){
    BasketService.basket(context).then((value){
      log(value.toString());
      setState(() {
        basket = value!;
        isLoading =false;
      });
      log(basket.length.toString());
    });
  }
}
