import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/component/ProductJourneyTabView.dart';
import 'package:euvande/screen/dashboard_screen.dart';
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
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellJourneyScreen extends StatefulWidget {
  const ProductSellJourneyScreen({super.key});

  @override
  State<ProductSellJourneyScreen> createState() =>
      _ProductSellJourneyScreenState();
}

class _ProductSellJourneyScreenState extends State<ProductSellJourneyScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final tabItems = [
    {
      "title": "Make",
      "desc": "Make",
      "type": "make",
    },
    {
      "title": "Period",
      "desc": "Period",
      "type": "period",
    },
    {
      "title": "Model",
      "desc": "Model",
      "type": "model",
    },
    {
      "title": "Variant",
      "desc": "Variant",
      "type": "variant",
    },
    {
      "title": "Ownership",
      "desc": "Ownership",
      "type": "ownership",
    },
    {
      "title": "Odometer",
      "desc": "Odometer",
      "type": "odometer",
    },
    {
      "title": "Location",
      "desc": "Location",
      "type": "location",
    },
    {
      "title": "Specifications",
      "desc": "Specifications",
      "type": "specifications",
    },
    {
      "title": "Contact Information",
      "desc": "ContactInformation",
      "type": "contactInformation",
    },
    {
      "title": "Photos",
      "desc": "Photos",
      "type": "photos",
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
      case "make":
        return ProductSellBrandsScreen();
      case "period":
        return ProductSellPeriodScreen();
      case "model":
        return ProductSellModelScreen();
      case "variant":
        return ProductSellVariantScreen();
      case "ownership":
        return ProductSellOwnerShipScreen();
      case "odometer":
        return ProductSellOdometerScreen();
      case "location":
        return ProductSellLocationScreen();
      case "specifications":
        return ProductSellSpecificationScreen();
      case "contactInformation":
        return ProductSellContactInfoScreen();
      case "photos":
        return ProductSellVehicleImageUploadScreen();
    }
    
    return Text("n/a");
  }
}
