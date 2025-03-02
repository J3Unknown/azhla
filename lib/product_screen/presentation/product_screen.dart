import 'dart:developer';

import 'package:azhlha/product_screen/domain/product_service.dart';
import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import '../../basket_screen/domain/basket_service.dart';
import '../../shared/alerts.dart';
import '../../stores_screen/domain/stores_service.dart';
import '../../utill/colors_manager.dart';
import '../data/product_object.dart';

class ProductScreen extends StatefulWidget {
  late int Id;
  late String catName;
  // late int fav;
  ProductScreen({Key? key,required this.Id,required this.catName}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int index =0;
  bool? checkBoxValue = false;
  ProductDetails productDetails = ProductDetails();
  bool isLoading = true;
  List<bool> checkBoxValues=[];
  List<ExtraServicesRequest> request = [];
  String token = '';
  late int favourite ;
  List <dynamic>? intList;

  void initawaits() async{

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
        leading: InkWell(child:Icon(CupertinoIcons.back),onTap: (){Navigator.pop(context);},),
        title:  Text(widget.catName,style: TextStyle(color: ColorsManager.primary,fontSize: 22.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [InkWell(child:Icon(Icons.share),
          onTap: () async{
            ShareResult shareResult;
          await Share.share("https://rechiste.com");
          },
        ),
          SizedBox(width: 10.w,)
        ],
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
          ? Container()

          : SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: productDetails.images!.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Stack(
                    children: [
                      Container(
                        height: 250.h,
                        width: 1.sw,
                        child: Column(
                          children: [
                            Container(
                              height: 200.h,
                              width: 1.sw,
                              decoration: BoxDecoration(

                                border: Border.all(
                                  color: ColorsManager.primary,
                                ),
                                  //color: Colors.black87,
                                  image: DecorationImage(
                                    image:NetworkImage(AppConstants.MAIN_URL_IMAGE+productDetails.images![itemIndex].name!),
                                    fit: BoxFit.fill
                                  )
                              ),

                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 15.w,
                          child: InkWell(
                            child: Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.sp)
                                ),
                                child: Center(child: (favourite == 1)?Icon(CupertinoIcons.heart_solid ,size: 30.sp,color:Colors.red):Icon(CupertinoIcons.heart ,size: 30.sp,color: ColorsManager.primary))),
                            onTap: ()async{
                              log("here from fav");
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(prefs.containsKey("token")) {
                                if(favourite == 0  ) {
                                  log("add to fav");
                                  StoresService.AddProductFav(context,
                                      productDetails.id.toString()).then((
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
                                      productDetails.id.toString()).then((
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
                              }
                              else{
                                showToastLogin(context,getTranslated(context, "please login")!);

                              }

                            },
                          ))
                    ],
                  ),
              options: CarouselOptions(
              onPageChanged: (pageIndex,reason){
                setState(() {
                  log(pageIndex.toString());
                  index = pageIndex;
                });
              },
              autoPlay: false,
              viewportFraction: 1,
              initialPage: 0,
            ),
            ),
            SizedBox(height: 5.h,),
            AnimatedSmoothIndicator(
              activeIndex: index,
              count: productDetails.images!.length,
              effect: SlideEffect(
                  activeDotColor: ColorsManager.primary,
                  dotWidth:25.w,
                  dotHeight:5.h
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 280.h,
              width: 0.9.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.sp),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primary,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 5,
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top:10.h,left: 10.w,right: 10.w),
                    child: Text( productDetails.name!,style: TextStyle(fontSize: 20.sp,color: Color.fromRGBO(99, 69, 69, 1)),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:10.h,left: 10.w,right: 10.w),
                    child: Text("Serving",style: TextStyle(fontSize: 15.sp,color: Color.fromRGBO(99, 69, 69, 1)),),
                  ),
                  Container(
                    height: 70.h,
                    width: 0.8.sw,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:10.h,left: 10.w,right: 10.w),
                            child: Text(getTranslated(context, "Details")!,style: TextStyle(fontSize: 20.sp,color: Color.fromRGBO(99, 69, 69, 1)),),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top:5.h,left: 10.w,right: 10.w),
                            child: ExpandableText(productDetails.description!),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Center(
                    child: Container(
                      height: 1.h,
                      width: 0.8.sw,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:10.h,left: 10.w,right: 10.w),
                    child: Text(getTranslated(context, "Extra Services (Paid)")!,style: TextStyle(fontSize: 15.sp,color: Color.fromRGBO(99, 69, 69, 1)),),
                  ),
                  Container(
                    height: 80.h,
                    width: 0.9.sw,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productDetails.extraServices!.length,
                    itemBuilder: (context, position) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(width:10.w),
                          Container(
                              height: 20.h,
                              width:0.65.sw,
                              child: Text(productDetails.extraServices![position].descriptionEn!,style: TextStyle(color:Color.fromRGBO(99, 69, 69, 1)),)),
                          SizedBox(width:30.w),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor:Color.fromRGBO(99, 69, 69, 1),
                            value: checkBoxValues[position],
                            onChanged: (bool? newValue){
                              setState(() {
                                checkBoxValues[position] = newValue!;
                                if(newValue == true){
                                  ExtraServicesRequest extra = ExtraServicesRequest();
                                  extra.id = productDetails.extraServices![position].id;

                                  request.add(extra);
                                }
                                else if(newValue == false){
                                  for(int i =0 ;i<request.length;i++)
                                    {
                                      if(request[i].id == productDetails.extraServices![position].id)
                                        {
                                          request.removeAt(i);
                                        }
                                    }
                                }

                              });
                            },

                          ),
                        ],
                      );
                    }),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslated(context, "Total")!,style: (TextStyle(fontSize: 20.sp)),),
                SizedBox(width: 150.w,),
                Text("${productDetails.price} KWD",style: TextStyle(color: Colors.red,fontSize: 20.sp),)
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
                  child: Center(child: Text( getTranslated(context, "Purchase")!,style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
                ),
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if(prefs.containsKey("token")) {
                    BasketService.addToBasket(context,productDetails.id.toString(),request).then((value){
                      log(value.toString());
                      setState(() {
                        if(value == true){
                          //showToast(context,"done");
                          // loadData();
                        }
                      });
                      //log(basket.length.toString());
                    });
                    token = prefs.getString("token")!;
                  }else{
                    setState(() {
                      // isLoading = false;
                    });
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignInScreen(signUp: 'test',)));
                  }

                },
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    )
    );
  }
  void loadData(){
    ProductService.product(context,widget.Id).then((value){
      log(value.toString());
      setState(() {
        productDetails = value!;
        for(int i =0 ;i<productDetails.extraServices!.length;i++){
          checkBoxValues.add(false);
        }
        loadDataFav();
      });
      log(productDetails.name.toString());
    });
  }
  void loadDataFav() async{
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favourite = 0;

    if(prefs.containsKey("token")) {
      StoresService.getFav(context).then((value) {
        log(value.toString());
        setState(() {
          intList = value!;
          log("intList!.length.toString()"+intList!.length.toString());
          for (int i = 0; i < intList!.length; i++) {
            if(productDetails.id.toString() == intList![i].toString())
              {
                log(intList![i].toString() +" : " +productDetails.id.toString());

                  favourite = 1;
              }
            int temp = 0;

            // allList.add(temp);
          }
        });
        log(intList!.length.toString());
      });
    }
    setState(() {
      isLoading = false;

    });
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
      this.text, {
        Key? key,
        this.trimLines = 2,
      })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,//better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore
                ? widget.text.substring(0, endIndex)
                : widget.text,
            style: TextStyle(
              color: widgetColor,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
