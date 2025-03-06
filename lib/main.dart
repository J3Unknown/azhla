import 'dart:async';
import 'dart:developer';

import 'package:azhlha/address_screen/presentation/add_address.dart';
import 'package:azhlha/home_screen/presentation/home_screen.dart';
import 'package:azhlha/payment_screen/presentation/failure_screen.dart';
import 'package:azhlha/payment_screen/presentation/payment_screen.dart';
import 'package:azhlha/payment_screen/presentation/sucess_screen.dart';
import 'package:azhlha/product_screen/presentation/product_screen.dart';
import 'package:azhlha/profile_screen/presentation/profile_screen.dart';
import 'package:azhlha/setting_screen/presentation/setting_screen.dart';
import 'package:azhlha/sign_in_screen/presentation/sign_in_screen.dart';
import 'package:azhlha/sign_up_screen/presentation/sign_up_screen.dart';
import 'package:azhlha/social_login_screen/presentation/social_login_screen.dart';
import 'package:azhlha/splash_screen/presentation/splash_screen.dart';
import 'package:azhlha/stores_screen/presentation/stores_screen.dart';
import 'package:azhlha/utill/app_localization.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:azhlha/welcome_screens/presentation/first_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'address_screen/presentation/address_screen.dart';
import 'basket_screen/presentation/basket_screen.dart';
import 'buttom_nav_bar/presentation/buttom_nav_screen.dart';
import 'categories_screen/presentation/categories_screen.dart';
import 'contatct_us_screen/presentation/contact_us_screen.dart';
import 'date_time_screen/presentation/date_time_screen.dart';
import 'events_screen/presentation/add_events.dart';
import 'events_screen/presentation/events_screen.dart';
import 'forget_password_screen/presentation/forget_password_screen.dart';
import 'my_reservations/presentation/my_reservations.dart';
import 'otp_screen/presentation/otp_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // One Signal
  //Remove this method to stop OneSignal Debugging

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("dd3cdd89-0c51-4e25-98ca-5b131a25044a");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
    log("setNotificationWillShowInForegroundHandler");
  });


  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    String userLanguage = "ar"; // Replace with your logic to get the user's language preference

    // Get the notification content for the user's language
    String notificationContent = event.notification.rawPayload!['contents'][userLanguage];
    log("test noti : "+notificationContent.toString());
    // Get the notification title for the user's language
    String notificationTitle = event.notification.rawPayload!['headings'][userLanguage];
    //event.notification.title = notificationTitle;
    //event.notification.body = notificationContent;
    log("omar");
    event.complete(event.notification);
    log("setNotificationWillShowInForegroundHandler");
  });



  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
    log("setSubscriptionObserver");
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
    String? onesignalUserId = changes.to.userId;
    //log("setSubscriptionObserver");
    SharedPreferences.getInstance().then((value){
      log("Shared Prefs");
      value.setString("device_token",onesignalUserId!);
      value.setString("notification_token",onesignalUserId!);
      //value.setString("first_time","First Time ");
      if(value.containsKey("notification_token")) log("Et5zn");
      // log("PREFS " + value.getString("device_token")!);
      // log("Stored");
      // log("Token " + onesignalUserId);
    });
  });

  // OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //   _MyHomePageState.handleClickNotification(result);
  //   log("Opened");
  // });
  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });
  OneSignal.shared.getDeviceState().then((deviceState) {
    print("DeviceState: ${deviceState?.jsonRepresentation()}");
    SharedPreferences.getInstance().then((value){
      value.setString("device_token",deviceState!.userId!);
      log("device Token " + deviceState.userId!);
    });
    //log(deviceState!.pushToken!);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyHomePageState? state = context.findAncestorStateOfType<_MyHomePageState>();
    state!.setLocale(newLocale);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription _sub;

  //static final navigatorKey = new GlobalKey<NavigatorState>();
  Locale? _locale;
  static final navKey = new GlobalKey<NavigatorState>();

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //This function is responsible of getting the default language and if it is null (First time opening the app), it will be assigned to 'en'
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (this._locale == null) {
      return Container(
          child: Center(
            child: Container(),
          ));
    }
    else {
      return ScreenUtilInit(
        designSize: Size(390, 800), // Change depending on the XD
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            locale: _locale,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocaleLanguage in supportedLocales) {
                if (supportedLocaleLanguage.languageCode ==
                    locale!.languageCode &&
                    supportedLocaleLanguage.countryCode == locale.countryCode) {
                  return supportedLocaleLanguage;
                }
              }
            },
            // OR Locale('ar', 'AE') OR Other RTL locales,
            theme: ThemeData(
                primaryColor: Colors.blue,
                textTheme: TextTheme(button: TextStyle(fontSize: 18.sp)),
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(
                        color: Colors.black
                    )
                )
            ),
            builder: (context, widget) {
              // ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },

            // home:  MyAppPPP(),
            home: SplashScreen(),
            // home: ChangeNotifierProvider<UnitsPurchaseProvider>.value(
            //   value: sl<UnitsPurchaseProvider>(),
            //   child: UnitsPurchaseScreen(),
            // )
          );
        },
      );
    }
  }
}
