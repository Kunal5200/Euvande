import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:flutter/material.dart';

class ProductSellOdometerScreen extends StatefulWidget {
  const ProductSellOdometerScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellOdometerScreen> createState() =>
      _ProductSellOdometerScreenState();
}

class _ProductSellOdometerScreenState extends State<ProductSellOdometerScreen> {
  final items = [
    "0-10000",
    "10000-20000",
    "20000-30000",
    "30000-40000",
    "40000-50000",
    "50000-60000",
    "60000-70000",
    "70000-80000",
    "80000-90000",
    "90000-100000",
    "More than 100000",
  ];

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
            "Select car kilometers driven",
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
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector( behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.onNext(items[index]);
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  " + items[index] + " Kilometers ${(ProductSellDashboardScreen
                                .getPendingCarsResponseModel != null &&
                                ProductSellDashboardScreen
                                    .getPendingCarsResponseModel!.data.length > 0
                                && ProductSellDashboardScreen
                                    .getPendingCarsResponseModel!.data[0]
                                    .odometer.toLowerCase() == items[index]
                                    .toLowerCase()) ?
                            " ✓" : ""}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ));
              }),
        )
      ],
    );
  }
}
