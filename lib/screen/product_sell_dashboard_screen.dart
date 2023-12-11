import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class ProductSellDashboardScreen extends StatefulWidget {
  const ProductSellDashboardScreen({super.key});

  @override
  State<ProductSellDashboardScreen> createState() =>
      _ProductSellDashboardScreenState();
}

class _ProductSellDashboardScreenState
    extends State<ProductSellDashboardScreen> {
  bool _rememberMe = false;
  final items = [
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/rear-left-view-121.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/front-view-118.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/rear-view-119.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/grille-97.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/front-fog-lamp-41.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Sell Dashboard"),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTitleSection(),
                _buildProductSection(),
              ],
            ),
          ),
        ));
  }

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sell your car at",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "the best price",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your card vehicle identification number",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: "(e.g. 1HGBH41JXMN109186)",
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              border: OutlineInputBorder(
                  // borderSide: BorderSide.none
                  ),
            ),
            keyboardType: TextInputType.name,
          ),
          ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              'Sell my car'.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Coming Soon"),
              ));
            },
          ),
          Row(
            children: [
              Expanded(child: Divider()),
              Text(
                " OR ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Divider()),
            ],
          ),
          Text(
            "Select your car brand",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 330,
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 3,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(9, (index) {
                return index != 8
                    ? GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Coming Soon"),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/logos/logo.png")),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Brand name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductSellJourneyScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View All\nBrands",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ));
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 16,
            color: Colors.black45,
          ),
        if (icon != null)
          SizedBox(
            width: 10,
          ),
        Text(
          title,
          style: TextStyle(color: Colors.black45, fontSize: 12),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
