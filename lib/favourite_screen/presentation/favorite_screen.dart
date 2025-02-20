import 'dart:developer';

import 'package:azhlha/favourite_screen/data/FavoriteProduct.dart';
import 'package:azhlha/favourite_screen/domain/favorite_srevice.dart';
import 'package:azhlha/stores_screen/presentation/stores_screen_fav.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../product_screen/presentation/product_screen.dart';
import '../../shared/alerts.dart';
import '../../stores_screen/presentation/stores_screen.dart';
import '../../utill/app_constants.dart';
import '../../utill/colors_manager.dart';
import '../data/favorite_sellers.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<FavoriteProduct> favorites = [];
  List<FavoriteSeller> favoriteSeller = [];
  bool isLoading =true;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  String token = '';
  void initawaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      loadFavoriteProducts();
      loadFavoriteSellers();
      token = prefs.getString("token")!;
    }else{
      setState(() {
       // isLoading = false;
      });
      showToastLogin(context, getTranslated(context, "please login")!);
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
    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2, child:
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title:  Text(getTranslated(context, "Favorite")!,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
                centerTitle: true,
                actions: [
                  InkWell(
                    child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/image/refresh.png"),
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
                backgroundColor: Colors.white,
              ),
              body:
              LoadingOverlay(
              progressIndicator: SpinKitSpinningLines(color: ColorsManager.primary,),
    color: Color.fromRGBO(254, 222, 0, 0.1),
    isLoading: isLoading,
    child: isLoading == true
    ? Container():
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width:0.8.sw,
                        height: 50.h,
                        child: TabBar(
                          indicatorColor:Color.fromRGBO(175, 147, 92, 1),
                            tabs:

                            <Widget>[

                              Container(
                                height: 40.h,
                                width: 0.35.sw,
                                child: Center(child: Text(getTranslated(context, "Stores")!,style: TextStyle(color: Color.fromRGBO(52, 21, 87, 1),fontSize: 24.sp),)),
                              ),
                              Container(
                                height: 40.h,
                                width: 0.35.sw,
                                child: Center(child: Text(getTranslated(context, "Products")!,style: TextStyle(color: Color.fromRGBO(52, 21, 87, 1),fontSize: 24.sp),)),
                              ),
                            ]
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.7.sh,
                      child: TabBarView(children: [
                        Container(
                          height: 0.4.sh,
                          width: 1.sw,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: favoriteSeller.length,
                            itemBuilder: (context, position) {
                              return Padding(
                                padding:  EdgeInsets.all(20.sp),
                                child: InkWell(
                                  child: Container(
                                    width: 0.9.sw,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.sp),
                                      boxShadow:[
                                        BoxShadow(
                                    color: ColorsManager.primary,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 5,
                                        ),
                                      ],

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10.w,),
                                        Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                                              image: DecorationImage(
                                                image: NetworkImage(AppConstants.MAIN_URL_IMAGE+ favoriteSeller[position].imgPath!),
                                              ),
                                              border: Border.all(
                                                  color: ColorsManager.primary
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 20.w,),
                                        Container(
                                          height: 90.h,
                                          width: 0.58.sw,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height:30.h,
                                                width: 220.w,
                                                child: Text(
                                                  favoriteSeller[position].name.toString(),
                                                  style: TextStyle(fontSize: 24.sp,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height:20.h,
                                                width: 220.w,
                                                child: Text(
                                                  favoriteSeller[position].name.toString(),
                                                  style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                height:30.h,
                                                width: 220.w,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_on_outlined,color: Color.fromRGBO(166, 139, 12, 1),),
                                                    SizedBox(width: 5.w,),
                                                    Text(
                                                      favoriteSeller[position].details.toString(),
                                                      style: TextStyle(fontSize: 15.0,color: Colors.grey),
                                                    ),
                                                    SizedBox(width: 20.w,),

                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                       // SizedBox(width: 70.w,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            InkWell(child: Icon(CupertinoIcons.xmark_circle,color: Colors.red,),
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
                                                              Text(getTranslated(context, "delete Seller favourite")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
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
                                                                    FavoriteService.deleteFromFavoritesSeller(context,favoriteSeller[position].id.toString()).then((value){
                                                                      log(value.toString());
                                                                      setState(() {
                                                                        if(value == true){
                                                                          loadFavoriteSellers();
                                                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                        }
                                                                      });
                                                                      //log(basket.length.toString());
                                                                    });
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
                                            ),
                                            // SizedBox(height: 50.h,),
                                            // Container(
                                            //     height: 25.h,
                                            //     width:25.w,
                                            //     decoration: BoxDecoration(
                                            //       color: Colors.white,
                                            //       borderRadius: BorderRadius.circular(15.sp),
                                            //       boxShadow:[
                                            //         BoxShadow(
                                            //           color: Colors.grey.withOpacity(0.5),
                                            //           blurRadius: 2,
                                            //         ),
                                            //       ],
                                            //     ),
                                            //     child:
                                            //     Center(child: Icon(CupertinoIcons.forward,color: Colors.black87,size: 25.sp,))
                                            // ),
                                          ],
                                        ),
                                        // SizedBox(width: 20.w,),

                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StoresScreenFav(sellerId: favoriteSeller[position].id!,imgPath: favoriteSeller[position].imgPath!,)));

                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 0.4.sh,
                          width: 1.sw,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: favorites.length,
                            itemBuilder: (context, position) {
                              return Padding(
                                padding:  EdgeInsets.all(20.sp),
                                child: InkWell(
                                  child: Container(
                                    width: 0.9.sw,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.sp),
                                      boxShadow:[
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
                                                image: NetworkImage(AppConstants.MAIN_URL_IMAGE+ favorites[position].mainImage!),
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 30.w,),
                                        Container(
                                          height: 90.h,
                                          width: 0.58.sw,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                favorites[position].name.toString(),
                                                style: TextStyle(fontSize: 24.sp,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                              ),

                                              Text(
                                                favorites[position].title.toString(),
                                                style: TextStyle(fontSize: 12.0,color: Colors.grey),
                                              ),
                                              SizedBox(height: 5.h,),

                                              Row(
                                                children: [
                                                  Text(
                                                    favorites[position].price!+" KWD",
                                                    style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(43, 190, 186, 1),fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 30.w,),
                                                  Padding(
                                                    padding:  EdgeInsets.only(top: 10.h),
                                                    child: Stack(
                                                      children: [
                                                        Text(
                                                          favorites[position].oldPrice!+" KWD",
                                                          style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(224 , 100, 78, 1),fontWeight: FontWeight.bold),
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 30,
                                                          //color: Colors.yellow,
                                                          child: CustomPaint(painter: LinePainter()),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        // SizedBox(width: 70.w,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(child: Icon(CupertinoIcons.xmark_circle,color: Colors.red,),
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
                                                              Text(getTranslated(context, "delete favourite")!,style: TextStyle(color: Colors.red,fontSize: 20.sp),),
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
                                                                    FavoriteService.deleteFromFavorites(context,favorites[position].id.toString()).then((value){
                                                                      log(value.toString());
                                                                      setState(() {
                                                                        if(value == true){
                                                                          loadFavoriteProducts();
                                                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                        }
                                                                      });
                                                                      //log(basket.length.toString());
                                                                    });
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
                                            ),
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
                                        // SizedBox(width: 20.w,),

                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductScreen(Id: favorites[position].id!,catName: getTranslated(context,"Ezhalha")!,)));

                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ]
                      ),
                    )
                  ],
                ),
              )),
            )
        ),
    );
  }
  void loadFavoriteProducts() {
    FavoriteService.getFavoriteProducts(context).then((value) {
      log(value.toString());
      setState(() {
        favorites = value!;
        isLoading = false;
      });
      log(favorites.length.toString());
    });
  }
  void _onRefresh() async{
    setState(() {
      isLoading =true;
    });
    // monitor network fetch
    initawaits();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  void loadFavoriteSellers() {
    FavoriteService.getFavoriteSellers(context).then((value) {
      log(value.toString());
      setState(() {
        favoriteSeller = value!;
        isLoading = false;
      });
      log(favoriteSeller.length.toString());
    });
  }
}
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final p1 = Offset(size.width, 0);
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}