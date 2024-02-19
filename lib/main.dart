import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/dashboard_screen.dart';
import 'package:euvande/screen/login_screen.dart';
import 'package:euvande/screen/profile_detail_screen.dart';
import 'package:euvande/screen/splash_screen.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:flutter/material.dart';

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
      builder: (context, child) {
        // this is the key
        return GestureDetector( behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late LoginResponseModel? loginResponseModel;

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ProfileDetailsScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1 && loginResponseModel == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPrefManager.getLoginData().then((value) => {
          setState(() {
            loginResponseModel = value;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print(_selectedIndex);

        if(_selectedIndex==0){
          return true;
        }else {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
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
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/user.png",
                  color: Colors.black54, height: 20, width: 20),
              label: 'Profile',
              activeIcon: Image.asset("assets/icons/user.png",
                  color: Colors.black, height: 20, width: 20),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
