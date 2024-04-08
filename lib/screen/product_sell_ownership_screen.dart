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
  int currentSelectedPeriod = -1;
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

    setState(() {
      if (ProductSellJourneyScreen.addCarRequestModel.ownership != null)
        for (int index = 0; index < items.length; index++) {
          if (ProductSellJourneyScreen.addCarRequestModel.ownership!
              .contains(items[index])) {
            currentSelectedPeriod = index;
            break;
          }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildTitleSection(),
          _buildYearListSection(),
        ],
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
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      currentSelectedPeriod = index;
                    });
                    widget.onNext(items[index]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "  ${items[index] + " Ownership"}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: currentSelectedPeriod == index
                                      ? Colors.black
                                      : Colors.black54,
                                  fontWeight: currentSelectedPeriod == index
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            Spacer(),
                            Text(
                              "${currentSelectedPeriod == index ? "✓   "
                                  "" : ""}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
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
                  ),
                );
              }),
        )
      ],
    );
  }
}
