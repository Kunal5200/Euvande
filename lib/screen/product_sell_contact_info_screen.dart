import 'dart:convert';

import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/response/GetUserDetailResponseModel.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/screen/product_sell_vehicle_image_upload_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellContactInfoScreen extends StatefulWidget {
  int carId = 0;

  ProductSellContactInfoScreen({super.key, required this.onNext, int? carId}) {
    carId == null ? this.carId = 0 : this.carId = carId;
  }

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

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  bool isDataLoading = false;
  bool phoneNumberVerified = false;
  bool emailVerified = false;
  GetUserDetailResponseModel? getUserDetailResponseModel;
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<dynamic> country = loadCountry();
    country.then((value) => {
          print("jsonResult" + value[0]["country_code"]),
          setState(() {
            countries = value;
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Info"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              _buildSteps(),
              _buildTitleSection(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductSellVehicleImageUploadScreen(
                                onNext: (data) {},
                                carId: widget.carId,
                              )),
                    );
                  }

                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //   content: Text("Coming Soon"),
                  // ));
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildSteps() {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Container(
              width: 15,
              height: 15,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Text(
                "✓",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Specifications",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Divider(),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 15,
              height: 15,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              child: Text(
                "2",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Personal Info",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Divider(),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 15,
              height: 15,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: Text(
                "3",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Photos",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ));
  }

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Personal information",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildUncheck() {
    return UnconstrainedBox(
      child: Container(
        height: 20,
        width: 20,
        child: CircleAvatar(
          backgroundColor: Colors.red[700],
          child: Icon(
            Icons.close_rounded,
            size: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCheck() {
    return UnconstrainedBox(
      child: Container(
        height: 20,
        width: 20,
        child: CircleAvatar(
          backgroundColor: Colors.green[700],
          child: Icon(
            Icons.check_rounded,
            size: 14,
            color: Colors.white,
          ),
        ),
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
              onChanged: (value) => setState(() {
                fullNameController.text;
              }),
              controller: fullNameController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.person_outline, size: 24),
                suffixIcon: fullNameController.text.trim().isEmpty
                    ? _buildUncheck()
                    : _buildCheck(),
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
            InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                labelText: 'Choose a country',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.place_outlined, size: 24),
                suffixIcon: _currentSelectedValue == null
                    ? _buildUncheck()
                    : _buildCheck(),
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
                  items: countries != null
                      ? countries
                          .map<DropdownMenuItem<dynamic>>((value) =>
                              new DropdownMenuItem<dynamic>(
                                value: value,
                                child: new Text(
                                  value["country_name"] + " " + value["flag"],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ))
                          .toList()
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      phoneNumberController.text;
                    }),
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      prefixIcon: Icon(Icons.phone_outlined, size: 24),
                      suffixIcon: !phoneNumberVerified
                          ? _buildUncheck()
                          : _buildCheck(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    child: Text(
                      'Get OTP',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      showLoaderDialog(
                          context,
                          "Verify Phone Number",
                          "We"
                              " have sent an OTP on your mobile number", false);
                      // }

                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text("Coming Soon"),
                      // ));
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      emailController.text;
                    }),
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      prefixIcon: Icon(Icons.mail_outline_rounded, size: 24),
                      suffixIcon: !emailVerified
                          ? _buildUncheck()
                          : _buildCheck(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    child: Text(
                      'Get OTP',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showLoaderDialog(
                            context,
                            "Verify Email",
                            "We"
                                " have sent an OTP on your email",
                          true
                            );
                      }

                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text("Coming Soon"),
                      // ));
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
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
                fullNameController.text =
                    getUserDetailResponseModel!.data!.name;
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

  showLoaderDialog(BuildContext context, String title, String description, 
      bool isEmail) {
    Dialog alert = Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Container(
        width: 300,
        height: 250,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              description,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                  fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => setState(() {
                emailController.text;
              }),
              controller: otpController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: 'OTP',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                prefixIcon: Icon(Icons.phone_android_outlined, size: 24),
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              child: Text(
                'Verify OTP',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {

                if(isEmail){
                  setState(() {
                    emailVerified = true;
                  });
                }else{
                  setState(() {
                    phoneNumberVerified = true;
                  });
                }

                Navigator.pop(context);


              },
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
