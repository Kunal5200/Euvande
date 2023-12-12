import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ProductSellVehicleImageUploadScreen extends StatefulWidget {
  const ProductSellVehicleImageUploadScreen({super.key});

  @override
  State<ProductSellVehicleImageUploadScreen> createState() =>
      _ProductSellVehicleImageUploadScreenState();
}

class _ProductSellVehicleImageUploadScreenState
    extends State<ProductSellVehicleImageUploadScreen> {
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
            _buildLocationSection(),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Coming Soon"),
                ));
              },
            ),
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
            "Vehicle Photo Documentation",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Take photos of the car from all four sides as well as the dashboard and interior equipment, including any damage or wear to the interior and exterior (paint damage, curbed rims, cracks, etc.).",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      height: 450,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Coming Soon"),
                ));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Stack(
                  children: [
                    ExtendedImage.asset(
                      'assets/images/backleft.webp',
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeat,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/backleft.webp")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        "Front-left",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
