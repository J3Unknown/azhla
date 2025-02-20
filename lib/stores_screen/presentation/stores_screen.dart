import 'dart:developer';

import 'package:azhlha/product_screen/presentation/product_screen.dart';
import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/stores_screen/domain/stores_service.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../basket_screen/presentation/basket_screen.dart';
import '../../utill/localization_helper.dart';
import '../data/stores_object.dart';

class StoresScreen extends StatefulWidget {
  late int categoryId;
  late int sellerId;
  late String imgPath;
  late String catName;
  late String date;

   StoresScreen({Key? key,required this.categoryId,required this.catName,required this.sellerId,required this.imgPath,required this.date}) : super(key: key);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  List<StoresObject> stores = [];
  List<StoresObject> mostSelling = [];
  bool isLoading =true;
  List <int> allList=[];
  List <dynamic>? intList;
  @override
  void initState() {
    loadData();
    loadMostData();
    loadDataFav();
    // TODO: implement initState
    super.initState();
  }
  void loadDataFav() async{
    isLoading = true;
    allList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("token")) {
      StoresService.getFav(context).then((value) {
        log(value.toString());
        setState(() {
          intList = value!;
          log("intList!.length.toString()"+intList!.length.toString());
          for (int i = 0; i < stores.length; i++) {
            int temp = 0;
            for (int j = 0; j < intList!.length; j++) {
              if (stores[i].id == intList![j]) {
                temp = 1;
              }
            }
            allList.add(temp);
          }
        });
        log(intList!.length.toString());
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){
          Navigator.pop(context);
        },),
        title:  Text(widget.catName,style: TextStyle(color: Color.fromRGBO(170, 143, 10, 1),fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        // actions: [InkWell(child:Icon(CupertinoIcons.search),),
        //   SizedBox(width: 10.w,)
        // ],
        backgroundColor: Colors.white,
      ),
      body:
    LoadingOverlay(
    progressIndicator: SpinKitSpinningLines(
    color: Color.fromRGBO(254, 222, 0, 1),
    ),
    color: Color.fromRGBO(254, 222, 0, 0.1),
    isLoading: isLoading,
    child: isLoading == true
    ? Container():
      (stores.length != 0)?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h,),
          Center(
            child: Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.sp),

                  image: DecorationImage(

                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+widget.imgPath),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ),
          SizedBox(height: 5.h,),
          Padding(
            padding: EdgeInsets.only(left: 10.w,right: 10.w),
            child: Container(
              width: 0.9.sw,
              height: 30.h,
              child: Text(getTranslated(context, "Most Selling")!,style: TextStyle(fontSize: 20.sp,


                // overflow: TextOverflow.ellipsis, // Adds ellipsis if the text overflows
              ),
              ),
            ),
          ),
          SizedBox(height: 5.h,),
          Center(
            child: Container(
              height: 185.h,
              width: 0.9.sw,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mostSelling.length,
                itemBuilder: (context, position) {
                  return Padding(
                    padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h,bottom: 10.h),
                    child: InkWell(
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.sp),
                          boxShadow:[
                            BoxShadow(
                              color: Color.fromRGBO(170, 143, 10, 1),
                              blurRadius: 2,
                            ),
                          ],

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                            //   child: InkWell(child:(allList.isNotEmpty&&allList[position] == 1)? Icon(CupertinoIcons.heart_solid ,size: 30.sp,color:Colors.red):Icon(CupertinoIcons.heart ,size: 30.sp,color: Color.fromRGBO(170, 143, 10, 1),),
                            //     onTap: (){
                            //       if(allList.isEmpty ||allList![position] == 0  ) {
                            //         StoresService.AddProductFav(context,
                            //             stores[position].id.toString()).then((
                            //             value) {
                            //           log("Value"+value.toString());
                            //           setState(() {
                            //             if (value == true) {
                            //               loadDataFav();
                            //             }
                            //           });
                            //           //log(basket.length.toString());
                            //         });
                            //       }
                            //       else{
                            //         StoresService.deleteProductFav(context,
                            //             stores[position].id.toString()).then((
                            //             value) {
                            //           log(value.toString());
                            //           setState(() {
                            //             log("Value"+value.toString());
                            //             if (value == true) {
                            //               loadDataFav();
                            //             }
                            //           });
                            //           //log(basket.length.toString());
                            //         });
                            //       }
                            //
                            //     },
                            //   ),
                            // ),
                            SizedBox(height: 10.h,),
                            Center(
                              child: Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(40.sp),
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstants.MAIN_URL_IMAGE+mostSelling[position].mainImage!),
                                      fit: BoxFit.contain
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h,),
                            Center(
                              child: Text(
                                mostSelling[position].name!,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            // Padding(
                            //   padding:  EdgeInsets.only(right: 15.w),
                            //   child: Text(
                            //     mostSelling[position].title!,
                            //     style: TextStyle(fontSize: 15.0,color: Colors.grey),
                            //   ),
                            // ),
                            //
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       height:20.h,
                            //       width: 100.w,
                            //       child: Text(
                            //        "1500 KWD",
                            //         style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(21, 62, 115, 1),fontWeight: FontWeight.bold),
                            //       ),
                            //     ),
                            //     InkWell(child: Icon(
                            //         CupertinoIcons.forward
                            //     ),)
                            //   ],
                            // ),

                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductScreen(Id: stores[position].id!,catName: widget.catName,)));

                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5.h,),
          Padding(
            padding:  EdgeInsets.only(left: 10.w,right: 10.w),
            child: Text(getTranslated(context, "Packages")!,style: TextStyle(fontSize: 20.sp),),
          ),
          SingleChildScrollView(
            child: Container(
              height: 0.39.sh,
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
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: stores.length,
                itemBuilder: (context, position) {
                  return Padding(
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                    child: InkWell(
                      child: Container(
                        width: 0.75.sw,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),

                          boxShadow:[
                            BoxShadow(
                              color: Color.fromRGBO(170, 143, 10, 1),
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
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstants.MAIN_URL_IMAGE+stores![position].mainImage!),
                                  ),
                                  borderRadius: BorderRadius.circular(30.sp),
                                  border: Border.all(
                                      color: Color.fromRGBO(170, 143, 10, 1)
                                  )
                              ),
                            ),
                            SizedBox(width: 30.w,),
                            Container(
                              height: 150.h,
                              width: 200.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    stores![position].name!,
                                    style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(13, 24, 99, 1),fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Text(
                                    stores![position].title!,
                                    style: TextStyle(fontSize: 12.0,color: Colors.grey),
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    children: [
                                      Text(
                                        stores![position].price!+" KWD",
                                        style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(43 , 190, 186, 1),fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 30.w,),
                                      Padding(
                                        padding:  EdgeInsets.only(top: 10.h),
                                        child: Stack(
                                          children: [
                                            Text(
                                              stores![position].oldPrice!+" KWD",
                                              style: TextStyle(fontSize: 15.0,color: Color.fromRGBO(224 , 100, 78, 1),fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 30,
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
                            SizedBox(width: 20.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(child: (allList.isNotEmpty&&allList[position] == 1)? Icon(CupertinoIcons.heart_solid ,size: 30.sp,color:Colors.red):Icon(CupertinoIcons.heart ,size: 30.sp,color: Color.fromRGBO(170, 143, 10, 1),),
                                  onTap: () async{
                                    log("here from fav");
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    if(prefs.containsKey("token")) {
                                    if(allList.isEmpty ||allList![position] == 0  ) {
                                      log("add to fav");
                                      StoresService.AddProductFav(context,
                                          stores[position].id.toString()).then((
                                          value) {
                                        log("Value"+value.toString());
                                        setState(() {
                                          if (value == true) {
                                            loadDataFav();
                                          }
                                        });
                                        //log(basket.length.toString());
                                      });
                                    }
                                    else{
                                      log("delete from fav");
                                      StoresService.deleteProductFav(context,
                                          stores[position].id.toString()).then((
                                          value) {
                                        log(value.toString());
                                        setState(() {
                                          log("Value"+value.toString());
                                          if (value == true) {
                                            loadDataFav();
                                          }
                                        });
                                        //log(basket.length.toString());
                                      });
                                    }

                                    }else{
                                      showToastLogin(context,getTranslated(context, "please login")!);

                                    }

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
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductScreen(Id: stores[position].id!,catName: widget.catName)));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          // SizedBox(height: 15.h,),
          // Padding(
          //   padding:  EdgeInsets.only(left: 300.w),
          //   child: InkWell(
          //     child: Container(
          //       height: 80.h,
          //       width: 80.w,
          //       decoration: BoxDecoration(
          //         color: Color.fromRGBO(175, 147, 92, 1),
          //         borderRadius: BorderRadius.circular(100.sp),
          //         // image: DecorationImage(
          //         //   image: AssetImage("assets/image/cart.png"),
          //         //   fit: BoxFit.contain
          //         // )
          //       ),
          //       child: Padding(
          //         padding:  EdgeInsets.all(10.sp),
          //         child: Image(
          //           image: AssetImage("assets/image/cart.png"),
          //         ),
          //       ),
          //     ),
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BasketScreen()));
          //
          //     },
          //   ),
          // ),
          // SizedBox(height: 30.h,)
        ],
      ): Center(
        child: Container(
            width: 1.sw,
            height: 50.h,
            child: Center(child: FittedBox(
              fit: BoxFit.scaleDown, // Scale text down if needed

              child: Text(getTranslated(context, "the product of the seller will be added soon")!,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
                // softWrap: false, // Disable word wrapping
                textAlign: TextAlign.center, // Center align text
              ),
            )
            )),

      ),
    ));
  }


  void loadData(){
    StoresService.store(context,widget.categoryId,widget.sellerId,widget.date).then((value){
      log(value.toString());
      setState(() {
        stores = value!;
        isLoading =false;

      });
      log(stores.length.toString());
    });
  }
  void loadMostData(){
    StoresService.storeMost(context,widget.categoryId,widget.sellerId,widget.date).then((value){
      log(value.toString());
      setState(() {
        mostSelling = value!;
      });
      log(mostSelling.length.toString());
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