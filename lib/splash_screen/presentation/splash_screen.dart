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

import 'package:azhlha/buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../welcome_screens/presentation/first_welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the video player
    _controller = VideoPlayerController.asset('assets/image/splashvideo.mp4')
      ..initialize().then((_) {
        // Start playing the video
        _controller.play();

        // Add listener for video completion
        // _controller.addListener(() {
        //   if (_controller.value.position >= _controller.value.duration) {
        //     _navigateToNextScreen(); // Navigate once the video finishes
        //   }
        // });
        _route();


        setState(() {}); // Refresh UI after video initializes
      });
  }
  void _route() {
     //SharedPreferences.getInstance().then((value) => value.setString(AppConstants.USER, "1234567"));
    Timer(Duration(seconds: 5), () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Logged in?
      if(!prefs.containsKey("FirstTime")){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FirstWelcomeScreen()));
      }

        // else if(!prefs.containsKey("token")) {
        //   Navigator.pushReplacement(context, MaterialPageRoute(
        //       builder: (BuildContext context) => ButtomNavBarScreen()));
        // }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (BuildContext context) => ButtomNavBarScreen(intial: 0,)));
        }



      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
    });


  }
  Future<void> _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = !prefs.containsKey("FirstTime");

    if (isFirstTime) {
      // Navigate to FirstWelcomeScreen and mark as visited
      prefs.setBool("FirstTime", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirstWelcomeScreen()),
      );
    } else {
      // Directly navigate to BottomNavBarScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ButtomNavBarScreen(intial: 0),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(), // Show loading indicator
      ),
    );
  }
}
