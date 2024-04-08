import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/response/AddCarResponseModel.dart';
import 'package:euvande/model/response/AddSpecificationResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/screen/product_sell_brands_screen.dart';
import 'package:euvande/screen/product_sell_contact_info_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/screen/product_sell_location_screen.dart';
import 'package:euvande/screen/product_sell_model_screen.dart';
import 'package:euvande/screen/product_sell_odometer_screen.dart';
import 'package:euvande/screen/product_sell_ownership_screen.dart';
import 'package:euvande/screen/product_sell_period_screen.dart';
import 'package:euvande/screen/product_sell_specification_screen.dart';
import 'package:euvande/screen/product_sell_variant_screen.dart';
import 'package:euvande/screen/product_sell_vehicle_image_upload_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TempProductSellJourneyScreen extends StatefulWidget {
  const TempProductSellJourneyScreen({
    super.key,
  });

  @override
  State<TempProductSellJourneyScreen> createState() =>
      _TempProductSellJourneyScreenState();
}

class _TempProductSellJourneyScreenState
    extends State<TempProductSellJourneyScreen> {
  bool isDataLoading = false;
  bool isBrandLoading = true;
  bool isPendingCarLoading = true;

  final tabItems = [
    {
      "title": "Make",
      "desc": "Make",
      "type": "make",
      "isEnabled": false,
    },
    {
      "title": "Period",
      "desc": "Period",
      "type": "period",
      "isEnabled": false,
    },
    {
      "title": "Model",
      "desc": "Model",
      "type": "model",
      "isEnabled": false,
    },
    {
      "title": "Variant",
      "desc": "Variant",
      "type": "variant",
      "isEnabled": false,
    },
    {
      "title": "Ownership",
      "desc": "Ownership",
      "type": "ownership",
      "isEnabled": false,
    },
    {
      "title": "Odometer",
      "desc": "Odometer",
      "type": "odometer",
      "isEnabled": false,
    },
    {
      "title": "Location",
      "desc": "Location",
      "type": "location",
      "isEnabled": false,
    },
    {
      "title": "Specifications",
      "desc": "Specifications",
      "type": "specifications",
      "isEnabled": false,
    },
    {
      "title": "Contact Information",
      "desc": "ContactInformation",
      "type": "contactInformation",
      "isEnabled": false,
    },
    {
      "title": "Photos",
      "desc": "Photos",
      "type": "photos",
      "isEnabled": false,
    },
  ];

  int currentSelectedTab = 0;

  GetAllMakeResponseModel? getAllMakeResponseModel;

  TextEditingController vinController = TextEditingController();

  late Widget productSellBrandsScreen;
  late Widget productSellPeriodScreen;
  late Widget productSellModelScreen;
  late Widget productSellVariantScreen;
  late Widget productSellOwnerShipScreen;
  late Widget productSellOdometerScreen;
  late Widget productSellLocationScreen;
  late Widget productSellSpecificationScreen;
  late Widget productSellContactInfoScreen;
  late Widget productSellVehicleImageUploadScreen;
  List<Widget> screenList = [];

  // TextEditingController(text: "1HGBH41JXMN109186");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productSellBrandsScreen = ProductSellBrandsScreen(
      onNext: (data) {
        ProductSellJourneyScreen.addCarRequestModel.makeId = data.id;
        setState(() {
          currentSelectedTab++;
          itemScrollController.scrollTo(
            index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
            duration: Duration(seconds: 1),
          );
        });
      },
    );
    productSellPeriodScreen = ProductSellPeriodScreen(
      onNext: (data) {
        ProductSellJourneyScreen.addCarRequestModel.periodId = data.id;
        ProductSellJourneyScreen.addCarRequestModel.year = data.year;
        setState(() {
          currentSelectedTab++;
          itemScrollController.scrollTo(
            index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
            duration: Duration(seconds: 1),
          );
        });
      },
    );
    productSellModelScreen = ProductSellModelScreen(
      onNext: (data) {
        ProductSellJourneyScreen.addCarRequestModel.modelId = data.id;
        setState(() {
          currentSelectedTab++;
          itemScrollController.scrollTo(
            index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
            duration: Duration(seconds: 1),
          );
        });

        // callAddCarApi(addCarRequestModel, 3);
      },
    );
    productSellVariantScreen = ProductSellVariantScreen(
      onNext: (data) {
        ProductSellJourneyScreen.addCarRequestModel.variantId = data.id;
        ProductSellJourneyScreen.addCarRequestModel.variantName =
            data.variantName;
        ProductSellJourneyScreen.addCarRequestModel.fuelType = data.fuelType;
        setState(() {
          currentSelectedTab++;
          itemScrollController.scrollTo(
            index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
            duration: Duration(seconds: 1),
          );
        });

        // callAddCarApi(addCarRequestModel, 4);
      },
    );
    productSellOwnerShipScreen = ProductSellOwnerShipScreen(
      onNext: (data) {
        ProductSellJourneyScreen.addCarRequestModel.ownership = data;
        setState(() {
          currentSelectedTab++;
          itemScrollController.scrollTo(
              index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
              duration: Duration(seconds: 1),
              curve: Curves.bounceOut);
        });

        // callAddCarApi(addCarRequestModel, 5);
      },
    );
    productSellOdometerScreen = ProductSellOdometerScreen(
      onNext: (data) {
        ProductSellJourneyScreen.addCarRequestModel.odometer = data;
        setState(() {
          currentSelectedTab++;
          itemScrollController.scrollTo(
            index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
            duration: Duration(seconds: 1),
          );
        });

        // callAddCarApi(addCarRequestModel, 6);
      },
    );
    productSellLocationScreen = ProductSellLocationScreen(
      onNext: (data) {
        Location location = Location(city: data, latitude: 1, longitude: 1);
        ProductSellJourneyScreen.addCarRequestModel.location = location;
        callAddCarApi(ProductSellJourneyScreen.addCarRequestModel, 6);
      },
    );
    productSellSpecificationScreen = ProductSellSpecificationScreen(
      onNext: (data) {
        callAddSpecificationApi(data, 7);
      },
      carId: ProductSellJourneyScreen.addCarRequestModel.id ?? 0,
    );
    productSellContactInfoScreen = ProductSellContactInfoScreen(
      onNext: (data) {
        ContactInfo contactInfo = ContactInfo(
            name: data.name,
            phoneNo: data.phoneNo,
            zipCode: data.zipCode,
            countryName: data.countryName,
            countryCode: data.countryCode);

        ProductSellJourneyScreen.addCarRequestModel.contactInfo = contactInfo;
        callAddCarApi(ProductSellJourneyScreen.addCarRequestModel, 8);
      },
    );
    productSellVehicleImageUploadScreen = ProductSellVehicleImageUploadScreen(
      onNext: (data) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Success"),
        ));
        // _tabController.index = 1;
      },
    );

    screenList.add(productSellBrandsScreen);
    screenList.add(productSellPeriodScreen);
    screenList.add(productSellModelScreen);
    screenList.add(productSellVariantScreen);
    screenList.add(productSellOwnerShipScreen);
    screenList.add(productSellOdometerScreen);
    screenList.add(productSellLocationScreen);
    screenList.add(productSellSpecificationScreen);
    screenList.add(productSellContactInfoScreen);
    screenList.add(productSellVehicleImageUploadScreen);

    if (ProductSellJourneyScreen.addCarRequestModel.makeId != null &&
        ProductSellJourneyScreen.addCarRequestModel.makeId! > 0) {
      currentSelectedTab = 1;
    }
    if (ProductSellJourneyScreen.addCarRequestModel.periodId != null &&
        ProductSellJourneyScreen.addCarRequestModel.periodId! > 0) {
      currentSelectedTab = 2;
    }
    if (ProductSellJourneyScreen.addCarRequestModel.modelId != null &&
        ProductSellJourneyScreen.addCarRequestModel.modelId! > 0) {
      currentSelectedTab = 3;
    }
    if (ProductSellJourneyScreen.addCarRequestModel.variantId != null &&
        ProductSellJourneyScreen.addCarRequestModel.variantId! > 0) {
      currentSelectedTab = 4;
    }
    if (ProductSellJourneyScreen.addCarRequestModel.ownership != null &&
        ProductSellJourneyScreen.addCarRequestModel.ownership!
            .trim()
            .isNotEmpty) {
      currentSelectedTab = 5;
    }
    if (ProductSellJourneyScreen.addCarRequestModel.odometer != null &&
        ProductSellJourneyScreen.addCarRequestModel.odometer!
            .trim()
            .isNotEmpty) {
      currentSelectedTab = 6;
    }
    if (ProductSellJourneyScreen.addCarRequestModel.location != null) {
      currentSelectedTab = 7;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                buildTabList(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: screenList[currentSelectedTab],
                )
              ],
            ),
          ),
        ));
  }

  final itemScrollController = ItemScrollController();

  Widget buildTabList() {
    return Container(
        height: 30,
        child: ScrollablePositionedList.separated(
            padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: tabItems.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => setState(() {
                  if(index < currentSelectedTab )
                  currentSelectedTab = index;
                }),
                child: currentSelectedTab > index
                    ? buildCompletedTab(index)
                    : currentSelectedTab == index
                        ? buildSelectedTab(index)
                        : currentSelectedTab < index
                            ? buildTab(index)
                            : SizedBox(),
              );
            },
            itemScrollController: itemScrollController,
            separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                )));
  }

  Widget buildTab(int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.3, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      child: Text(
        tabItems[index]["title"].toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildCompletedTab(int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.green,
        // border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      child: Text(
        tabItems[index]["title"].toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildSelectedTab(int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.3, color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      child: Text(
        tabItems[index]["title"].toString(),
        style: TextStyle(
            color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  void callAddCarApi(AddCarRequestModel addCarRequestModel, indexNext) {
    addCarRequestModel.id = ProductSellJourneyScreen.addCarRequestModel.id;
    setState(() {
      showLoaderDialog(context);
      isDataLoading = true;
    });

    Future<AddCarResponseModel> response =
        ApiService(context).addCar(addCarRequestModel);
    response
        .then((value) => {
              setState(() {
                ProductSellJourneyScreen.addCarRequestModel.id = value.data!.id;
                currentSelectedTab++;
                itemScrollController.scrollTo(
                  index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
                  duration: Duration(seconds: 1),
                );
              }),
              Navigator.pop(context),

              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(value.message),
              // )),
            })
        .catchError((onError) {
      Navigator.pop(context);
      setState(() {
        isDataLoading = false;
      });
    });
  }

  void callAddSpecificationApi(
      AddSpecificationRequestModel addSpecificationRequestModel, indexNext) {
    addSpecificationRequestModel.carId =
        ProductSellJourneyScreen.addCarRequestModel.id;
    setState(() {
      showLoaderDialog(context);
      isDataLoading = true;
    });

    Future<AddSpecificationResponseModel> response =
        ApiService(context).addSpecification(addSpecificationRequestModel);
    response
        .then((value) => {
              setState(() {
                // carId = value.data.id;
                currentSelectedTab++;
                itemScrollController.scrollTo(
                  index: currentSelectedTab > 0 ? currentSelectedTab - 1 : 0,
                  duration: Duration(seconds: 1),
                );
              }),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
              Navigator.pop(context),
            })
        .catchError((onError) {
      Navigator.pop(context);
      setState(() {
        isDataLoading = false;
      });
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
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
}
