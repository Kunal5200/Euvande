import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:flutter/material.dart';

class ProductSellOwnerShipScreen extends StatefulWidget {
  const ProductSellOwnerShipScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellOwnerShipScreen> createState() =>
      _ProductSellOwnerShipScreenState();
}

class _ProductSellOwnerShipScreenState
    extends State<ProductSellOwnerShipScreen> {

  final items = [
    "1st",
    "2nd",
    "3rd",
    "4th",
    "5th",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
            _buildYearListSection(),
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
            "Select car ownership",
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
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    widget.onNext(items[index]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  "+items[index] + " Ownership ${(ProductSellDashboardScreen
                            .getPendingCarsResponseModel != null &&
                            ProductSellDashboardScreen
                                .getPendingCarsResponseModel!.data.length > 0
                            && ProductSellDashboardScreen
                                .getPendingCarsResponseModel!.data[0]
                                .ownership.toLowerCase() == items[index].toLowerCase()) ?
                        " ✓" : ""}",
                          style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Divider(thickness: 0.5, color: Colors.black26,),
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

}
