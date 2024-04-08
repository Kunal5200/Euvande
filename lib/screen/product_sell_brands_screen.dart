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
  int currentSelectedBrand = -1;

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
            SizedBox(
              height: 50,
            ),
            Text(
              "Sorry, brand not found",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(
                  'assets/lottie/nodata.json',
                )),
          ],
        ));
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
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(getAllMakeResponseModel!.data.length,
                      (index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          currentSelectedBrand = index;
                        });
                        widget.onNext(getAllMakeResponseModel!.data[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: currentSelectedBrand == index ? 1.5 : 1,
                                color: currentSelectedBrand == index
                                    ? Colors.black
                                    : Colors.black54),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: currentSelectedBrand == index
                                ? Color(0x1D06599D)
                                : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 45.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: getAllMakeResponseModel!
                                            .data[index].logo.isNotEmpty
                                        ? NetworkImage(getAllMakeResponseModel!
                                            .data[index].logo) as ImageProvider
                                        : AssetImage(
                                            "assets/icons/ic_car.webp")),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              getAllMakeResponseModel!.data[index].makeName,
                              style: TextStyle(
                                color: currentSelectedBrand == index
                                    ? Colors.black
                                    : Colors.black54,
                                fontWeight: currentSelectedBrand == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14,
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
              getAllMakeResponseModel = value,
              originalData.addAll(value.data),
              setState(() {

                for(int index =0; index<value.data.length;index++){
                  if(ProductSellJourneyScreen.addCarRequestModel.makeId ==
                      value.data[index].id){
                      currentSelectedBrand = index;
                    break;
                  }
                }

                isBrandLoading = false;
              }),
            })
        .catchError((onError) {
      setState(() {
        isBrandLoading = false;
      });
    });
  }
}
