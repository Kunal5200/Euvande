import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/response/AddCarResponseModel.dart';
import 'package:euvande/model/response/DeleteCarResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/screen/product_sell_vin_screen.dart';
import 'package:euvande/screen/temp_product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellDashboardScreen extends StatefulWidget {
  static GetPendingCarsResponseModel? getPendingCarsResponseModel;

  const ProductSellDashboardScreen({super.key});

  @override
  State<ProductSellDashboardScreen> createState() =>
      _ProductSellDashboardScreenState();
}

class _ProductSellDashboardScreenState
    extends State<ProductSellDashboardScreen> {
  bool isBrandLoading = true;
  bool isPendingCarLoading = true;
  GetAllMakeResponseModel? getAllMakeResponseModel;
  late LoginResponseModel? loginResponseModel;

  TextEditingController vinController = TextEditingController();

  // TextEditingController(text: "1HGBH41JXMN109186");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductSellDashboardScreen.getPendingCarsResponseModel = null;
    ProductSellJourneyScreen.addCarRequestModel = AddCarRequestModel();
    ProductSellJourneyScreen.addSpecificationRequestModel =
        AddSpecificationRequestModel();

    SharedPrefManager.getLoginData().then((value) => {
          setState(() {
            loginResponseModel = value;
            if (loginResponseModel != null) {
              callGetPendingCarsApi(null);
            } else {
              isPendingCarLoading = false;
              callGetAllMakeApi();
            }
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Sell Dashboard"),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTitleSection(),
                isPendingCarLoading
                    ? _showLoader()
                    : ProductSellDashboardScreen
                    .getPendingCarsResponseModel!=
                    null && ProductSellDashboardScreen
                            .getPendingCarsResponseModel!.data.isNotEmpty
                        ? _buildSelectedProductSection()
                        : SizedBox(),
                isBrandLoading ? _showLoader() : _buildProductSection(),
              ],
            ),
          ),
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
            "Sell your car at",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "the best price",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedProductSection() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          Text(
            "Thanks for sharing the details",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ProductSellDashboardScreen
                  .getPendingCarsResponseModel!.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPrefilledDetailsSection(index);
              }),
        ],
      ),
    );
  }

  Widget _buildPrefilledDetailsSection(int index) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black12)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: !ProductSellDashboardScreen
                                .getPendingCarsResponseModel!
                                .data[index]
                                .make!
                                .logo
                                .isEmpty
                            ? NetworkImage(
                                // "https://euvande-dev.s3.eu-central-1.amazonaws.com/" +
                                ProductSellDashboardScreen
                                    .getPendingCarsResponseModel!
                                    .data[index]
                                    .make!
                                    .logo) as ImageProvider
                            : AssetImage("assets/icons/ic_car.webp")),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].period!.year}"
                      "  ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].make!.makeName} ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].model!.modelName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].variant != null ? ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].variant!.fuelType + " »  " + ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].variant!.variantName : ""}",
                          //${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].specification!.transmission}
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: raisedButtonStyleRound,
              child: Text(
                'Book Appointment',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onPressed: () {
                setSelectedData(index);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TempProductSellJourneyScreen()),
                );
              },
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                callDeleteCarAPI(ProductSellDashboardScreen
                    .getPendingCarsResponseModel!.data[index].id);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Remove details',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            )
          ],
        ));
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
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your car vehicle identification number",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
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
          ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              'Sell my car'.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              // if (vinController.text.trim().isNotEmpty) {
                AddCarRequestModel addCarRequestModel = AddCarRequestModel();
                addCarRequestModel.vin = vinController.text;
                // callAddCarApi(addCarRequestModel);

              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text("Please input valid VIN number"),
              //   ));
              // }
            },
          ),
          Row(
            children: [
              Expanded(child: Divider()),
              Text(
                " OR ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Divider()),
            ],
          ),
          Text(
            "Select your car brand",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          isBrandLoading ? _showLoader() : _buildBrandsSection(),
        ],
      ),
    );
  }

  Widget _buildBrandsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 330,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(
                getAllMakeResponseModel!.data.length > 8
                    ? 9
                    : getAllMakeResponseModel!.data.length, (index) {
              return index < 8
                  ? Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: InkWell(
                        onTap: () {
                          ProductSellDashboardScreen
                              .getPendingCarsResponseModel = null;
                          ProductSellJourneyScreen.addCarRequestModel.makeId =
                              getAllMakeResponseModel!.data[index].id;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TempProductSellJourneyScreen()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 45.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: !getAllMakeResponseModel!
                                          .data[index].logo
                                          .trim()
                                          .isEmpty
                                      ? NetworkImage(getAllMakeResponseModel!
                                          .data[index].logo) as ImageProvider
                                      : AssetImage("assets/icons/ic_car.webp"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              getAllMakeResponseModel!.data[index].makeName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TempProductSellJourneyScreen()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View All\nBrands",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ));
            }),
          ),
        )
      ],
    );
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  void callGetAllMakeApi() {
    setState(() {
      isBrandLoading = true;
    });

    Future<GetAllMakeResponseModel> response = ApiService(context).getAllMake();
    response
        .then((value) => {
              setState(() {
                isBrandLoading = false;
              }),
              getAllMakeResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isBrandLoading = false;
      });
    });
  }

  void callGetPendingCarsApi(String? vin) {
    setState(() {
      isPendingCarLoading = true;
    });

    Future<GetPendingCarsResponseModel> response =
    ApiService(context).getPendingCars("In-Progress");
    response
        .then((value) => {
      setState(() {
        isPendingCarLoading = false;
      }),
      ProductSellDashboardScreen.getPendingCarsResponseModel = value,
      if (vin == null)
        {
          callGetAllMakeApi(),
        }
      else
        {
          for (int index = 0; index < value.data.length; index++)
            {
              if (vin == value.data[index].vin) {setSelectedData(index)}
            }
        }
    })
        .catchError((onError) {
      setState(() {
        isPendingCarLoading = false;
      });
    });
  }

  void callGetCarDetailsApi(String carId)   {
    setState(() {
      isPendingCarLoading = true;
    });

    Future<GetPendingCarsResponseModel> response =
    ApiService(context).getPendingCars("In-Progress");
    response
        .then((value) => {
      setState(() {
        isPendingCarLoading = false;
      }),
      ProductSellDashboardScreen.getPendingCarsResponseModel = value,

    })
        .catchError((onError) {
      setState(() {
        isPendingCarLoading = false;
      });
    });
  }

  void callAddCarApi(AddCarRequestModel addCarRequestModel) {
    setState(() {
      showLoaderDialog(context);
    });

    Future<AddCarResponseModel> response =
        ApiService(context).addCar(addCarRequestModel);
    response
        .then((value) => {
              setState(() {
                ProductSellJourneyScreen.addCarRequestModel.id = value.data!.id;
                ProductSellJourneyScreen.addSpecificationRequestModel.carId =
                    value.data!.id;
              }),
              Navigator.pop(context),
              // callGetPendingCarsApi(addCarRequestModel.vin),
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(value.message),
              // )),
            })
        .catchError((onError) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.message),
      ));
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

  setSelectedData(int index) {
    ProductSellJourneyScreen.addCarRequestModel.id =
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].id;
    // ProductSellJourneyScreen.addCarRequestModel.vin =
    //     ProductSellDashboardScreen
    //         .getPendingCarsResponseModel!.data[index].vin;
    ProductSellJourneyScreen.addCarRequestModel.makeId =
        ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].make!.id;
    ProductSellJourneyScreen.addCarRequestModel.periodId =
        ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].period!.id;
    ProductSellJourneyScreen.addCarRequestModel.year =
        ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].period!.year;
    ProductSellJourneyScreen.addCarRequestModel.modelId =
        ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].model!.id;
    ProductSellJourneyScreen.addCarRequestModel.variantId =
        ProductSellDashboardScreen
                    .getPendingCarsResponseModel!.data[index].variant !=
                null
            ? ProductSellDashboardScreen
                .getPendingCarsResponseModel!.data[index].variant!.id
            : null;
    ProductSellJourneyScreen.addCarRequestModel.ownership =
        ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].ownership;
    ProductSellJourneyScreen.addCarRequestModel.odometer =
        ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].odometer;

    ProductSellJourneyScreen.addSpecificationRequestModel.carId =
        ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index].id;

    if (ProductSellDashboardScreen
            .getPendingCarsResponseModel!.data[index].specification !=
        null) {
      ProductSellJourneyScreen.addSpecificationRequestModel.driveType4Wd =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index]
              .specification!.driveType4Wd;
      ProductSellJourneyScreen.addSpecificationRequestModel.doors =
          ProductSellDashboardScreen
              .getPendingCarsResponseModel!.data[index].specification!.doors;
      ProductSellJourneyScreen.addSpecificationRequestModel.interiorMaterial =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index]
              .specification!.interiorMaterial;
      ProductSellJourneyScreen.addSpecificationRequestModel.seats =
          ProductSellDashboardScreen
              .getPendingCarsResponseModel!.data[index].specification!.seats;
      ProductSellJourneyScreen.addSpecificationRequestModel.transmission =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index]
              .specification!.transmission;
      ProductSellJourneyScreen.addSpecificationRequestModel.vatDeduction =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index]
              .specification!.vatDeduction;
      ProductSellJourneyScreen.addSpecificationRequestModel.vehicleType =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index]
              .specification!.vehicleType;
      ProductSellJourneyScreen.addSpecificationRequestModel.power =
          ProductSellDashboardScreen
              .getPendingCarsResponseModel!.data[index].specification!.power;
      ProductSellJourneyScreen.addSpecificationRequestModel.color =
          ProductSellDashboardScreen
              .getPendingCarsResponseModel!.data[index].specification!.color;
      ProductSellJourneyScreen.addSpecificationRequestModel.equipments =
          ProductSellDashboardScreen.getPendingCarsResponseModel!.data[index]
              .specification!.equipments;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TempProductSellJourneyScreen()),
    );
  }

}
