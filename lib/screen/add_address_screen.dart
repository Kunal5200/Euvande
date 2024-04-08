import 'dart:convert';

import 'package:euvande/model/request/AddAddressRequestModel.dart';
import 'package:euvande/model/request/EditAddressRequestModel.dart';
import 'package:euvande/model/response/AddAddressResponseModel.dart';
import 'package:euvande/model/response/EditAddressResponseModel.dart';
import 'package:euvande/model/response/GetAddressResponseModel.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAddressScreen extends StatefulWidget {
  final GetAddressData? getAddressData;

  const AddAddressScreen(this.getAddressData, {super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String submitButtonText = 'Proceed'.toUpperCase();
  bool isEnabled = true;
  int? _value = 0;
  bool isDataLoading = false;

  final TextEditingController streetController =
      TextEditingController(text: "");
  final TextEditingController houseNoController =
      TextEditingController(text: "");
  final TextEditingController pincodeController =
      TextEditingController(text: "");
  final TextEditingController cityController =
      TextEditingController(text: "");

  dynamic _currentSelectedValue = null;
  dynamic countries = null;

  var isPrimaryChecked = true;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    streetController.dispose();
    houseNoController.dispose();
    pincodeController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<dynamic> country = loadCountry();
    country.then((value) => {
          print("jsonResult" + value[0]["country_code"]),
          setState(() {
            countries = value;
            if (widget.getAddressData != null) {
              for (var data in countries) {
                if (data["country_name"].toString() ==
                    widget.getAddressData!.country) {
                  _currentSelectedValue = data;
                  print(data);
                }
              }
            }else{
              _currentSelectedValue = countries[0];
            }
          }),
        });

    if (widget.getAddressData != null) {
      streetController.text = widget.getAddressData!.street;
      houseNoController.text = widget.getAddressData!.houseNo;
      pincodeController.text = widget.getAddressData!.postalCode;
      cityController.text = widget.getAddressData!.city;
    }
  }

  Future<dynamic> loadCountry() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/country.json");
    var jsonResult = jsonDecode(data);

    return jsonResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.getAddressData == null
              ? "Add New Address"
              : "Update Address"),
          backgroundColor: Color(0xfffafcff),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    enabled: !isDataLoading,
                    controller: streetController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      labelText: 'Street',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: !isDataLoading,
                    controller: houseNoController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: 'House',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: !isDataLoading,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: pincodeController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: 'Zip Code',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: !isDataLoading,
                    controller: cityController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      labelText: 'Choose a country',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
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
                                .map<DropdownMenuItem<dynamic>>(
                                    (value) => new DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: new Text(
                                            value["country_name"] +
                                                " " +
                                                value["flag"],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ))
                                .toList()
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                      spacing: 9.0,
                      children: List<Widget>.generate(
                        2,
                        (int index) {
                          return ChoiceChip(
                            label: Text(index == 0 ? 'Home' : 'Office'),
                            selected: _value == index,
                            onSelected: (bool selected) {
                              if (!isDataLoading) {
                                setState(() {
                                  _value = selected ? index : null;
                                });
                              }
                            },
                          );
                        },
                      ).toList()),

                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isPrimaryChecked,
                        onChanged: (bool? value) {
                          if (!isDataLoading) {
                            setState(() {
                              isPrimaryChecked = value ?? false;
                            });
                          }
                        },
                      ),
                      const Text(
                        "This is primary?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: raisedButtonStyleForm,
                    child: Text(
                      submitButtonText,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      if (isEnabled && _formKey.currentState!.validate()) {
                        if (widget.getAddressData == null) {
                          callAddAddressApi();
                        } else {
                          callEditAddressApi();
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void callAddAddressApi() {
    setState(() {
      isDataLoading = true;
      submitButtonText = "Proceeding...";
      isEnabled = false;
    });

    AddAddressRequestModel addAddressRequestModel = AddAddressRequestModel(
        addressType: _value == 0 ? 'home' : 'office',
        city: cityController.text,
        country: _currentSelectedValue["country_name"],
        houseNo: houseNoController.text,
        isDefault: isPrimaryChecked,
        postalCode: pincodeController.text,
        street: streetController.text);

    Future<AddAddressResponseModel> response =
        ApiService(context).addAddress(addAddressRequestModel);
    response
        .then((value) => {
              Navigator.pop(context, {"result": "OK", "data": value}),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
            })
        .catchError((onError) {
      setState(() {
        submitButtonText = 'Proceed'.toUpperCase();
        isEnabled = true;
        isDataLoading = false;
      });
    });
  }

  void callEditAddressApi() {
    setState(() {
      isDataLoading = true;
    });

    EditAddressRequestModel editAddressRequestModel = EditAddressRequestModel(
        id: widget.getAddressData!.id,
        addressType: _value == 0 ? 'home' : 'office',
        city: cityController.text,
        country: _currentSelectedValue["country_name"],
        houseNo: houseNoController.text,
        isDefault: isPrimaryChecked,
        postalCode: pincodeController.text,
        street: streetController.text);

    Future<EditAddressResponseModel> response =
        ApiService(context).editAddress(editAddressRequestModel);
    response
        .then((value) => {
              Navigator.pop(context, {"result": "OK", "data": value}),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
            })
        .catchError((onError) {
      setState(() {
        submitButtonText = 'Proceed'.toUpperCase();
        isEnabled = true;
        isDataLoading = false;
      });
    });
  }
}
