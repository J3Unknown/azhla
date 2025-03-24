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
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5, // The number of tabs
        (index) => GlobalKey<NavigatorState>(),
  );

  late List<Widget> _screens = [];
  @override
  void initState() {
    super.initState();
    _screens = [
      PageNavigator(screen: const HomeScreen(), navigatorKey: _navigatorKeys[0]),
      PageNavigator(screen: const MyReservations(), navigatorKey: _navigatorKeys[1]),
      PageNavigator(screen: const BasketScreen(), navigatorKey: _navigatorKeys[2]),
      PageNavigator(screen: const FavoriteScreen(), navigatorKey: _navigatorKeys[3]),
      PageNavigator(screen: const SettingScreen(), navigatorKey: _navigatorKeys[4]),
    ];
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
    if (_selectedIndex == index) {
      // Ensure the navigator of the current tab pops to the first route
      _navigatorKeys[_selectedIndex].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }


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
            icon: const Icon(CupertinoIcons.cart),
            // icon: const ImageIcon(
            //   AssetImage("assets/image/basket.png"),
            //   size: 25,
            // ),
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

class PageNavigator extends StatelessWidget {
  final Widget screen;
  final GlobalKey<NavigatorState> navigatorKey;

  const PageNavigator({required this.screen, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => screen,
        );
      },
    );
  }
}
