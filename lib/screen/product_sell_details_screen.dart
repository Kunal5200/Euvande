import 'package:euvande/main.dart';
import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/response/AddCarResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/model/response/SendForApprovalResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellDetailsScreen extends StatefulWidget {
  const ProductSellDetailsScreen({super.key});

  @override
  State<ProductSellDetailsScreen> createState() =>
      _ProductSellDetailsScreenState();
}

class _ProductSellDetailsScreenState extends State<ProductSellDetailsScreen> {

  bool isPendingCarLoading = true;
  bool isPriceAdded = false;
  GetAllMakeResponseModel? getAllMakeResponseModel;
  final TextEditingController cityController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetPendingCarsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Review Details"),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                // horizontal: 40.0,
                // vertical: 120.0,
                ),
            child: isPendingCarLoading
                ? _showLoader()
                : Column(
                    children: [
                      _buildProductOverviewSection(),
                      _buildProductGallerySection(),
                      !isPriceAdded ?
                      _buildAddPriceSection() :
                      _buildSubmitButtonSection(),
                    ],
                  ),
          ),
        ));
  }

  Widget _buildProductOverviewSection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].period!.year}  ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].make!.makeName} ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].model!.modelName}",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].odometer} • ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].variant!.fuelType} • ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.transmission} • ${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].ownership} Owner",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoRow(null, "Fuel Type", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].variant!.fuelType),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Vehicle Type", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.vehicleType.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Doors", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.doors.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Drive Type 4X4", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.driveType4Wd.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Seats", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.seats.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Interior Material", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.interiorMaterial.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "POSSIBILITY OF VAT DEDUCTION", ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].specification!.vatDeduction.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "KMS Driven", "${ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].odometer}"),

        ],
      ),
    );
  }

  Widget _buildProductGallerySection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Images",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(
                ProductSellDashboardScreen.getPendingCarsResponseModel!
                    .data[0].carImages.length, (index) {
              return Center(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ProductSellDashboardScreen
                            .getPendingCarsResponseModel!
                            .data[0]
                            .carImages[index])),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 16,
            color: Colors.black45,
          ),
        if (icon != null)
          SizedBox(
            width: 10,
          ),
        Text(
          title,
          style: TextStyle(color: Colors.black45, fontSize: 12),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddPriceSection() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: TextField(
          controller: cityController,
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            labelText: 'Enter Expected Price',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            prefixIcon: Icon(Icons.euro, size: 24),
          ),
          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: ElevatedButton(
          style: raisedButtonStyle,
          child: Text(
            'Add Price',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            if (cityController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please enter expected price of your car"),
              ));
            } else {
              ProductSellJourneyScreen.addCarRequestModel.price = int.parse(cityController.text);
              callAddCarApi(ProductSellJourneyScreen.addCarRequestModel, 6);
            }
          },
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }

  Widget _buildSubmitButtonSection() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: ElevatedButton(
          style: raisedButtonStyle,
          child: Text(
            'Submit for review',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () {
            callSendForApprovalApi();
          },
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            "Edit Details",
            style: TextStyle(
                color: Colors.black45, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController.dispose();
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
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

  void callAddCarApi(AddCarRequestModel addCarRequestModel, indexNext) {
    addCarRequestModel.id = ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].id;
    setState(() {
      showLoaderDialog(context);
    });

    Future<AddCarResponseModel> response =
    ApiService(context).addCar(addCarRequestModel);
    response
        .then((value) => {
    setState(() {
   isPriceAdded = true;
    }),
      Navigator.pop(context),
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.message),
      )),
    })
        .catchError((onError) {
      Navigator.pop(context);

    });
  }

  void callSendForApprovalApi() {
    setState(() {
      showLoaderDialog(context);
    });

    Future<SendForApprovalResponseModel> response =
    ApiService(context).sendForApproval(ProductSellDashboardScreen.getPendingCarsResponseModel!.data[0].id.toString());
    response
        .then((value) => {
      Navigator.pop(context),
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "")),
          ModalRoute.withName("/MyHomePage")),
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.message),
      )),
    })
        .catchError((onError) {
      Navigator.pop(context);

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
