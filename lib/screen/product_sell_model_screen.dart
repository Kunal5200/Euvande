import 'package:euvande/model/request/GetModelRequestModel.dart';
import 'package:euvande/model/response/GetModelResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductSellModelScreen extends StatefulWidget {

  const ProductSellModelScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellModelScreen> createState() => _ProductSellModelScreenState();
}

class _ProductSellModelScreenState extends State<ProductSellModelScreen> {
  bool isDataLoading = true;
  GetModelResponseModel? getModelResponseModel;
  List<ModelData> originalData = [];

  int currentSelectedPeriod = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callGetModelByMakeApi();
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
          isDataLoading ? _showLoader() : _buildYearListSection(),
        ],
      ),
    );
  }

  Widget _buildNoData() {
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 50,),
          Text("Sorry, model not found", style: TextStyle(fontSize: 18),),
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

      getModelResponseModel!.data.clear();

      if (text.trim().isEmpty) {
        getModelResponseModel!.data.addAll(originalData);
      } else {
        originalData.forEach((data) {
          if (data.modelName.toString().toLowerCase().contains(text.toLowerCase()))
            getModelResponseModel!.data.add(data);
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

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select the model",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildYearListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSearch(),
        SizedBox(
          height: 10,
        ),
        getModelResponseModel!.data.length ==0 ? _buildNoData() :
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: getModelResponseModel!.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector( behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        currentSelectedPeriod = index;
                      });
                      widget.onNext(getModelResponseModel!.data[index]);
                    },
                    child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "  ${getModelResponseModel!.data[index].modelName}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: currentSelectedPeriod == index
                                          ? Colors.black
                                          : Colors.black54,
                                      fontWeight:
                                      currentSelectedPeriod == index
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                Spacer(),
                                Text(
                                  "${currentSelectedPeriod == index ? "✓   "
                                      "" : ""}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.black26,
                            ),
                          ],
                        )),
                  ),
                );
              }),
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

  void callGetModelByMakeApi() {
    GetModelRequestModel getModelRequestModel =
        GetModelRequestModel(makeId: ProductSellJourneyScreen.addCarRequestModel.makeId!.toInt(), periodYear: ProductSellJourneyScreen.addCarRequestModel.year!.toInt());
    setState(() {
      isDataLoading = true;
    });

    Future<GetModelResponseModel> response =
        ApiService(context).getModel(getModelRequestModel);
    response
        .then((value) => {

              getModelResponseModel = value,
      originalData.addAll(value.data),
      setState(() {

        for(int index =0; index<value.data.length;index++){
          if(ProductSellJourneyScreen.addCarRequestModel.modelId ==
              value.data[index].id){
            currentSelectedPeriod = index;
            break;
          }
        }

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
