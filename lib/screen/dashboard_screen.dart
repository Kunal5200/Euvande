import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/image_screen.dart';
import 'package:euvande/screen/product_details_screen.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/used_product_list_screen.dart';
import 'package:euvande/utilities/ProductItemList.dart';
import 'package:euvande/utilities/TitleDescriptionItemList.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<ProductItemList> productItemList  = [];
  List<TitleDescription> howWorksItemList  = [];

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
  void initState() {
    // TODO: implement initState
    super.initState();

    productItemList.add(
        ProductItemList(
            productName: "Mercedes Maybach S",
            productStartPrice: "€ 47899 - € 5000",
            productMaxPrice: "",
            productImageURLs: "assets/images/mercedes/1.jpg")
    );

    productItemList.add(
        ProductItemList(
            productName: "BMW i5",
            productStartPrice: "€ 47899 - € 5000",
            productMaxPrice: "",
            productImageURLs: "assets/images/bmw/1.jpg")
    );

    productItemList.add(
        ProductItemList(
            productName: "Range Rover",
            productStartPrice: "€ 47899 - € 5000",
            productMaxPrice: "",
            productImageURLs: "assets/images/rangerover/1.jpg")
    );

    howWorksItemList.add(TitleDescription(title: "European Dreams, Driven Reality.", description: "Turn your European dreams into reality with the perfect car. Explore iconic destinations, scenic routes, and cityscapes on your terms. Your dream ride awaits.", imageURLs: 'assets/images/placeholder.webp'));
    howWorksItemList.add(TitleDescription(title: "Expert Eyes, Thorough Inspection.", description: "Our expert eyes ensure a meticulous inspection, guaranteeing your peace of mind.", imageURLs: 'assets/images/placeholder.webp'));
    howWorksItemList.add(TitleDescription(title: "Delivered to Your Doorstep.", description: "Experience seamless convenience with our direct-to-your-door delivery service – your dream car, delivered effortlessly to your home.", imageURLs: 'assets/images/placeholder.webp'));

  }

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UsedProductListScreen()),
                        )
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
                _buildHowWorksList(),
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
                _buildProductItem(productItemList[1]),
                _buildProductItem(productItemList[0]),
                _buildProductItem(productItemList[2]),
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
                _buildProductItem(productItemList[2]),
                _buildProductItem(productItemList[1]),
                _buildProductItem(productItemList[0]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(ProductItemList itemList) {
    return GestureDetector(
      onTap: () =>
      {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ProductDetailsScreen()),
        // )
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
                    image: AssetImage(itemList.productImageURLs)),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              itemList.productName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                 ),
            ),
            Text(
              itemList.productStartPrice,
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

  Widget _buildHowWorksItem(TitleDescription itemList) {
    return Container(
      // padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150.0,
            height: 75.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(itemList.imageURLs)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              itemList.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          Text(
            itemList.description,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHowWorksList() {
    return Container(
      color: Color(0xFFF5F7FB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "How does it work",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                _buildHowWorksItem(howWorksItemList[1]),
                _buildHowWorksItem(howWorksItemList[0]),
                _buildHowWorksItem(howWorksItemList[2]),
              ],
            )
          ),

        ],
      ),
    );
  }

}
