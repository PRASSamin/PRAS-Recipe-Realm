import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:recipe_realm/activity/credit.dart';
import 'package:recipe_realm/activity/history.dart';
import 'package:recipe_realm/activity/home.dart';
import 'package:recipe_realm/activity/intro.dart';
import 'package:recipe_realm/activity/no-internet.dart';
import 'package:recipe_realm/activity/search.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: ConnectivityWrapper(
        child: Intro(),
      ),
      routes: {
        "/search": (context) => Search(),
      },
    );
  }
}

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        isOnline = result != ConnectivityResult.none;
      });
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isOnline ? widget.child : NoInternet();
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = [
    TabItem(
      Icons.home,
      "Home",
      const Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
    TabItem(
      Icons.search,
      "Search",
      const Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
    ),
    TabItem(
      Icons.history,
      "History",
      const Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
    ),
    TabItem(
      Icons.emoji_emotions,
      "Gratitude",
      const Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600),
    ),
  ];

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            child: _getPage(selectedPos),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget _getPage(int page) {
    switch (page) {
      case 0:
        return const Home();
      case 1:
        return const Search();
      case 2:
        return const History();
      case 3:
        return Credit();
      default:
        return const Home();
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
