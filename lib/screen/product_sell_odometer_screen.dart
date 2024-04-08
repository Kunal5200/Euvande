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
  int currentSelectedPeriod = -1;

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
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      if(ProductSellJourneyScreen.addCarRequestModel.odometer!= null)
      for (int index = 0; index < items.length; index++) {
        if (ProductSellJourneyScreen.addCarRequestModel.odometer!
            .trim()
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
                                "  ${items[index] + " Kilometers"}",
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
                    ));
              }),
        )
      ],
    );
  }
}
