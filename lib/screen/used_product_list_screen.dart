import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/model/request/EditAddressRequestModel.dart';
import 'package:euvande/model/request/GetModelRequestModel.dart';
import 'package:euvande/model/response/EditAddressResponseModel.dart';
import 'package:euvande/model/response/GetAddressResponseModel.dart';
import 'package:euvande/model/response/GetCarListResponseModel.dart';
import 'package:euvande/model/response/GetModelResponseModel.dart';
import 'package:euvande/screen/add_address_screen.dart';
import 'package:euvande/screen/product_details_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class UsedProductListScreen extends StatefulWidget {
  const UsedProductListScreen({super.key});

  @override
  State<UsedProductListScreen> createState() => _UsedProductListScreenState();
}

class _UsedProductListScreenState extends State<UsedProductListScreen> {
  bool isDataLoading = true;
  GetCarListResponseModel? getCarListResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callGetCarListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Buy Used Car"),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                // horizontal: 40.0,
                // vertical: 120.0,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isDataLoading
                    ? _showLoader()
                    : Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount:
                                    getCarListResponseModel!.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 1),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurStyle: BlurStyle.outer,
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1), //(x,y)
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ProductDetailsScreen(getCarListResponseModel!.data!.docs[index])),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120.0,
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                  getCarListResponseModel!.data!.docs[index].carImages.isNotEmpty ?
                                                  NetworkImage(getCarListResponseModel!.data!.docs[index].carImages[0]) as ImageProvider:
                                                  AssetImage(
                                                      "assets/images/mercedes/1.jpg")),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // "2015 Mercedes Maybach S-Class",
                                                "${getCarListResponseModel!.data!.docs[index].make!.makeName} ${getCarListResponseModel!.data!.docs[index].model!.modelName}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                // "50,000 km • CNG • Manual",
                                                "${getCarListResponseModel!.data!.docs[index].odometer.isNotEmpty ? getCarListResponseModel!.data!.docs[index].odometer  : "" } ${getCarListResponseModel!.data!.docs[index].specification != null ?   " » " +  getCarListResponseModel!.data!.docs[index].specification!.vehicleType:""}",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Text(
                                                // "€ 47899",
                                                "${getCarListResponseModel!.data!.docs[index].specification == null ? "N/A": getCarListResponseModel!.data!.docs[index].specification!.transmission} »  ${getCarListResponseModel!.data!.docs[index].ownership +"Owner"}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                      .favorite_border_outlined,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    "                                   View Details >",
                                                    // "${getCarListResponseModel!.data!.docs[index].variant!.fuelType} »  ${getCarListResponseModel!.data!.docs[index].ownership} Owner",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                        fontStyle: FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ));
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  void callGetCarListApi() {
    setState(() {
      isDataLoading = true;
    });

    Future<GetCarListResponseModel> response = ApiService(context).getCarList();
    response
        .then((value) => {
              setState(() {
                isDataLoading = false;
              }),
              getCarListResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }
}
