import 'dart:convert';
import 'dart:io';

import 'package:euvande/model/response/AddMediaResponseModel.dart';
import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_details_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductSellVehicleImageUploadScreen extends StatefulWidget {
  final int carId;

  const ProductSellVehicleImageUploadScreen(
      {super.key, required this.onNext, required this.carId});

  final TabChangeCallback onNext;

  @override
  State<ProductSellVehicleImageUploadScreen> createState() =>
      _ProductSellVehicleImageUploadScreenState();
}

class _ProductSellVehicleImageUploadScreenState
    extends State<ProductSellVehicleImageUploadScreen> {
  bool isDataLoading = true;
  AddMediaResponseModel? addMediaResponseModel;

  List<KeyFileModel?> _imageExterior = List.generate(8, (index) => null);
  List<KeyFileModel?> _imageInterior = List.generate(8, (index) => null);
  List<KeyFileModel?> _imageWheel = List.generate(8, (index) => null);

  List<List<KeyFileModel?>> selectedImageHolder = [];

  Object selectedImageData = {};

  final exteriorImageList = [
    {
      "key": "frontLeft",
      "title": "Front-Left",
      "image": "assets/images/exterior/frontleft.webp",
    },
    {
      "key": "frontRight",
      "title": "Front-Right",
      "image": "assets/images/exterior/frontright.webp"
    },
    {
      "key": "frontView",
      "title": "Front-View",
      "image": "assets/images/exterior/frontview.webp"
    },
    {
      "key": "headlamp",
      "title": "Front-Light",
      "image": "assets/images/exterior/frontlight.webp"
    },
    {
      "key": "engine",
      "title": "Engine",
      "image": "assets/images/exterior/engine.webp"
    },
    {
      "key": "rearLeft",
      "title": "Back-Left",
      "image": "assets/images/exterior/backleft.webp"
    },
    {
      "key": "rearRight",
      "title": "Back-Right",
      "image": "assets/images/exterior/backright.webp"
    },
    {
      "key": "rearView",
      "title": "Back-View",
      "image": "assets/images/exterior/backview.webp"
    },
  ];

  final interiorImageList = [
    {
      "key": "rearPanelOfCenterConsole",
      "title": "Back-Center-Panel",
      "image": "assets/images/interior/backcenterpanel.webp"
    },
    {
      "key": "rearSeat",
      "title": "Back-Seats",
      "image": "assets/images/interior/backseats.webp"
    },
    {
      "key": "Headlining",
      "title": "Ceiling",
      "image": "assets/images/interior/ceiling.webp"
    },
    {
      "key": "passengerSeat",
      "title": "Co-Driver-Seat",
      "image": "assets/images/interior/codriverseat.webp"
    },
    {
      "key": "driverDoor",
      "title": "Drivers-Door",
      "image": "assets/images/interior/driversdoor.webp"
    },
    {
      "key": "driverSeat",
      "title": "Driver-Seat",
      "image": "assets/images/interior/driverseat.webp"
    },
    {
      "key": "dashboard",
      "title": "Dashboard",
      "image": "assets/images/interior/dashboard.webp"
    },
    {
      "key": "instrumentPanel",
      "title": "Instrument-Panel",
      "image": "assets/images/interior/instrumentpanel.webp"
    },
  ];

  final wheelImageList = [
    {
      "key": "frontLeftWheel",
      "title": "Front Left Wheel",
      "image": "assets/images/wheel/pneu.webp"
    },
    {
      "key": "frontRightWheel",
      "title": "Front Right Wheel",
      "image": "assets/images/wheel/wheel.webp"
    },
    {
      "key": "backLeftWheel",
      "title": "Back Left Wheel",
      "image": "assets/images/wheel/wheel.webp"
    },
    {
      "key": "backRightWheel",
      "title": "Back Right Wheel",
      "image": "assets/images/wheel/wheel.webp"
    },
    {
      "key": "frontLeftTyre",
      "title": "Front Left Tyre",
      "image": "assets/images/wheel/pneu.webp"
    },
    {
      "key": "frontRightTyre",
      "title": "Front Right Tyre",
      "image": "assets/images/wheel/pneu.webp"
    },
    {
      "key": "backLeftTyre",
      "title": "Back Left Tyre",
      "image": "assets/images/wheel/pneu.webp"
    },
    {
      "key": "backRightTyre",
      "title": "Back Right Tyre",
      "image": "assets/images/wheel/pneu.webp"
    },
  ];

  final picker = ImagePicker();

  List<double> _imageExteriorUploadProgress = List.generate(8, (index) => 0.0);
  List<double> _imageInteriorUploadProgress = List.generate(8, (index) => 0.0);
  List<double> _imageWheelUploadProgress = List.generate(8, (index) => 0.0);

  List<List<double>> selectedUploadProgressHolder = [];

  dynamic mediaImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedImageHolder.add(_imageExterior);
    selectedImageHolder.add(_imageInterior);
    selectedImageHolder.add(_imageWheel);

    selectedUploadProgressHolder.add(_imageExteriorUploadProgress);
    selectedUploadProgressHolder.add(_imageInteriorUploadProgress);
    selectedUploadProgressHolder.add(_imageWheelUploadProgress);

    if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].media !=
            null) {
      mediaImages = ProductSellDashboardScreen
          .getPendingCarsResponseModel!.data[0].media!.images!
          .toJson();
    }
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
            Text(
              "Exterior",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            _buildLocationSection(exteriorImageList, 0),
            SizedBox(
              height: 20,
            ),
            Text(
              "Interior",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            _buildLocationSection(interiorImageList, 1),
            SizedBox(
              height: 20,
            ),
            Text(
              "Wheel",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            _buildLocationSection(wheelImageList, 2),
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
                var flag = false;

                for(int i=0; i < selectedImageHolder.length;i++){
                  for(var mainData in selectedImageHolder[i]){
                    if(mainData !=null){
                      flag = true;
                      break;
                    }

                  }
                }

                if(flag || mediaImages!=null){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductSellDetailsScreen()),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Upload all mandatory images"),
                  ));
                }


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
            "Vehicle photo documentation",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Take photos of the car from all four sides as well as the dashboard and interior equipment, including any damage or wear to the interior and exterior (paint damage, curbed rims, cracks, etc.).",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future getImageFromGallery(int categoryIndex, int index, String key) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImageHolder[categoryIndex][index] =
            KeyFileModel(file: File(pickedFile.path), key: key);
        callAddMediaApi(key, File(pickedFile.path), categoryIndex, index);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera(int categoryIndex, int index, String key) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        selectedImageHolder[categoryIndex][index] =
            KeyFileModel(file: File(pickedFile.path), key: key);
        callAddMediaApi(key, File(pickedFile.path), categoryIndex, index);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions(int categoryIndex, int index, String key) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery(categoryIndex, index, key);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera(categoryIndex, index, key);
            },
          ),
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

  void callAddMediaApi(
    String key,
    File file,
    int categoryIndex,
    int index,
  ) {
    setState(() {
      isDataLoading = true;
      selectedUploadProgressHolder[categoryIndex][index] = 0.0;
    });

    Future<AddMediaResponseModel> response = ApiService(context).addMedia(
      widget.carId,
      key,
      file,
      (count, total) {
        print('hhell${((count / total) * 100) / 100}');
        setState(() {
          selectedUploadProgressHolder[categoryIndex][index] =
              ((count / total) * 100) / 100;
        });
      },
    );
    response
        .then((value) => {
              setState(() {
                isDataLoading = false;
              }),
              addMediaResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }

  Widget _buildLocationSection(
      List<Map<String, String>> imageListData, int categoryIndex) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(imageListData.length, (index) {
          return GestureDetector(
              onTap: () {
                showOptions(categoryIndex, index, imageListData[index]["key"]!);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(imageListData[index]["image"]!)),
                      ),
                    ),
                    selectedImageHolder[categoryIndex][index] == null
                        ? mediaImages !=null &&
                    mediaImages[imageListData[index]["key"]] != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(mediaImages[
                                          imageListData[index]["key"]])),
                                ),
                              )
                            : SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      selectedImageHolder[categoryIndex][index]!
                                          .file!)),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        imageListData[index]["title"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Icon(
                          Icons.upload_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(5),
                          value: selectedUploadProgressHolder[categoryIndex]
                              [index],
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }
}

class KeyFileModel {
  final File? file;
  final String key;

  KeyFileModel({
    required this.file,
    required this.key,
  });
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
