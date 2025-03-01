import 'package:azhlha/basket_screen/presentation/basket_screen.dart';
import 'package:azhlha/favourite_screen/presentation/favorite_screen.dart';
import 'package:azhlha/my_reservations/presentation/my_reservations.dart';
import 'package:azhlha/setting_screen/presentation/setting_screen.dart';
import 'package:azhlha/shared/alerts.dart';
import 'package:azhlha/utill/app_constants.dart';
import 'package:azhlha/utill/localization_helper.dart';
import 'package:azhlha/welcome_screens/presentation/first_welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_screen/presentation/home_screen.dart';
import '../../utill/colors_manager.dart';

class ButtomNavBarScreen extends StatefulWidget {
  late int intial;
  ButtomNavBarScreen({Key? key,required this.intial}) : super(key: key);

  @override
  _ButtomNavBarScreenState createState() => _ButtomNavBarScreenState();
}

class _ButtomNavBarScreenState extends State<ButtomNavBarScreen>  with AutomaticKeepAliveClientMixin<ButtomNavBarScreen>{
  final PersistentTabController _controller  = PersistentTabController(initialIndex: 0);

  String token = '';

@override
  void initState() {
  _controller.jumpToTab(widget.intial);
  initawaits();
    // TODO: implement initState
    super.initState();
  }
  void initawaits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(AppConstants.TOKEN)) {
      token = prefs.getString(AppConstants.TOKEN)!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: ColorsManager.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: ColorsManager.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property.
    );
  }
  @override
  bool get wantKeepAlive => true; // ** and here
  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      MyReservations(),
      BasketScreen(),
      FavoriteScreen(),
      SettingScreen(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: (getTranslated(context, "Home")!),
        activeColorPrimary: ColorsManager.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.calendar),
        title: (getTranslated(context, "Reservations")!),
        activeColorPrimary: ColorsManager.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:Icon(Icons.shopping_cart_outlined),
        title: (getTranslated(context, "Basket")!),
        activeColorPrimary: ColorsManager.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.heart),
        title: (getTranslated(context, "Favorite")!),
        activeColorPrimary: ColorsManager.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
        title: (getTranslated(context, "More")),
        activeColorPrimary: ColorsManager.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
