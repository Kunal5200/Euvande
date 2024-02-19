import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/response/GetDefaultSpecificationResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductSellSpecificationScreen extends StatefulWidget {
  final int carId;

  const ProductSellSpecificationScreen(
      {super.key, required this.onNext, required this.carId});

  final TabChangeCallback onNext;

  @override
  State<ProductSellSpecificationScreen> createState() =>
      _ProductSellSpecificationScreenState();
}

class _ProductSellSpecificationScreenState
    extends State<ProductSellSpecificationScreen> {
  late AddSpecificationRequestModel addSpecificationRequestModel;
  GetDefaultSpecificationResponseModel? getDefaultSpecificationResponseModel;

  bool isDataLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey();

  int _index = 0;
  int selectedTransmissionIndex = -1;
  int selectedVehicleTypeIndex = -1;
  int selectedDoorsIndex = -1;
  int selectedDrive4x4Index = -1;
  int selectedSeatIndex = -1;
  int selectedVInteriorIndex = -1;
  int selectedVatIndex = -1;
  List<bool> selectedEquipmentIndex = [];

  var driveType4x4Item = [
    "Yes",
    "No",
  ];

  var seatsItem = [
    2,
    3,
    4,
    5,
    6,
    7,
    8,
  ];

  var interiorMaterialItem = [
    "Alcantara",
    "Cloth",
    "Full leather",
    "Other",
    "Part leather",
    "Velour ",
  ];

  var vatDeductionItem = [
    "Yes",
    "No",
  ];

  final TextEditingController powerController =
      TextEditingController(text: "200");
  final TextEditingController colorController =
      TextEditingController(text: "Black");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addSpecificationRequestModel = AddSpecificationRequestModel();
    addSpecificationRequestModel.carId = widget.carId;

    addSpecificationRequestModel.equipments = [];

    callGetDefaultSpecificationApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 50),
        child: Column(
          children: [
            isDataLoading ? _showLoader() : _buildTitleSection(),
            ElevatedButton(
              style: raisedButtonStyle,
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {
                if (addSpecificationRequestModel.transmission == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select transmission type"),
                  ));
                } else if (addSpecificationRequestModel.vehicleType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select vehicle type"),
                  ));
                } else if (addSpecificationRequestModel.transmission == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select doors"),
                  ));
                } else if (addSpecificationRequestModel.driveType4Wd == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select drive type"),
                  ));
                } else if (addSpecificationRequestModel.seats == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select seat"),
                  ));
                } else if (addSpecificationRequestModel.interiorMaterial ==
                    null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select interior material"),
                  ));
                } else if (addSpecificationRequestModel.vatDeduction == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select vat deduction"),
                  ));
                } else if (powerController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please input power of vehicle"),
                  ));
                } else if (colorController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please input color of vehicle"),
                  ));
                } else if (addSpecificationRequestModel.equipments!.length ==
                    0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select atleast one equipments"),
                  ));
                } else {
                  addSpecificationRequestModel.power =
                      powerController.text.trim();
                  addSpecificationRequestModel.color =
                      colorController.text.trim();
                  widget.onNext(addSpecificationRequestModel);
                }
              },
            ),
          ],
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

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Stepper(
        physics: NeverScrollableScrollPhysics(),
        controlsBuilder: (context, controller) {
          return _index == 0
              ? Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _index++;
                        });
                      },
                      child: const Text('NEXT'),
                    ),
                  ],
                )
              : _index == 8
                  ? Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _index--;
                            });
                          },
                          child: const Text('BACK'),
                        ),
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _index++;
                            });
                          },
                          child: const Text('NEXT'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _index--;
                            });
                          },
                          child: const Text('EXIT'),
                        ),
                      ],
                    );
        },
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          Step(
            isActive: _index <= 0,
            state: _index <= 0 ? StepState.indexed : StepState.complete,
            title: const Text('Transmission'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!
                          .data!.transmission.length, (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedTransmissionIndex = index;

                              addSpecificationRequestModel.transmission =
                                  getDefaultSpecificationResponseModel!
                                      .data!.transmission[index];
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedTransmissionIndex == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.transmission[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedTransmissionIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
            isActive: _index <= 1,
            state: _index <= 1 ? StepState.indexed : StepState.complete,
            title: const Text('Vehicle Type'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!
                          .data!.vehicleType.length, (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => {
                              setState(() {
                                selectedVehicleTypeIndex = index;
                                addSpecificationRequestModel.vehicleType =
                                    getDefaultSpecificationResponseModel!
                                        .data!.vehicleType[index];
                              })
                            },
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedVehicleTypeIndex == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.vehicleType[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
            isActive: _index <= 2,
            state: _index <= 2 ? StepState.indexed : StepState.complete,
            title: const Text('Doors'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!.data!.doors.length,
                      (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedDoorsIndex = index;
                              addSpecificationRequestModel.doors =
                                  getDefaultSpecificationResponseModel!
                                      .data!.doors[index];
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedDoorsIndex == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.doors[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedDoorsIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
            isActive: _index <= 3,
            state: _index <= 3 ? StepState.indexed : StepState.complete,
            title: const Text('Drive Type 4x4'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!
                          .data!.driveType4Wd.length, (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedDrive4x4Index = index;
                              addSpecificationRequestModel.driveType4Wd =
                                  getDefaultSpecificationResponseModel!
                                      .data!.driveType4Wd[index];
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedDrive4x4Index == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.driveType4Wd[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedDrive4x4Index == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
            isActive: _index <= 4,
            state: _index <= 4 ? StepState.indexed : StepState.complete,
            title: const Text('Seats'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!.data!.seats.length,
                      (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedSeatIndex = index;

                              addSpecificationRequestModel.seats =
                                  getDefaultSpecificationResponseModel!
                                      .data!.seats[index];
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedSeatIndex == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.seats[index]
                                .toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedSeatIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
            isActive: _index <= 5,
            state: _index <= 5 ? StepState.indexed : StepState.complete,
            title: const Text('Interior Material'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!
                          .data!.interiorMaterial.length, (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedVInteriorIndex = index;
                              addSpecificationRequestModel.interiorMaterial =
                                  getDefaultSpecificationResponseModel!
                                      .data!.interiorMaterial[index];
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedVInteriorIndex == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.interiorMaterial[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedVInteriorIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
            isActive: _index <= 6,
            state: _index <= 6 ? StepState.indexed : StepState.complete,
            title: const Text('POSSIBILITY OF VAT DEDUCTION'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!
                          .data!.vatDeduction.length, (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedVatIndex = index;
                              addSpecificationRequestModel.vatDeduction =
                                  getDefaultSpecificationResponseModel!
                                      .data!.vatDeduction[index];
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedVatIndex == index
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.vatDeduction[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedVatIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
          Step(
              isActive: _index <= 7,
              state: _index <= 7 ? StepState.indexed : StepState.complete,
              title: const Text('Features'),
              content: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: powerController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            labelText: 'Power (kw)*',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: colorController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              labelText: 'Color*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            keyboardType: TextInputType.name),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ))),
          Step(
            isActive: _index <= 8,
            state: _index <= 8 ? StepState.indexed : StepState.complete,
            title: const Text('Equipments'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(
                      getDefaultSpecificationResponseModel!
                          .data!.equipments.length, (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                        onTap: () => setState(() {
                              selectedEquipmentIndex[index] =
                                  !selectedEquipmentIndex[index];
                              if (selectedEquipmentIndex[index]) {
                                addSpecificationRequestModel.equipments!.add(
                                    getDefaultSpecificationResponseModel!
                                        .data!.equipments[index]);
                              } else {
                                for (int i = 0;
                                    i <
                                        addSpecificationRequestModel
                                            .equipments!.length;
                                    i++) {
                                  if (getDefaultSpecificationResponseModel!
                                          .data!.equipments[index] ==
                                      addSpecificationRequestModel
                                          .equipments![i]) {
                                    addSpecificationRequestModel.equipments!
                                        .removeAt(i);
                                  }
                                }
                              }

                              print(addSpecificationRequestModel
                                  .equipments!.length);
                            }),
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: selectedEquipmentIndex[index]
                                ? Colors.black
                                : Colors.black12,
                          ),
                          child: Text(
                            getDefaultSpecificationResponseModel!
                                .data!.equipments[index],
                            style: TextStyle(
                              fontSize: 10,
                              color: selectedEquipmentIndex[index]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ));
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callGetDefaultSpecificationApi() {
    setState(() {
      isDataLoading = true;
    });

    Future<GetDefaultSpecificationResponseModel> response =
        ApiService(context).getDefaultSpecification();
    response
        .then((value) => {
              setState(() {
                isDataLoading = false;
              }),
              getDefaultSpecificationResponseModel = value,
              selectedEquipmentIndex = List.generate(
                  getDefaultSpecificationResponseModel!.data!.equipments.length,
                  (index) => false),
              checkPreviousSelectedData(),
            })
        .catchError((onError) {
      // setState(() {
      //   isDataLoading = false;
      // });
    });
  }

  checkPreviousSelectedData() {
    if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].specification !=
            null) {
      for (int i = 0;
          i < getDefaultSpecificationResponseModel!.data!.transmission.length;
          i++) {
        if (ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0]
                .specification!.transmission
                .toLowerCase() ==
            getDefaultSpecificationResponseModel!.data!.transmission[i]
                .toLowerCase()) {
          selectedTransmissionIndex = i;

          addSpecificationRequestModel.transmission =
              getDefaultSpecificationResponseModel!.data!.transmission[i];
          break;
        }
      }

      for (int i = 0;
          i < getDefaultSpecificationResponseModel!.data!.vehicleType.length;
          i++) {
        print(ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[0].specification!.vehicleType
            .toLowerCase());
        if (ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].specification!.vehicleType
                .toLowerCase() ==
            getDefaultSpecificationResponseModel!.data!.vehicleType[i]
                .toLowerCase()) {
          selectedVehicleTypeIndex = i;

          addSpecificationRequestModel.vehicleType =
              getDefaultSpecificationResponseModel!.data!.vehicleType[i];
          break;
        }
      }

      for (int i = 0;
          i < getDefaultSpecificationResponseModel!.data!.doors.length;
          i++) {
        if (ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].specification!.doors
                .toLowerCase() ==
            getDefaultSpecificationResponseModel!.data!.doors[i]
                .toLowerCase()) {
          selectedDoorsIndex = i;

          addSpecificationRequestModel.doors =
              getDefaultSpecificationResponseModel!.data!.doors[i];
          break;
        }
      }

      for (int i = 0;
          i < getDefaultSpecificationResponseModel!.data!.driveType4Wd.length;
          i++) {
        if (ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0]
                .specification!.driveType4Wd
                .toLowerCase() ==
            getDefaultSpecificationResponseModel!.data!.driveType4Wd[i]
                .toLowerCase()) {
          selectedDrive4x4Index = i;

          addSpecificationRequestModel.driveType4Wd =
              getDefaultSpecificationResponseModel!.data!.driveType4Wd[i];
          break;
        }
      }
    }

    for (int i = 0;
        i < getDefaultSpecificationResponseModel!.data!.seats.length;
        i++) {
      if (ProductSellDashboardScreen
              .getPendingCarsResponseModel!.data[0].specification!.seats ==
          getDefaultSpecificationResponseModel!.data!.seats[i]) {
        selectedSeatIndex = i;

        addSpecificationRequestModel.seats =
            getDefaultSpecificationResponseModel!.data!.seats[i];
        break;
      }
    }

    for (int i = 0;
        i < getDefaultSpecificationResponseModel!.data!.interiorMaterial.length;
        i++) {
      if (ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0]
              .specification!.interiorMaterial
              .toLowerCase() ==
          getDefaultSpecificationResponseModel!.data!.interiorMaterial[i]
              .toLowerCase()) {
        selectedVInteriorIndex = i;

        addSpecificationRequestModel.interiorMaterial =
            getDefaultSpecificationResponseModel!.data!.interiorMaterial[i];
        break;
      }
    }
    for (int i = 0;
        i < getDefaultSpecificationResponseModel!.data!.vatDeduction.length;
        i++) {
      if (ProductSellDashboardScreen
              .getPendingCarsResponseModel!.data[0].specification!.vatDeduction
              .toLowerCase() ==
          getDefaultSpecificationResponseModel!.data!.vatDeduction[i]
              .toLowerCase()) {
        selectedVatIndex = i;

        addSpecificationRequestModel.vatDeduction =
            getDefaultSpecificationResponseModel!.data!.vatDeduction[i];
        break;
      }
    }

    powerController.text = ProductSellDashboardScreen
        .getPendingCarsResponseModel!.data[0].specification!.power;
    colorController.text = ProductSellDashboardScreen
        .getPendingCarsResponseModel!.data[0].specification!.color;

    for (int i = 0;
        i < getDefaultSpecificationResponseModel!.data!.equipments.length;
        i++) {
      for (int j = 0;
          j < ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0]
              .specification!.equipments.length;
          j++) {
        if (ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0]
                .specification!.equipments[j]
                .toLowerCase() ==
            getDefaultSpecificationResponseModel!.data!.equipments[i]
                .toLowerCase()) {
          selectedEquipmentIndex[i] = true;

          addSpecificationRequestModel.equipments!.add
            (getDefaultSpecificationResponseModel!.data!.equipments[i]);
          break;
        }
      }
    }
  }
}
