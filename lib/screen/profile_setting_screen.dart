import 'dart:convert';

import 'package:euvande/model/request/UpdateProfileRequestModel.dart';
import 'package:euvande/model/response/GetUserDetailResponseModel.dart';
import 'package:euvande/model/response/UpdateProfileResponseModel.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProfileSettingScreen extends StatefulWidget {
  final Key? key;

  const ProfileSettingScreen({this.key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  bool isDataLoading = false;
  GetUserDetailResponseModel? getUserDetailResponseModel;
  String submitButtonText = 'Proceed'.toUpperCase();
  bool isEnabled = true;
  dynamic _currentSelectedValue = null;
  dynamic countries = null;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<dynamic> country = loadCountry();
    country.then((value) => {
          setState(() {
            countries = value;
            callGetUserDetailApi();
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25),
              isDataLoading ? _showLoader() : _buildFormSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name*',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.person, size: 24),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15),
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
            isEmpty: _currentSelectedValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                value: _currentSelectedValue,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    _currentSelectedValue = value;
                    print(value);
                  });
                },
                items: countries != null
                    ? countries
                        .map<DropdownMenuItem<dynamic>>(
                            (value) => new DropdownMenuItem<dynamic>(
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
          SizedBox(height: 15),
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone number*',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.phone, size: 24),
            ),
            keyboardType: TextInputType.phone, // Use TextInputType.phone
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: emailController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Email*',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.email, size: 24),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15),
          Container(
            child: ElevatedButton(
              style: raisedButtonStyleForm,
              child: Text(
                submitButtonText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                callUpdateProfileApi();
              },
            ),
          ),
        ],
      ),
    );
  }

  void callUpdateProfileApi() {

    setState(() {
      submitButtonText = "Proceeding...";
      isEnabled = false;
    });

    UpdateProfileRequestModel updateProfileRequestModel =
        UpdateProfileRequestModel(
            name: nameController.text,
            countryName: _currentSelectedValue["country_name"],
            zipCode: null,
            phoneNo: phoneNumberController.text,
            countryCode: _currentSelectedValue["idd_code"].toString(),
            email: null);

    Future<UpdateProfileResponseModel> response =
        ApiService(context).updateUserDetail(updateProfileRequestModel);
    response
        .then((value) => {

    getUserDetailResponseModel!.data!.name = nameController.text,

        setState(() {
                submitButtonText = 'Proceed'.toUpperCase();
              }),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
              Navigator.pop(context, {"result": "OK", "data": jsonEncode(getUserDetailResponseModel!.toJson())}),
            })
        .catchError((onError) {
      setState(() {
        submitButtonText = 'Proceed'.toUpperCase();
        isEnabled = true;
      });
    });
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
                nameController.text = getUserDetailResponseModel!.data!.name;
                emailController.text = getUserDetailResponseModel!.data!.email;
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
