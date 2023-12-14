import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/component/ProductJourneyTabView.dart';
import 'package:euvande/screen/dashboard_screen.dart';
import 'package:euvande/screen/product_auction_info_screen.dart';
import 'package:euvande/screen/product_sell_brands_screen.dart';
import 'package:euvande/screen/product_sell_contact_info_screen.dart';
import 'package:euvande/screen/product_sell_location_screen.dart';
import 'package:euvande/screen/product_sell_model_screen.dart';
import 'package:euvande/screen/product_sell_odometer_screen.dart';
import 'package:euvande/screen/product_sell_ownership_screen.dart';
import 'package:euvande/screen/product_sell_period_screen.dart';
import 'package:euvande/screen/product_sell_specification_screen.dart';
import 'package:euvande/screen/product_sell_variant_screen.dart';
import 'package:euvande/screen/product_sell_vehicle_image_upload_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class ProductAuctionDashboardScreen extends StatefulWidget {
  const ProductAuctionDashboardScreen({super.key});

  @override
  State<ProductAuctionDashboardScreen> createState() =>
      _ProductAuctionDashboardScreenState();
}

class _ProductAuctionDashboardScreenState
    extends State<ProductAuctionDashboardScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final tabItems = [
    {
      "title": "Auction confirmation",
      "desc": "Auction confirmation",
      "type": "auctionCnf",
    },
    {
      "title": "Auction",
      "desc": "Auction",
      "type": "auction",
    },
    {
      "title": "Car Sale",
      "desc": "Car Sale",
      "type": "carSale",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Sell Dashboard"),
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 1,
              controller: _tabController,
              tabs: tabItems
                  .map((e) => Container(
                        padding: EdgeInsets.all(20),
                        child: Text(e["title"].toString()),
                      ))
                  .toList()),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabItems.map((e) => getScreen(e)).toList(),
        ));
  }

  Widget getScreen(Map<String, String> e) {
    switch (e["type"]) {
      case "auctionCnf":
        return ProductAuctionInfoScreen();
      case "auction":
        return ProductSellPeriodScreen();
      case "carSale":
        return ProductSellModelScreen();
    }

    return Text("n/a");
  }
}
