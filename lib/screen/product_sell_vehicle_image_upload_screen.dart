import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class ProductSellVehicleImageUploadScreen extends StatefulWidget {
  const ProductSellVehicleImageUploadScreen({super.key});

  @override
  State<ProductSellVehicleImageUploadScreen> createState() =>
      _ProductSellVehicleImageUploadScreenState();
}

class _ProductSellVehicleImageUploadScreenState
    extends State<ProductSellVehicleImageUploadScreen> {
  List<File?> _imageExterior = List.generate(8, (index) => null);
  List<File?> _imageInterior = List.generate(8, (index) => null);
  List<File?> _imageWheel = List.generate(2, (index) => null);

  List<List<File?>> selectedImageHolder = [];

  Object selectedImageData = {};

  final exteriorImageList = [
    {
      "title": "Front-Left",
      "image": "assets/images/exterior/frontleft.webp",
    },
    {"title": "Front-Right", "image": "assets/images/exterior/frontright.webp"},
    {"title": "Front-View", "image": "assets/images/exterior/frontview.webp"},
    {"title": "Front-Light", "image": "assets/images/exterior/frontlight.webp"},
    {"title": "Engine", "image": "assets/images/exterior/engine.webp"},
    {"title": "Back-Left", "image": "assets/images/exterior/backleft.webp"},
    {"title": "Back-Right", "image": "assets/images/exterior/backright.webp"},
    {"title": "Back-View", "image": "assets/images/exterior/backview.webp"},
  ];

  final interiorImageList = [
    {
      "title": "Back-Center-Panel",
      "image": "assets/images/interior/backcenterpanel.webp"
    },
    {"title": "Back-Seats", "image": "assets/images/interior/backseats.webp"},
    {"title": "Ceiling", "image": "assets/images/interior/ceiling.webp"},
    {
      "title": "Co-Driver-Seat",
      "image": "assets/images/interior/codriverseat.webp"
    },
    {
      "title": "Drivers-Door",
      "image": "assets/images/interior/driversdoor.webp"
    },
    {"title": "Driver-Seat", "image": "assets/images/interior/driverseat.webp"},
    {"title": "Dashboard", "image": "assets/images/interior/dashboard.webp"},
    {
      "title": "Instrument-Panel",
      "image": "assets/images/interior/instrumentpanel.webp"
    },
  ];

  final wheelImageList = [
    {"title": "Pneu", "image": "assets/images/wheel/pneu.webp"},
    {"title": "Wheel", "image": "assets/images/wheel/wheel.webp"},
  ];

  final picker = ImagePicker();

  Future getImageFromGallery(int categoryIndex, int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImageHolder[categoryIndex][index] = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera(int categoryIndex, int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        selectedImageHolder[categoryIndex][index] = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions(int categoryIndex, int index) async {
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
              getImageFromGallery(categoryIndex, index);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera(categoryIndex, index);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedImageHolder.add(_imageExterior);
    selectedImageHolder.add(_imageInterior);
    selectedImageHolder.add(_imageWheel);
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Coming Soon"),
                ));
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
            "Vehicle Photo Documentation",
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
                showOptions(categoryIndex, index);
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
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      selectedImageHolder[categoryIndex]
                                          [index]!)),
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
                        margin: EdgeInsets.all(10),
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
                  ],
                ),
              ));
        }),
      ),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
