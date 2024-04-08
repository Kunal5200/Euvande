import 'package:euvande/model/request/GetVariantByModelRequestModel.dart';
import 'package:euvande/model/response/GetVariantByModelResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class ProductSellVariantScreen extends StatefulWidget {
  const ProductSellVariantScreen({super.key, required this.onNext, });

  final TabChangeCallback onNext;

  @override
  State<ProductSellVariantScreen> createState() =>
      _ProductSellVariantScreenState();
}

class _ProductSellVariantScreenState extends State<ProductSellVariantScreen> {
  bool isDataLoading = true;

  int currentSelectedPeriod = -1;

  final List<bool> _selectedTransmission = <bool>[
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<Widget> transmissionTypes = <Widget>[
    Text('Petrol'),
    Text('Diesel'),
    Text('CNG'),
    Text('LNG'),
    Text('FCV'),
    Text('EV'),
    Text('FFV'),
    Text('Gasoline'),
  ];

  GetVariantByModelResponseModel? getVariantByModelResponseModel;

  final TextEditingController varientNameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  bool isFuelTypeNotSelected = false;
  dynamic currentSelectedFuelTypeValue = null;
  dynamic fuelType = [
    "Petrol",
    "Diesel",
    "CNG",
    "LNG",
    "FCV",
    "EV",
    "FFV",
    "Gasoline",
  ];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) {
    //   setState(() {
    //     for (int index = 0; index < fuelType.length; index++) {
    //
    //       print("_selectedTransmission" + ProductSellJourneyScreen
    //           .addCarRequestModel.fuelType.toString());
    //       if (fuelType[index] ==
    //           ProductSellDashboardScreen
    //               .getPendingCarsResponseModel!
    //               .data[ProductSellDashboardScreen.selectedProductIndex]
    //               .variant!.fuelType) {
    //         _selectedTransmission[0] = false;
    //         _selectedTransmission[index] = true;
    //
    //         break;
    //       }
    //     }
    //
    //   });
    // });


    callGetVariantByModelApi(
        "Petrol", ProductSellJourneyScreen.addCarRequestModel.modelId!.toInt());
  }

  Widget _buildNoData() {
    return Container(
        height: 350,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Sorry, variant not found",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(
                  'assets/lottie/nodata.json',
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  child: Text(
                    '+ Add New Variant',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Dialog(
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text('Add new variant',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InputDecorator(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          labelText: 'Choose Fuel Type',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                          ),
                                        ),
                                        isEmpty: currentSelectedFuelTypeValue ==
                                            null,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<dynamic>(
                                            value: currentSelectedFuelTypeValue,
                                            isDense: true,
                                            onChanged: (value) {
                                              setState(() {
                                                currentSelectedFuelTypeValue =
                                                    value;
                                                isFuelTypeNotSelected =
                                                    currentSelectedFuelTypeValue ==
                                                        null;
                                              });
                                            },
                                            items: fuelType != null
                                                ? fuelType
                                                    .map<
                                                        DropdownMenuItem<
                                                            dynamic>>((value) =>
                                                        new DropdownMenuItem<
                                                            dynamic>(
                                                          value: value,
                                                          child: Text(
                                                            value,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ))
                                                    .toList()
                                                : null,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      isFuelTypeNotSelected
                                          ? Text(
                                              " "
                                              "* Choose Fuel Type",
                                              style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontSize: 12),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: varientNameController,
                                        keyboardType: TextInputType.name,
                                        style: TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                          hintText: "Enter variant name",
                                          hintStyle: TextStyle(fontSize: 14),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          border: OutlineInputBorder(
                                              // borderSide: BorderSide.none
                                              ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isFuelTypeNotSelected =
                                                    currentSelectedFuelTypeValue ==
                                                        null;
                                              });
                                              if (currentSelectedFuelTypeValue ==
                                                  null) {
                                                return;
                                              }

                                              if (currentSelectedFuelTypeValue !=
                                                      null &&
                                                  _formKey.currentState!
                                                      .validate()) {
                                                GetVariantByModelData
                                                    getVariantByModelData =
                                                    GetVariantByModelData(
                                                        id: 0,
                                                        variantName:
                                                            varientNameController
                                                                .text,
                                                        fuelType:
                                                            currentSelectedFuelTypeValue);

                                                widget.onNext(
                                                    getVariantByModelData);

                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Continue'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isFuelTypeNotSelected = false;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildTitleSection(),
          SizedBox(
            height: 10,
          ),
          _buildCategory(),
          isDataLoading ? _showLoader() : _buildList(),
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

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Select variant",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                callGetVariantByModelApi(
                    (transmissionTypes[index] as Text).data!,
                    ProductSellJourneyScreen.addCarRequestModel.modelId!
                        .toInt());
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedTransmission.length; i++) {
                    _selectedTransmission[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.black,
              selectedColor: Colors.black,
              // fillColor: Colors.black26,
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedTransmission,
              children: transmissionTypes,
            ),
          )
        ],
      ),
    );
  }

  void callGetVariantByModelApi(String fuelType, int modelId) {
    GetVariantByModelRequestModel getVariantByModelRequestModel =
        GetVariantByModelRequestModel(fuelType: fuelType, modelId: modelId);
    setState(() {
      isDataLoading = true;
    });

    Future<GetVariantByModelResponseModel> response =
        ApiService(context).getVariantByModel(getVariantByModelRequestModel);
    response
        .then((value) => {
              getVariantByModelResponseModel = value,
              setState(() {
                for (int index = 0; index < value.data.length; index++) {
                  if (ProductSellJourneyScreen.addCarRequestModel.variantId ==
                      value.data[index].id) {
                    currentSelectedPeriod = index;
                    break;
                  }
                }

                isDataLoading = false;
              }),
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }

  Widget _buildList() {
    return Container(
      child: Column(
        children: [
          getVariantByModelResponseModel!.data.length == 0
              ? _buildNoData()
              : Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: getVariantByModelResponseModel!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                currentSelectedPeriod = index;
                              });
                              widget.onNext(
                                  getVariantByModelResponseModel!.data[index]);
                            },
                            child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "  ${getVariantByModelResponseModel!.data[index].variantName}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  currentSelectedPeriod == index
                                                      ? Colors.black
                                                      : Colors.black54,
                                              fontWeight:
                                                  currentSelectedPeriod == index
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${currentSelectedPeriod == index ? "✓   "
                                              "" : ""}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.black26,
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
