import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/response/AddCarResponseModel.dart';
import 'package:euvande/model/response/AddSpecificationResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/screen/product_sell_brands_screen.dart';
import 'package:euvande/screen/product_sell_contact_info_screen.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
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

class ProductSellJourneyScreen extends StatefulWidget {
  final GetAllMakeData? selectedBrand;
  static late AddCarRequestModel addCarRequestModel = AddCarRequestModel();

  const ProductSellJourneyScreen(
    this.selectedBrand, {
    super.key,
  });

  @override
  State<ProductSellJourneyScreen> createState() =>
      _ProductSellJourneyScreenState();
}

class _ProductSellJourneyScreenState extends State<ProductSellJourneyScreen>
    with TickerProviderStateMixin {
  int carId = 0;

  bool isDataLoading = false;

  late TabController _tabController;

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

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectedBrand != null) {
      tabItems.removeAt(0);
      ProductSellJourneyScreen.addCarRequestModel.makeId =
          widget.selectedBrand!.id;
    }

    _tabController = TabController(length: tabItems.length, vsync: this);

    if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].media !=
            null) {
      _tabController.index = 9;
    } else if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].contactInfo !=
            null) {
      _tabController.index = 8;
    } else if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].specification !=
            null) {
      _tabController.index = 7;
    } else if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0 &&
        ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[0].location !=
            null) {
      _tabController.index = 6;
    }

    currentIndex = _tabController.index;

    if (ProductSellDashboardScreen.getPendingCarsResponseModel != null &&
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data.length >
            0) {
      carId =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].id;
    }
  }

  void onTap(int index) {
    if (index < _tabController.index) {
      setState(() {
        _tabController.index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          bottom: TabBar(
              onTap: (index) {
                if (_tabController.indexIsChanging) {
                  print(currentIndex);
                  if (index < currentIndex) {
                    _tabController.index = _tabController.index;
                  } else {
                    _tabController.index = _tabController.previousIndex;
                  }
                } else {
                  return;
                }
                // onTap(index);
              },
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 1,
              controller: _tabController,
              tabs: tabItems
                  .map((e) => Container(
                        padding: EdgeInsets.all(20),
                        child: Text(e["title"].toString()),
                      ))
                  .toList()),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: tabItems.map((e) => getScreen(e)).toList(),
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget getScreen(Map<Object, Object> e) {
    switch (e["type"]) {
      case "make":
        return ProductSellBrandsScreen(
          onNext: (data) {
            ProductSellJourneyScreen.addCarRequestModel.makeId = data.id;
            _tabController.index++;
            currentIndex = _tabController.index;
            // callAddCarApi(addCarRequestModel, 1);
          },
        );
      case "period":
        return ProductSellPeriodScreen(
          onNext: (data) {
            ProductSellJourneyScreen.addCarRequestModel.periodId = data.id;
            ProductSellJourneyScreen.addCarRequestModel.year = data.year;
            _tabController.index++;
            currentIndex = _tabController.index;
            // callAddCarApi(addCarRequestModel, 2);
          },
        );
      case "model":
        return ProductSellModelScreen(
          onNext: (data) {
            ProductSellJourneyScreen.addCarRequestModel.modelId = data.id;
            _tabController.index++;
            currentIndex = _tabController.index;
            // callAddCarApi(addCarRequestModel, 3);
          },
        );
      case "variant":
        return ProductSellVariantScreen(
          onNext: (data) {
            ProductSellJourneyScreen.addCarRequestModel.variantId = data.id;
            _tabController.index++;
            currentIndex = _tabController.index;
            // callAddCarApi(addCarRequestModel, 4);
          },
        );
      case "ownership":
        return ProductSellOwnerShipScreen(
          onNext: (data) {
            ProductSellJourneyScreen.addCarRequestModel.ownership = data;
            _tabController.index++;
            currentIndex = _tabController.index;
            // callAddCarApi(addCarRequestModel, 5);
          },
        );
      case "odometer":
        return ProductSellOdometerScreen(
          onNext: (data) {
            ProductSellJourneyScreen.addCarRequestModel.odometer = data;
            _tabController.index++;
            currentIndex = _tabController.index;
            // callAddCarApi(addCarRequestModel, 6);
          },
        );
      case "location":
        return ProductSellLocationScreen(
          onNext: (data) {
            Location location = Location(city: data, latitude: 1, longitude: 1);
            ProductSellJourneyScreen.addCarRequestModel.location = location;
            callAddCarApi(ProductSellJourneyScreen.addCarRequestModel, 6);
          },
        );
      case "specifications":
        return ProductSellSpecificationScreen(
          onNext: (data) {
            callAddSpecificationApi(data, 7);
          },
          carId: carId,
        );
      case "contactInformation":
        return ProductSellContactInfoScreen(
          onNext: (data) {
            ContactInfo contactInfo = ContactInfo(
                name: data.name,
                phoneNo: data.phoneNo,
                zipCode: data.zipCode,
                countryName: data.countryName,
                countryCode: data.countryCode);

            ProductSellJourneyScreen.addCarRequestModel.contactInfo =
                contactInfo;
            callAddCarApi(ProductSellJourneyScreen.addCarRequestModel, 8);
          },
        );
      case "photos":
        return ProductSellVehicleImageUploadScreen(
          onNext: (data) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Success"),
            ));
            // _tabController.index = 1;
          },
          carId: carId,
        );
    }

    return Text("n/a");
  }

  void callAddCarApi(AddCarRequestModel addCarRequestModel, indexNext) {
    addCarRequestModel.id = carId;
    setState(() {
      showLoaderDialog(context);
      isDataLoading = true;
    });

    Future<AddCarResponseModel> response =
        ApiService(context).addCar(addCarRequestModel);
    response
        .then((value) => {
              setState(() {
                carId = value.data!.id;
              }),
              Navigator.pop(context),
              _tabController.index =
                  (tabItems.length == 9 ? indexNext : indexNext + 1),
      currentIndex = _tabController.index,
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
    addSpecificationRequestModel.carId = carId;
    setState(() {
      showLoaderDialog(context);
      isDataLoading = true;
    });

    Future<AddSpecificationResponseModel> response =
        ApiService(context).addSpecification(addSpecificationRequestModel);
    response
        .then((value) => {
              _tabController.index =
                  (tabItems.length == 9 ? indexNext : indexNext + 1),
              currentIndex = _tabController.index,
              carId = value.data.id,
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

typedef TabChangeCallback = void Function(dynamic data);
