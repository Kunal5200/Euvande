import 'package:euvande/screen/dashboard_screen.dart';
import 'package:euvande/screen/profile_detail_screen.dart';
import 'package:euvande/screen/registration_screen.dart';
import 'package:euvande/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Gilroy'
            '',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
            .copyWith(
                background: Color(0xfffafcff),
                primary: Colors.black,
                secondary: Colors.black),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    RegistrationScreen(),
    ProfileDetailsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/user.png",
                color: Colors.black54, height: 20, width: 20),
            label: 'profile',
            activeIcon: Image.asset("assets/icons/user.png",
                color: Colors.black, height: 20, width: 20),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
