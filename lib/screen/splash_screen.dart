import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/main.dart';
import 'package:euvande/screen/image_screen.dart';
import 'package:euvande/screen/product_details_screen.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/utilities/ProductItemList.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MyHomePage(title: "Title"),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;

            },
          )
      );
      // MaterialPageRoute(builder: (context) => const MyHomePage(title: "Title"),)

    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: OverflowBox(
                minHeight: 200,
                maxHeight: 200,
                child: Lottie.asset(
                  'assets/lottie/1.json',
                )
            )
        )
    );
  }
}
