import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_screen/presentation/home_screen.dart';
import '../../basket_screen/presentation/basket_screen.dart';
import '../../favourite_screen/presentation/favorite_screen.dart';
import '../../my_reservations/presentation/my_reservations.dart';
import '../../setting_screen/presentation/setting_screen.dart';
import '../../utill/colors_manager.dart';
import '../../utill/localization_helper.dart';

class ButtomNavBarScreen extends StatefulWidget {
  late int intial;
  ButtomNavBarScreen({Key? key, required this.intial}) : super(key: key);

  @override
  _ButtomNavBarScreenState createState() => _ButtomNavBarScreenState();
}

class _ButtomNavBarScreenState extends State<ButtomNavBarScreen> {
  late int _selectedIndex;
  String token = '';

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.intial;
    initToken();
  }

  void initToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      setState(() {
        token = prefs.getString("token")!;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    PageNavigator(screen: const HomeScreen()),
    PageNavigator(screen: const MyReservations()),
    PageNavigator(screen: const BasketScreen()),
    PageNavigator(screen: const FavoriteScreen()),
    PageNavigator(screen: const SettingScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Only shows the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: CupertinoColors.systemGrey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home),
            label: getTranslated(context, "Home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.calendar),
            label: getTranslated(context, "Reservations"),
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage("assets/image/basket.png"),
              size: 25,
            ),
            label: getTranslated(context, "Basket"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.heart),
            label: getTranslated(context, "Favorite"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.line_horizontal_3_decrease),
            label: getTranslated(context, "More"),
          ),
        ],
      ),
    );
  }
}

class PageNavigator extends StatefulWidget {
  final Widget screen;
  PageNavigator({required this.screen});

  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  late GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _navigatorKey = GlobalKey<NavigatorState>();
    print("InitState called for ${widget.screen.runtimeType}"); // Debugging
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => widget.screen,
        );
      },
    );
  }
}