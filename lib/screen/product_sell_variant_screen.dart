import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';

class ProductSellVariantScreen extends StatefulWidget {
  const ProductSellVariantScreen({super.key});

  @override
  State<ProductSellVariantScreen> createState() =>
      _ProductSellVariantScreenState();
}

class _ProductSellVariantScreenState extends State<ProductSellVariantScreen> {
  final data = {
    "Petrol": [
      "Item 1 (A)",
      "Item 2 (A)",
      "Item 3 (A)",
      "Item 4 (A)",
    ],
    "Diesel": [
      "Item 1 (B)",
      "Item 2 (B)",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitleSection(),
            SizedBox(
              height: 10,
            ),
            _buildCategory(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select variant",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      height: 530,
      child: ScrollableListTabView(
        tabHeight: 48,
        tabs: [
          ScrollableListTab(
              tab: ListTab(label: Text('Petrol')),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (_, index) => ListTile(

                  title: Text('xDrive', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )),
          ScrollableListTab(
              tab: ListTab(label: Text('Other')),
              body: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (_, index) => ListTile(
                  title: Text('xDrive BSVI', style: TextStyle(fontWeight: FontWeight.bold),),                ),
              )),
        ],
      ),
    );
  }
}
