import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationDetailsScreen extends StatefulWidget {
  late String name;
  late String disc;
  late String updatedAt;
   NotificationDetailsScreen({Key? key,required this.name ,required this.disc,required this.updatedAt}) : super(key: key);

  @override
  _NotificationDetailsScreenState createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
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
      )),
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 20.h,),

            Container(
              height: 70.h,
              width: 70.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  image: DecorationImage(
                      image: AssetImage("assets/image/1024.png")
                  )
              ),
            ),
            SizedBox(height: 20.h,),

            Text(widget.name,style: TextStyle(fontSize: 24.sp,color:Color.fromRGBO(13, 24, 99, 1)),),
            SizedBox(height: 200.h,),
            Text(widget.disc,style: TextStyle(fontSize: 24.sp,color:Color.fromRGBO(13, 24, 99, 1)),),

          ],
        ),
      ),
    );
  }
}
