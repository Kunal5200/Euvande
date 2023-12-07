import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});




  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  bool _rememberMe = false;
  final items = [
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/rear-left-view-121.jpg",
  "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/front-view-118.jpg",
  "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/rear-view-119.jpg",
  "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/grille-97.jpg",
  "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/front-fog-lamp-41.jpg",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                // horizontal: 40.0,
                // vertical: 120.0,
                ),
            child: Column(
              children: [
                _buildImageList(),
                _buildProductSection(),
                _buildProductDetailsTitleSection(),
                _buildProductOverviewSection(),
                _buildProductSpecificationSection(),
                _buildProductGallerySection(),
              ],
            ),
          ),
        ));
  }

  Widget _buildImageList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var i = 0; i < items.length; i++) ...[
            Container(
              width: 150.0,
              height: 180.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(items[i])),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mercedes Maybach S",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "1,000 kms • petrol • automatic • first owner",
            style: TextStyle(
              color: Colors.black26,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "€ 1.25 - €2.45 lakh",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              'Buy Now',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sending Message"),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailsTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ElevatedButton(
              onPressed: () => {},
              style: raisedButtonStyleRound,
              child: Text(
                "OVERVIEW",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () => {},
              style: raisedButtonStyleRound,
              child: Text(
                "SPECS & FEATURE",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () => {},
              style: raisedButtonStyleRound,
              child: Text(
                "OVERVIEW",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ))
        ],
      ),
    );
  }

  Widget _buildProductOverviewSection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Car Overview",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoRow(Icons.calendar_today, "Registration Year", "2023"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(Icons.shield, "Insurance Validity", "Comprehensive"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(Icons.water_drop, "Fuel Type", "Petrol"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(
              Icons.airline_seat_recline_extra_rounded, "Seats", "5 Seats"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(Icons.electric_meter, "KMS Driven", "1,000 Kms"),
        ],
      ),
    );
  }

  Widget _buildProductSpecificationSection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Car Specification",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoRow(null, "Registration Year", "2023"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Insurance Validity", "Comprehensive"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Fuel Type", "Petrol"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Seats", "5 Seats"),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "KMS Driven", "1,000 Kms"),
        ],
      ),
    );
  }

  Widget _buildProductGallerySection() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gallery Experiance",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 3,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(items.length, (index) {
                  return Center(
                    child:
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(items[index])),
                      ),
                    ),
                  );
                }),
              ),),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 16,
            color: Colors.black45,
          ),
        if (icon != null)
          SizedBox(
            width: 10,
          ),
        Text(
          title,
          style: TextStyle(color: Colors.black45, fontSize: 12),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
