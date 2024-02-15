import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/screen/pending_product_details_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:flutter/material.dart';

class PendingProductListScreen extends StatefulWidget {
  const PendingProductListScreen({super.key});

  @override
  State<PendingProductListScreen> createState() => _PendingProductListScreenState();
}

class _PendingProductListScreenState extends State<PendingProductListScreen> {
  bool isDataLoading = true;
  GetPendingCarsResponseModel? getPendingCarsResponseModel;

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
          title: Text("Pending For Approval"),
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
                                padding: const EdgeInsets.all(8),
                                itemCount: getPendingCarsResponseModel!
                                    .data.length,
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
                                          MaterialPageRoute(
                                              builder: (context) =>  PendingProductDetailsScreen(getPendingCarsResponseModel!.data[index])),
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
                                                      getPendingCarsResponseModel!.data[index].carImages.length>0 ?
                                                      NetworkImage(getPendingCarsResponseModel!.data[index].carImages[0]) as ImageProvider:
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
                                                "${getPendingCarsResponseModel!.data[index].period!.year}  ${getPendingCarsResponseModel!.data[index].make!.makeName} ${getPendingCarsResponseModel!.data[index].model!.modelName} ${getPendingCarsResponseModel!.data[index].variant!.fuelType}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                // "50,000 km • CNG • Manual",
                                                "${getPendingCarsResponseModel!.data[index].variant!.fuelType} »  ${getPendingCarsResponseModel!.data[index].ownership} Owner",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Text(
                                                // "€ 47899",
                                                "€ ${getPendingCarsResponseModel!.data[index].price}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
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
                                                    // "${getPendingCarsResponseModel!.data[index].variant!.fuelType} »  ${getPendingCarsResponseModel!.data[index].ownership} Owner",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
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

  void callGetPendingCarsApi() {
    setState(() {
      isDataLoading = true;
    });

    Future<GetPendingCarsResponseModel> response =
        ApiService(context).getPendingCars("Pending");
    response
        .then((value) => {
      getPendingCarsResponseModel = value,
              setState(() {
                isDataLoading = false;
              }),
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }
}
