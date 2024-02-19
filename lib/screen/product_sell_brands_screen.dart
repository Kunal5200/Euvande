import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductSellBrandsScreen extends StatefulWidget {
  const ProductSellBrandsScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellBrandsScreen> createState() =>
      _ProductSellBrandsScreenState();
}

class _ProductSellBrandsScreenState extends State<ProductSellBrandsScreen> {
  bool isBrandLoading = true;
  GetAllMakeResponseModel? getAllMakeResponseModel;
  List<GetAllMakeData> originalData = [];

  _ProductSellBrandsScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callGetAllMakeApi();
  }

  Widget _buildNoData() {
    return Container(
        height: 300,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text("Sorry, brand not found", style: TextStyle(fontSize: 18),),
            SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(
                  'assets/lottie/nodata.json',
                )),
          ],
        )
    );
  }

  onSearchTextChanged(String text) async {
    setState(() {
      getAllMakeResponseModel!.data.clear();

      if (text.trim().isEmpty) {
        getAllMakeResponseModel!.data.addAll(originalData);
      } else {
        originalData.forEach((data) {
          if (data.makeName
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
            getAllMakeResponseModel!.data.add(data);
        });
      }
    });
  }

  Widget _buildSearch() {
    return TextField(
      keyboardType: TextInputType.text,
      onChanged: onSearchTextChanged,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffebebeb),
        prefixIcon: Icon(Icons.search_outlined),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: "Search",
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        border: OutlineInputBorder(
            // borderSide: BorderSide.none
            ),
      ),
    );
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
            _buildSearch(),
            isBrandLoading ? _showLoader() : _buildBrandsSection(),
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
            "Select Your Car Brand",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
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
        getAllMakeResponseModel!.data.length == 0
            ? _buildNoData()
            : Container(
                height: 450,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(getAllMakeResponseModel!.data.length,
                      (index) {
                    return GestureDetector( behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.onNext(getAllMakeResponseModel!.data[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:  Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: (ProductSellDashboardScreen
                              .getPendingCarsResponseModel !=
                              null &&
                              ProductSellDashboardScreen
                                  .getPendingCarsResponseModel!
                                  .data
                                  .length >
                                  0 &&
                              ProductSellDashboardScreen
                                  .getPendingCarsResponseModel!
                                  .data[0]
                                  .make!
                                  .id ==
                                  getAllMakeResponseModel!
                                      .data[index].id) ? Color(0x1D06599D) : Colors.transparent
                        ),
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
                                color:  Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
              originalData.addAll(value.data),
            })
        .catchError((onError) {
      setState(() {
        isBrandLoading = false;
      });
    });
  }
}
