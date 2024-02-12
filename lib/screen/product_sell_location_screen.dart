import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellLocationScreen extends StatefulWidget {
  const ProductSellLocationScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellLocationScreen> createState() =>
      _ProductSellLocationScreenState();
}

class _ProductSellLocationScreenState extends State<ProductSellLocationScreen> {
  final TextEditingController cityController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].location !=
            null) {
      cityController.text = ProductSellDashboardScreen
          .getPendingCarsResponseModel!.data[0].location!.city;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController.dispose();
  }

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
                if (cityController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter your city name"),
                  ));
                } else {
                  widget.onNext(cityController.text);
                }
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
            "What is your location?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "In which city you are looking to sell your car?",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: TextField(
            controller: cityController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              labelText: 'Search Your City',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.location_city, size: 24),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Icon(Icons.my_location),
        ),
      ],
    );
  }
}
