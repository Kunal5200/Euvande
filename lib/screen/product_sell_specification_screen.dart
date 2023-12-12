import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';

class ProductSellSpecificationScreen extends StatefulWidget {
  const ProductSellSpecificationScreen({super.key});

  @override
  State<ProductSellSpecificationScreen> createState() =>
      _ProductSellSpecificationScreenState();
}

class _ProductSellSpecificationScreenState
    extends State<ProductSellSpecificationScreen> {
  int _index = 0;
  final List<bool> _selectedFruits = <bool>[true, false];
  int selectedVehicleTypeIndex = 0;
  List<Widget> transmissionTypes = <Widget>[Text('Automatic'), Text('Manual')];

  var vehicleTypeItem = [
    "Cabriolet",
    "Compact",
    "Coupe",
    "Estate car",
    "Hatchback",
    "Liftback",
    "MPV",
    "Other",
    "Sedan",
    "SUV",
    "Van",
  ];

  var doorItem = [
    "2/3",
    "4/5",
  ];

  var driveType4x4Item = [
    "Yes",
    "No",
  ];

  var seatsItem = [
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
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


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 50),
        child: Column(
          children: [
            _buildTitleSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Expanded(
        child: Stepper(
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
                : _index == 6
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
                child: ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedFruits.length; i++) {
                        _selectedFruits[i] = i == index;
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
                  isSelected: _selectedFruits,
                  children: transmissionTypes,
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
                    children: List.generate(vehicleTypeItem.length, (index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                                selectedVehicleTypeIndex = index;
                              }),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),

                            child: Text(vehicleTypeItem[index],style: TextStyle(fontSize: 12,color: selectedVehicleTypeIndex == index
                                ? Colors.white
                                : Colors.black,),textAlign: TextAlign.center,),
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
                    children: List.generate(doorItem.length, (index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                            selectedVehicleTypeIndex = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),

                            child: Text(doorItem[index],style: TextStyle(fontSize: 12,color: selectedVehicleTypeIndex == index
                                ? Colors.white
                                : Colors.black,),textAlign: TextAlign.center,),
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
                    children: List.generate(driveType4x4Item.length, (index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                            selectedVehicleTypeIndex = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),

                            child: Text(driveType4x4Item[index],style: TextStyle(fontSize: 12,color: selectedVehicleTypeIndex == index
                                ? Colors.white
                                : Colors.black,),textAlign: TextAlign.center,),
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
                    children: List.generate(seatsItem.length, (index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                            selectedVehicleTypeIndex = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),

                            child: Text(seatsItem[index],style: TextStyle(fontSize: 12,color: selectedVehicleTypeIndex == index
                                ? Colors.white
                                : Colors.black,),textAlign: TextAlign.center,),
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
                    children: List.generate(interiorMaterialItem.length, (index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                            selectedVehicleTypeIndex = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),

                            child: Text(interiorMaterialItem[index],style: TextStyle(fontSize: 12,color: selectedVehicleTypeIndex == index
                                ? Colors.white
                                : Colors.black,),textAlign: TextAlign.center,),
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
                    children: List.generate(vatDeductionItem.length, (index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                            selectedVehicleTypeIndex = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: selectedVehicleTypeIndex == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),

                            child: Text(vatDeductionItem[index],style: TextStyle(fontSize: 12,color: selectedVehicleTypeIndex == index
                                ? Colors.white
                                : Colors.black,),textAlign: TextAlign.center,),
                          ));
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
