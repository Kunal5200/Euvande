import 'dart:convert';

import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/request/GetModelRequestModel.dart';
import 'package:euvande/model/request/GetPeriodByMakeRequestModel.dart';
import 'package:euvande/model/response/AddCarResponseModel.dart';
import 'package:euvande/model/response/DeleteCarResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetDefaultSpecificationResponseModel.dart';
import 'package:euvande/model/response/GetModelResponseModel.dart';
import 'package:euvande/model/response/GetCarDetailsResponseModel.dart';
import 'package:euvande/model/response/GetPeriodByMakeResponseModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/product_sell_contact_info_screen.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/screen/temp_product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellVinScreen extends StatefulWidget {
  const ProductSellVinScreen({super.key});

  @override
  State<ProductSellVinScreen> createState() => _ProductSellVinScreenState();
}

class _ProductSellVinScreenState extends State<ProductSellVinScreen> {
  int carId = 0;
  dynamic _currentSelectedValue = null;
  dynamic countries = null;

  dynamic _currentSelectedMakeValue = null;
  dynamic _currentSelectedModelValue = null;
  dynamic _currentSelectedPeriodValue = null;
  dynamic _currentSelectedOwnershipValue = null;

  GlobalKey<FormState> _formKey = GlobalKey();

  bool isBrandLoading = true;
  bool isPendingCarLoading = true;
  GetAllMakeResponseModel? getAllMakeResponseModel = null;
  GetModelResponseModel? getModelResponseModel = null;
  GetPeriodByMakeResponseModel? getPeriodByMakeResponseModel = null;
  GetDefaultSpecificationResponseModel? getDefaultSpecificationResponseModel =
      null;
  late LoginResponseModel? loginResponseModel;
  GetCarDetailsResponseModel? getCarDetailsResponseModel = null;

  TextEditingController vinController =
      TextEditingController(text: "");//1GNER23D69S126720
  final TextEditingController trimController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController displacementlController = TextEditingController();

  ScrollController _controller = ScrollController();

  List<String> ownership = [
    "1st",
    "2nd",
    "3rd",
    "14th",
  ];

  bool isCarAdding = false;

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


    // callAddCarApi(widget.addCarRequestModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("VIN"),
        ),
        body: Container(
          child: SingleChildScrollView(
            controller: _controller,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildSteps(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTitleSection(),
                  _buildProductSection()
                ],
              ),
            ),
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
                  BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              child: Text(
                "1",
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
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
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
          Text(
            "Vehicle Specification",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "You only need to enter your car's VIN, and we'll immediately retrieve comprehensive details on it from the relevant authority. If any of the information in the authority database is outdated or inaccurate, you may modify them.",
            style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  void callDeleteCarAPI(int id) {
    Future<DeleteCarResponseModel> response =
        ApiService(context).deleteCar(id.toString());
    response
        .then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
              Navigator.pop(context)
            })
        .catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.message),
      ));
    });
  }

  Widget _buildProductSection() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText("1", "Vehicle VIN (Vehicle identification number)"),
          TextField(
            controller: vinController,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: "(e.g. 1HGBH41JXMN109186)",
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              border: OutlineInputBorder(
                  // borderSide: BorderSide.none
                  ),
            ),
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "Enter a VIN (Vehicle identification number) in "
            "Englishalphanumeric format, typically 17 characters. "
            "including both letters and numbers.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 10,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            style: raisedButtonStyle,
            label: Text(
              isCarAdding ? '' : 'Load VIN'.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              if (vinController.text.trim().isNotEmpty) {
                AddCarRequestModel addCarRequestModel =
                    AddCarRequestModel(vin: vinController.text.trim());
                callAddCarApi(addCarRequestModel);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please input valid VIN number"),
                ));
              }
            },
            icon: isCarAdding ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ) : SizedBox(),
          ),
          SizedBox(
            height: 10,
          ),
          AbsorbPointer(
            absorbing: getCarDetailsResponseModel == null,
            child: Opacity(
              opacity: getCarDetailsResponseModel == null ? 0.3 : 1.0,
              child: _buildVINData(),
            ),
          )
          // getCarDetailsResponseModel != null ? _buildVINData() : SizedBox()
        ],
      ),
    );
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  Future<dynamic> loadCountry() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/country.json");
    var jsonResult = jsonDecode(data);

    return jsonResult;
  }

  void callGetCarDetailsApi(String carId) {
    Future<GetCarDetailsResponseModel> response =
        ApiService(context).getCarDetailById(carId);
    response
        .then((value) => {
              // Navigator.pop(context),
              setState(() {
                isCarAdding = false;
                getCarDetailsResponseModel = value;
                trimController.text = getCarDetailsResponseModel!
                    .data!.specification!.specificationDetails!.trimLevel;
              }),
              callGetAllMakeApi(),
              callGetDefaultSpecificationApi(),


              // Navigator.pop(context),
            })
        .catchError((onError) {
      setState(() {
        isCarAdding = false;
      });
      // Navigator.pop(context);
      setState(() {
        isPendingCarLoading = false;
      });
    });
  }

  void callAddCarApi(AddCarRequestModel addCarRequestModel) {

    setState(() {
      isCarAdding = true;
    });


    FocusManager.instance.primaryFocus?.unfocus();
    // showLoaderDialog(context);
    Future<AddCarResponseModel> response =
        ApiService(context).addCar(addCarRequestModel);
    response
        .then((value) => {
              carId = value.data!.id,
              callGetCarDetailsApi(value.data!.id.toString()),

            })
        .catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.message),
      ));
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
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

  Widget _buildTitleText(String index, String title) {
    return Column(children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Text(index, style: TextStyle(color: Colors.white, fontSize:
            12),),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black
            ),
          ),
          SizedBox(width: 5,),
          Text(
            title.toUpperCase(),
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),

        ],
      ),
      SizedBox(height: 10,)
    ],);
  }

  Widget _buildUncheck() {
    return UnconstrainedBox(
      child: Container(
        height: 15,
        width: 15,
        child: CircleAvatar(
          backgroundColor: Colors.red[700],
          child: Icon(
            Icons.close_rounded,
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCheck() {
    return UnconstrainedBox(
      child: Container(
        height: 15,
        width: 15,
        child: CircleAvatar(
          backgroundColor: Colors.green[700],
          child: Icon(
            Icons.check_rounded,
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildVINData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("2", "Make and Model"),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Make',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: _currentSelectedMakeValue == null
                ? _buildUncheck()
                : _buildCheck(),
          ),
          isEmpty: _currentSelectedMakeValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: _currentSelectedMakeValue,
              isDense: true,
              onChanged: (value) {
                setState(() {
                  _currentSelectedMakeValue = value;
                  callGetModelByMakeApi(value["id"]);
                });
              },
              items: getAllMakeResponseModel != null
                  ? getAllMakeResponseModel!.data
                      .map<DropdownMenuItem<dynamic>>(
                          (value) => DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(
                                  value.makeName,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ))
                      .toList()
                  : null,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Select the Brand of the car",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Model',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: _currentSelectedModelValue == null
                ? _buildUncheck()
                : _buildCheck(),
          ),
          isEmpty: _currentSelectedModelValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: _currentSelectedModelValue,
              isDense: true,
              onChanged: (value) {
                setState(() {
                  _currentSelectedModelValue = value;
                  callGetModelByMakeApi(value["id"]);
                });
              },
              items: getModelResponseModel != null
                  ? getModelResponseModel!.data
                      .map<DropdownMenuItem<dynamic>>(
                          (value) => DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(
                                  value.modelName,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ))
                      .toList()
                  : null,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Select the Model of the car",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _buildTitleText("3", "Period and Trim Level"),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Period',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: _currentSelectedPeriodValue == null
                ? _buildUncheck()
                : _buildCheck(),
          ),
          isEmpty: _currentSelectedPeriodValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: _currentSelectedPeriodValue,
              isDense: true,
              onChanged: (value) {
                setState(() {
                  _currentSelectedPeriodValue = value;
                });
              },
              items: getPeriodByMakeResponseModel != null
                  ? getPeriodByMakeResponseModel!.data
                      .map<DropdownMenuItem<dynamic>>(
                          (value) => DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(
                                  value.year.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ))
                      .toList()
                  : null,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Select the manufacturing year of the car",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) => setState(() {
            trimController.text;
          }),
          controller: trimController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Trim',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: trimController.text.trim().isEmpty
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
          height: 2,
        ),
        Text(
          " Trim Level : Specific configuration or package of feature",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        getDefaultSpecificationResponseModel != null
            ? _buildSpecification()
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
        _buildTitleText("12", "Power and engine displacementl"),
        TextFormField(
          onChanged: (value) => setState(() {
            powerController.text;
          }),
          controller: powerController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Power',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: powerController.text.trim().isEmpty
                ? _buildUncheck()
                : _buildCheck(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Enter engine power (in Kilo Watts)",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) => setState(() {
            displacementlController.text;
          }),
          controller: displacementlController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Engine DisplacementL (L)',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: displacementlController.text.trim().isEmpty
                ? _buildUncheck()
                : _buildCheck(),
          ),
          keyboardType: TextInputType.number,
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
        _buildTitleText("13", "Mileage and ownership"),
        TextFormField(
          onChanged: (value) => setState(() {
            powerController.text;
          }),
          controller: powerController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Mileage (in KM)',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: powerController.text.trim().isEmpty
                ? _buildUncheck()
                : _buildCheck(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Mileage : The total distance that a vehicle has travel",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Ownership of Car',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: _currentSelectedOwnershipValue == null
                ? _buildUncheck()
                : _buildCheck(),
          ),
          isEmpty: _currentSelectedOwnershipValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: _currentSelectedOwnershipValue,
              isDense: true,
              onChanged: (value) {
                setState(() {
                  _currentSelectedOwnershipValue = value;
                });
              },
              items: ownership != null
                  ? ownership
                  .map<DropdownMenuItem<dynamic>>(
                      (value) => DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(
                      value + " Owner",
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
                  .toList()
                  : null,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Ownership : Please specify your current ownership status of the "
              "car",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _buildTitleText("14", "Country of origin of the car"),
        Container(
          height: 50,
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              labelText: 'Choose a country',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              suffixIcon: _currentSelectedValue == null
                  ? _buildUncheck()
                  : _buildCheck(),
            ),
            isEmpty: _currentSelectedValue == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                value: _currentSelectedValue,
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
                                    value["country_name"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ))
                        .toList()
                    : null,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Select manufacturer country of the car",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _buildTitleText("15", "Price"),
        TextFormField(
          onChanged: (value) => setState(() {
            priceController.text;
          }),
          controller: priceController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: 'Price (in Euro)',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: priceController.text.trim().isEmpty
                ? _buildUncheck()
                : _buildCheck(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          " Enter desired price of the car",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Field Number 7, 10, 11, 12, 13, 14, 15 need to be filled to "
              "countinue to the next step",
          style: TextStyle(
            color: Colors.red[700],
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
          style: raisedButtonStyle,
          child: Text(
            'Continue',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductSellContactInfoScreen(
                        onNext: (data) {},
                        carId: this.carId,
                      )),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSelectorList(int specIndex, List<String> items, String
  titleIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child:_buildTitleText(titleIndex, specTitles[specIndex]["title"].toString().toUpperCase()),
            ),
            specTitles[specIndex]["selectedIndex"] == -1
                ? _buildUncheck()
                : _buildCheck(),
            SizedBox(
              width: 16,
            )
          ],
        ),
        Wrap(
          children: List.generate(items.length, (index) {
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => setState(() {
                  specTitles[specIndex]["selectedIndex"] = index;

                  // addSpecificationRequestModel.transmission =
                  // getDefaultSpecificationResponseModel!
                  //     .data!.transmission[index];
                }),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  padding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: specTitles[specIndex]["selectedIndex"] == index
                        ? Colors.black
                        : Colors.grey[50],
                  ),
                  child: Text(
                    items[index].toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: specTitles[specIndex]["selectedIndex"] == index
                          ? Colors.white
                          : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ));
          }),
        )
      ],
    );
  }

  Widget _buildDropDownList(int specIndex, List<String> items, String
  titleIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        _buildTitleText(titleIndex, specTitles[specIndex]["title"].toString().toUpperCase()),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            labelText: "Choose " + specTitles[specIndex]["title"],
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: specTitles[specIndex]["selectedIndex"] == null
                ? _buildUncheck()
                : _buildCheck(),
          ),
          isEmpty: specTitles[specIndex]["selectedIndex"] == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: specTitles[specIndex]["selectedIndex"],
              isDense: true,
              onChanged: (value) {
                setState(() {
                  specTitles[specIndex]["selectedIndex"] = value;
                });
              },
              items: items
                  .map<DropdownMenuItem<dynamic>>(
                      (value) => DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 12),
                            ),
                          ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  List specTitles = [
    {"title": "Transmission", "selectedIndex": -1},
    {"title": "Fuel", "selectedIndex": null},
    {"title": "Doors", "selectedIndex": -1},
    {"title": "Vehicle Type", "selectedIndex": null},
    {"title": "Drive Type 4x4", "selectedIndex": -1},
    {"title": "Seats", "selectedIndex": -1},
    {"title": "Interior Material", "selectedIndex": null},
    {"title": "Possibility of VAT Deduction", "selectedIndex": -1},
  ];

  Widget _buildSpecification() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectorList(
              0, getDefaultSpecificationResponseModel!.data!.transmission, "4"),
          _buildDropDownList(
              1, getDefaultSpecificationResponseModel!.data!.fuel, "5"),
          _buildSelectorList(
              2, getDefaultSpecificationResponseModel!.data!.doors, "6"),
          _buildDropDownList(
              3, getDefaultSpecificationResponseModel!.data!.vehicleType, "7"),
          _buildSelectorList(
              4, getDefaultSpecificationResponseModel!.data!.driveType4Wd, "8"),
          _buildSelectorList(
              5,
              getDefaultSpecificationResponseModel!.data!.seats
                  .map((e) => e.toString())
                  .toList(),"9"),
          _buildDropDownList(
              6, getDefaultSpecificationResponseModel!.data!
              .interiorMaterial,"10"),
          _buildSelectorList(
              7, getDefaultSpecificationResponseModel!.data!.vatDeduction,"11"),
        ],
      ),
    );
  }

  void callGetAllMakeApi() {
    Future<GetAllMakeResponseModel> response = ApiService(context).getAllMake();
    response
        .then((value) => {
              getAllMakeResponseModel = value,
              for (var data in getAllMakeResponseModel!.data)
                {
                  if (data.id == getCarDetailsResponseModel!.data!.make!.id)
                    {
                      setState(() {
                        _currentSelectedMakeValue = data;
                      }),
                      callGetModelByMakeApi(data.id),
                      callGetPeriodByMakeApi(data.id)
                    }
                },
            })
        .catchError((onError) {});
  }

  void callGetModelByMakeApi(int makeId) {
    GetModelRequestModel getModelRequestModel =
        GetModelRequestModel(makeId: makeId, periodYear: 0);

    Future<GetModelResponseModel> response =
        ApiService(context).getModel(getModelRequestModel);
    response
        .then((value) => {
              setState(() {
                getModelResponseModel = value;
                for (var data in getModelResponseModel!.data) {
                  if (data.id == getCarDetailsResponseModel!.data!.model!.id) {
                    setState(() {
                      _currentSelectedModelValue = data;
                    });
                  }
                }
              }),
            })
        .catchError((onError) {});
  }

  void callGetPeriodByMakeApi(int makeId) {
    GetPeriodByMakeRequestModel getPeriodByMakeRequestModel =
        GetPeriodByMakeRequestModel(makeId: makeId);

    Future<GetPeriodByMakeResponseModel> response =
        ApiService(context).getPeriodByMake(getPeriodByMakeRequestModel);
    response
        .then((value) => {
              setState(() {
                getPeriodByMakeResponseModel = value;
                for (var data in getPeriodByMakeResponseModel!.data) {
                  if (data.id == getCarDetailsResponseModel!.data!.period!.id) {
                    setState(() {
                      _currentSelectedPeriodValue = data;
                    });
                  }
                }
              }),
            })
        .catchError((onError) {});
  }

  void callGetDefaultSpecificationApi() {
    Future<GetDefaultSpecificationResponseModel> response =
        ApiService(context).getDefaultSpecification();
    response
        .then((value) => {
              value!.data!.transmission.asMap().forEach((index, data) {
                if (data.trim().toLowerCase() ==
                    getCarDetailsResponseModel!
                        .data!.specification!.transmission
                        .toLowerCase()) {
                  specTitles[0]["selectedIndex"] = index;
                }
              }),
              value!.data!.fuel.asMap().forEach((index, data) {
                if (data.trim().toLowerCase() ==
                    getCarDetailsResponseModel!.data!.specification!
                        .specificationDetails!.fuelTypePrimary
                        .toLowerCase()) {
                  specTitles[1]["selectedIndex"] = data.trim();
                }
              }),
              value!.data!.doors.asMap().forEach((index, data) {
                if (data.trim().toLowerCase() ==
                    getCarDetailsResponseModel!.data!.specification!.doors
                        .toLowerCase()) {
                  specTitles[2]["selectedIndex"] = index;
                }
              }),
              value!.data!.driveType4Wd.asMap().forEach((index, data) {
                if (data.trim().toLowerCase() ==
                    getCarDetailsResponseModel!
                        .data!.specification!.driveType4Wd
                        .toLowerCase()) {
                  specTitles[4]["selectedIndex"] = index;
                }
              }),
              value!.data!.seats.asMap().forEach((index, data) {
                if (data ==
                    getCarDetailsResponseModel!.data!.specification!.seats) {
                  specTitles[5]["selectedIndex"] = index;
                }
              }),
              value!.data!.interiorMaterial.asMap().forEach((index, data) {
                if (data ==
                    getCarDetailsResponseModel!
                        .data!.specification!.interiorMaterial) {
                  specTitles[6]["selectedIndex"] = data.trim();
                }
              }),
              value!.data!.vatDeduction.asMap().forEach((index, data) {
                if (data ==
                    getCarDetailsResponseModel!
                        .data!.specification!.vatDeduction) {
                  specTitles[7]["selectedIndex"] = index;
                }
              }),
              print("specTitles"),
              print(specTitles),
              setState(() {
                getDefaultSpecificationResponseModel = value;
              }),
      _controller.animateTo(
        _controller.position.extentTotal,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      )
            })
        .catchError((onError) {
      // setState(() {
      //   isDataLoading = false;
      // });
    });
  }
}
