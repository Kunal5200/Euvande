import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class ProductSellContactInfoScreen extends StatefulWidget {
  const ProductSellContactInfoScreen({super.key});

  @override
  State<ProductSellContactInfoScreen> createState() =>
      _ProductSellContactInfoScreenState();
}

class _ProductSellContactInfoScreenState extends State<ProductSellContactInfoScreen> {
  final yearItems = [
    "BMW X1",
    "BMW 7 Series",
    "BMW 2 Series Gran Coupe",
    "BMW X7",
    "BMW 3 Series Gran Limousine",
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
            _buildLocationSection(),
            SizedBox(height: 10,),
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
            "Contact information",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          Text(
            "YOU ARE LOGGED IN WITH THE E-MAIL:",
            style: TextStyle(fontSize: 10, color: Colors.green[500]),
          ),
          Text(
            "abc@xyz.com",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green[400]),
          ),
          SizedBox(height: 20,),
          Text(
            "Please confirm your details",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: 'Full Name',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            prefixIcon: Icon(Icons.person, size: 24),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            prefixIcon: Icon(Icons.phone, size: 24),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: 'Choose a country*',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            prefixIcon: Icon(Icons.home_max_outlined, size: 24),
          ),
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: 'Zip code',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            prefixIcon: Icon(Icons.code, size: 24),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
