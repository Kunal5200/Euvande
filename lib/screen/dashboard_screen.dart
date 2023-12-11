import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_details_screen.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final items = [
    Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(
              "https://storage.pixteller.com/designs/designs-images/2020-12-21/04/rent-a-car-sale-banner-1-5fe0b5604db74.png"),
          fit: BoxFit.fill,
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(
              "https://storage.pixteller.com/designs/designs-images/2020-12-21/04/rent-a-car-sale-banner-1-5fe0b5604db74.png"),
          fit: BoxFit.fill,
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(
              "https://storage.pixteller.com/designs/designs-images/2020-12-21/04/rent-a-car-sale-banner-1-5fe0b5604db74.png"),
          fit: BoxFit.fill,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              // horizontal: 40.0,
              // vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSearch(),
                _buildCarouselSlider(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _buildSellPurchase(
                          () =>
                      {
                      },
                      AssetImage("assets/icons/car.png"),
                      "Buy Used Car",
                      "pre-owned car for sale →",
                      Colors.green[100]),
                  SizedBox(
                    width: 10,
                  ),
                  _buildSellPurchase(() => {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductSellDashboardScreen()),
                  )
                  }, AssetImage("assets/icons/car.png"),
                      "Sell Car", "from your home", Colors.blue[100])
                ]),
                SizedBox(
                  height: 10,
                ),
                _buildPopularProductList(),
                _buildUsedProductList(),
              ],
            ),
          ),
        ));
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        // border: Border.all(
        //   // color: Colors.black12,
        // ),
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black54,
          ),
          SizedBox(width: 10.0),
          Text(
            "Search Cars",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
      ),
      itemCount: this.items.length,
      itemBuilder: (context, itemIndex, realIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: items[itemIndex],
        );
      },
    );
  }

  Widget _buildSellPurchase(var onTap, AssetImage logo, String title,
      String subTitle, Color? bgColor) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: bgColor,
              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2 - 25,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(subTitle,
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 10)),
                  Image(
                    image: logo,
                    height: 80,
                    width: 80,
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildPopularProductList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "Popular new cars",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 180,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildProductItem(),
                _buildProductItem(),
                _buildProductItem(),
                _buildProductItem(),
                _buildProductItem(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildUsedProductList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "Trusted used cars",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 180,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildProductItem(),
                _buildProductItem(),
                _buildProductItem(),
                _buildProductItem(),
                _buildProductItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem() {
    return GestureDetector(
      onTap: () =>
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailsScreen()),
        )
      },
      child: Container(
        width: 170,
        // padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/imgCar1.png")),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.redAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Mercedes Maybach S",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                 ),
            ),
            Text(
              "€ 1.25 - €2.45 lakh",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Click to check",
              style: TextStyle(
                color: Colors.blueAccent[200],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
