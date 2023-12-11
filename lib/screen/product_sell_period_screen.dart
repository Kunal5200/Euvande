import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class ProductSellPeriodScreen extends StatefulWidget {
  const ProductSellPeriodScreen({super.key});

  @override
  State<ProductSellPeriodScreen> createState() =>
      _ProductSellPeriodScreenState();
}

class _ProductSellPeriodScreenState
    extends State<ProductSellPeriodScreen> {

  final yearItems = [
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitleSection(),
            SizedBox(height: 10,),
            _buildSearch(),
            _buildYearListSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffebebeb),
        prefixIcon: Icon(Icons.search_outlined),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: "Search",
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        border: OutlineInputBorder(
          // borderSide: BorderSide.none
        ),
      ),
      keyboardType: TextInputType.name,
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
            "Select the registration year",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildYearListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 450,
          child:  ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: yearItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("  "+yearItems[index], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Divider(thickness: 0.5, color: Colors.black26,),
                    ],
                  ),
                );
              }
          ),
        )
      ],
    );
  }

}
