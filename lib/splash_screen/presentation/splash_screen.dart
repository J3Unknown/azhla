// import 'dart:async';
//
// import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
// import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
// import 'package:azhlha/welcome_screens/presentation/first_welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../utill/app_constants.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
//   bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     initawaits();
//   }
//   void initawaits ()async{
//     await Future.delayed(const Duration(seconds: 3));
//     setState(() {
//       isLoading = false;
//     });
//     _route();
//   }
//   void _route() {
//      //SharedPreferences.getInstance().then((value) => value.setString(AppConstants.USER, "1234567"));
//     Timer(Duration(seconds: 3), () async{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       // Logged in?
//       if(!prefs.containsKey("FirstTime")){
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FirstWelcomeScreen()));
//       }
//
//         // else if(!prefs.containsKey("token")) {
//         //   Navigator.pushReplacement(context, MaterialPageRoute(
//         //       builder: (BuildContext context) => ButtomNavBarScreen()));
//         // }
//         else{
//           Navigator.pushReplacement(context, MaterialPageRoute(
//               builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
//         }
//
//
//
//       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
//     });
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _globalKey,
//       body:LoadingOverlay(
//           progressIndicator: SpinKitSpinningLines(
//             color: Color.fromRGBO(254, 222, 0, 1),
//           ),
//           color: Color.fromRGBO(254, 222, 0, 0.1),
//           isLoading: isLoading,
//           child: isLoading == true
//               ? Container():
//       Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/image/Splash.jpeg"),
//
//             fit: BoxFit.contain,
//           ),
//
//         ),
//       )),
//     );
//   }
// }
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'package:azhlha/utill/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../welcome_screens/presentation/first_welcome_screen.dart';
import '../../welcome_screens/presentation/onBoarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late FlutterGifController _gifController;
  final int totalFrames = 24;
  final double frameRate = 12;
  @override
  void initState() {
    super.initState();
    _gifController = FlutterGifController(vsync: this);

    double gifDuration = totalFrames / frameRate;

    _gifController.repeat(
      min: 0,
      max: totalFrames.toDouble(),
      period: Duration(milliseconds: (gifDuration * 1000).toInt()), // Match the GIF duration
    );

    _route(gifDuration);
  }

  void _route(double delaySeconds) {
    Timer(Duration(milliseconds: (delaySeconds * 1000).toInt()), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("FirstTime")) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => OnBoarding()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width:double.infinity,
          height: double.infinity,
          child: GifImage(
            fit: BoxFit.cover,
            controller: _gifController,
            image: const AssetImage(imagePath + AssetsManager.splash),
          ),
        ),
      ),
    );
  }
}

