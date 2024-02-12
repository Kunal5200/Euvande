import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/response/DeleteCarResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellDashboardScreen extends StatefulWidget {

  static late GetPendingCarsResponseModel? getPendingCarsResponseModel;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callGetPendingCarsApi();
    callGetAllMakeApi();
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
                    : ProductSellDashboardScreen.getPendingCarsResponseModel == null
                        ? _showLoader()
                        : ProductSellDashboardScreen.getPendingCarsResponseModel!.data.isNotEmpty
                            ? _buildSelectedProductSection()
                            : _buildProductSection(),
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
          _buildPrefilledDetailsSection(),
        ],
      ),
    );
  }

  Widget _buildPrefilledDetailsSection() {
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
                        image: NetworkImage(
                            "https://euvande-dev.s3.eu-central-1.amazonaws.com/" +
                                ProductSellDashboardScreen.getPendingCarsResponseModel!
                                    .data[0].make!.logo)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].period!.year}  ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].make!.makeName} ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].model!.modelName} ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].variant!.fuelType}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].variant!.fuelType} »  ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].ownership} Owner",
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
                ProductSellJourneyScreen.addCarRequestModel.makeId = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].make!.id;
                ProductSellJourneyScreen.addCarRequestModel.periodId = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].period!.id;
                ProductSellJourneyScreen.addCarRequestModel.year = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].period!.year;
                ProductSellJourneyScreen.addCarRequestModel.modelId = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].model!.id;
                ProductSellJourneyScreen.addCarRequestModel.variantId = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].variant!.id;
                ProductSellJourneyScreen.addCarRequestModel.ownership = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].ownership;
                ProductSellJourneyScreen.addCarRequestModel.odometer = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].odometer;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductSellJourneyScreen(null)),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                callDeleteCarAPI(ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].id);
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

    Future<DeleteCarResponseModel> response = ApiService(context).deleteCar(id.toString());
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
            "Enter your card vehicle identification number",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Coming Soon"),
              ));
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductSellJourneyScreen(
                                    getAllMakeResponseModel!.data[index])),
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
                                    image: NetworkImage(getAllMakeResponseModel!
                                        .data[index].logo)),
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
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductSellJourneyScreen(null)),
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

  void callGetPendingCarsApi() {
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
              ProductSellDashboardScreen.getPendingCarsResponseModel = value
            })
        .catchError((onError) {
      setState(() {
        isPendingCarLoading = false;
      });
    });
  }
}
