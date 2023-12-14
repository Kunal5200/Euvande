import 'package:euvande/utilities/IconTextItem.dart';
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

  bool checkboxValue = true;
  List<IconTextItem> _items = [
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _items.add( IconTextItem(title: '10 Km', icon: Icons.add_road));
    _items.add( IconTextItem(title: '2009', icon: Icons.calendar_today_outlined));
    _items.add( IconTextItem(title: '200 kW', icon: Icons.wind_power));
    _items.add( IconTextItem(title: '10 Km', icon: Icons.add_road));
    _items.add( IconTextItem(title: '2009', icon: Icons.calendar_today_outlined));
    _items.add( IconTextItem(title: '200 kW', icon: Icons.wind_power));
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
            SizedBox(height: 10),
            _buildLocationSection(),
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
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                  );
                },
              ),
            ),
            ElevatedButton(
              style: raisedButtonStyleForm,
              onPressed: () {
                // Handle button press
              },
              child: Text(
                'Book Inspection',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            OutlinedButton(
              style: raisedButtonStyleFormOutline,
              onPressed: () {
                // Handle button press
              },
              child: Text(
                'Put the car up for auction',
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                            AssetImage("assets/logos/logo.png")),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mercedes-Benz E 220",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "WDBUF56X59B412027",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20,),
          Container(
            child: GridView.count(
              childAspectRatio: 4.0,
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(_items.length, (index) {
                return GestureDetector(
                  child: _buildAuctionItem(_items[index].title, _items[index].icon),
                );
              }),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "MY DESIRED PRICE INCLUDING VAT (KC)",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5,),
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

Widget _buildAuctionItem(String title, IconData iconData) {
  return Row(
    children: [
      Icon(iconData),
      Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
