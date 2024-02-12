import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellContactInfoScreen extends StatefulWidget {
  const ProductSellContactInfoScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellContactInfoScreen> createState() =>
      _ProductSellContactInfoScreenState();
}

class _ProductSellContactInfoScreenState
    extends State<ProductSellContactInfoScreen> {
  LoginResponseModel? loginResponseModel = null;

  var countries = [
    "Germany",
    "Italy",
    "France",
    "Czech Republic",
    "Finland",
  ];
  GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController fullNameController =
      TextEditingController(text: "Abhishek");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "1234567890");
  final TextEditingController zipController =
      TextEditingController(text: "123456");

  var _currentSelectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPrefManager.getLoginData().then((value) => {
      setState(() {
        loginResponseModel = value;
      }),
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    zipController.dispose();

    super.dispose();
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
                ContactInfo contactInfo = ContactInfo(
                    name: fullNameController.text,
                    phoneNo: phoneNumberController.text,
                    zipCode: zipController.text);

                widget.onNext(contactInfo);
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //   content: Text("Coming Soon"),
                // ));
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
          SizedBox(
            height: 20,
          ),
          Text(
            "YOU ARE LOGGED IN WITH THE E-MAIL:",
            style: TextStyle(fontSize: 10, color: Colors.green[500]),
          ),
          Text(
              loginResponseModel == null ? "N/A" : loginResponseModel!.data.email,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green[400]),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Please confirm your details",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.person, size: 24),
              ),
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.phone, size: 24),
              ),
              maxLength: 11,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
            ),
            SizedBox(
              height: 10,
            ),
            InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: 'Choose a country',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.home_max_outlined, size: 24),
              ),
              isEmpty: _currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      _currentSelectedValue = value;
                    });
                  },
                  items: countries.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: zipController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: 'Zip code',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.code, size: 24),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ));
  }
}
