import 'dart:convert';

import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/response/GetUserDetailResponseModel.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
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

  dynamic _currentSelectedValue = null;
  dynamic countries = null;
  GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController fullNameController =
      TextEditingController();
  final TextEditingController phoneNumberController =
      TextEditingController();
  final TextEditingController zipController =
      TextEditingController();


  bool isDataLoading = false;
  GetUserDetailResponseModel? getUserDetailResponseModel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<dynamic> country = loadCountry();
    country.then((value) => {
          print("jsonResult" + value[0]["country_code"]),
          setState(() {
            countries = value;
            callGetUserDetailApi();
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

                if (_formKey.currentState!.validate()) {
                  ContactInfo contactInfo = ContactInfo(
                      name: fullNameController.text,
                      phoneNo: phoneNumberController.text,
                      zipCode: zipController.text,
                      countryCode: _currentSelectedValue["idd_code"].toString(),
                      countryName: _currentSelectedValue["country_name"]
                  );

                  widget.onNext(contactInfo);
                }
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
            getUserDetailResponseModel == null ? "N/A" : getUserDetailResponseModel!.data!.email,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                labelText: 'Choose a country',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.place_outlined, size: 24),
              ),
              isEmpty: _currentSelectedValue == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<dynamic>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      _currentSelectedValue = value;
                    });
                  },
                  items: countries != null ?countries.map<DropdownMenuItem<dynamic>>((value) =>
                  new DropdownMenuItem<dynamic>(
                    value: value,
                    child: new Text(value["country_name"]+" "+value["flag"],
                      style: TextStyle(fontSize: 12),),
                  )
                  ).toList() : null,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: zipController,
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
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

  Future<dynamic> loadCountry() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/country.json");
    var jsonResult = jsonDecode(data);

    return jsonResult;
  }


  void callGetUserDetailApi() {

    setState(() {
      isDataLoading = true;
    });

    Future<GetUserDetailResponseModel> response =
    ApiService(context).getUserDetail();
    response
        .then((value) => {
      getUserDetailResponseModel = value,
      setState(() {
        isDataLoading = false;
        fullNameController.text = getUserDetailResponseModel!.data!.name;
        phoneNumberController.text =
            getUserDetailResponseModel!.data!.phoneNo;

        for (var data in countries) {
          if (data["idd_code"].toString() ==
              getUserDetailResponseModel!.data!.countryCode) {
            _currentSelectedValue = data;
            print(data);
          }
        }
      }),
    })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }
}
