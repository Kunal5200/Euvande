import 'package:flutter/material.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';

class ProductAuctionInfoScreen extends StatefulWidget {
  const ProductAuctionInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProductAuctionInfoScreen> createState() =>
      _ProductAuctionInfoScreenState();
}

class _ProductAuctionInfoScreenState extends State<ProductAuctionInfoScreen> {
  final yearItems = [
    "BMW X1",
    "BMW 7 Series",
    "BMW 2 Series Gran Coupe",
    "BMW X7",
    "BMW 3 Series Gran Limousine",
  ];

  bool checkboxValue = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitleSection(),
            SizedBox(height: 10),
            _buildLocationSection(),
            SizedBox(height: 10),
            Form(
              child: FormField(
                validator: (value) {
                  if (value == false) {
                    return 'Required.';
                  }
                  return null; // Return null if validation passes
                },
                builder: (FormFieldState<dynamic> field) {
                  return CheckboxListTile(
                    value: checkboxValue,
                    onChanged: (val) {
                      setState(() {
                        checkboxValue = val ?? false;
                      });
                      // Call the validator when the checkbox value changes
                      field.validate();
                    },
                    title: Text(
                      'I agree with the terms & conditions.',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue,
                  );
                },
              ),
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                // Handle button press
              },
              child: Text(
                'Put the car up for auction',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mercedes-Benz E 220",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "WDBUF56X59B412027",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 250,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(6, (index) {
                return GestureDetector(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: _buildauctionItem("10 km", Icons.add_road),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Text(
            "MY DESIRED PRICE INCLUDING VAT (KC)",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: 'My desired price including VAT (kc)',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

Widget _buildauctionItem(String title, IconData iconData) {
  return Container(
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Row(
      children: [
        Icon(iconData),
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
