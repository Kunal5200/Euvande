import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/model/request/GetPeriodByMakeRequestModel.dart';
import 'package:euvande/model/response/GetPeriodByMakeResponseModel.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductSellPeriodScreen extends StatefulWidget {
  const ProductSellPeriodScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellPeriodScreen> createState() =>
      _ProductSellPeriodScreenState();
}

class _ProductSellPeriodScreenState extends State<ProductSellPeriodScreen> {
  bool isDataLoading = true;
  GetPeriodByMakeResponseModel? getPeriodByMakeResponseModel;
   List<GetPeriodByMakeData> originalData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetPeriodByMakeApi();
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
            isDataLoading ? _showLoader() : _buildYearListSection(),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {


    setState(() {
      getPeriodByMakeResponseModel!.data.clear();

      if (text.trim().isEmpty) {
        getPeriodByMakeResponseModel!.data.addAll(originalData);

        print("onSearchTextChanged");
        print(originalData.length);
        print(getPeriodByMakeResponseModel!.data);

      } else {
        originalData.forEach((data) {
          if (data.year.toString().contains(text))
            getPeriodByMakeResponseModel!.data.add(data);
        });
      }
    });
  }

  Widget _buildSearch() {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
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
            "Select the registration year",
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
        Container(
          height: 450,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: getPeriodByMakeResponseModel!.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      widget.onNext(getPeriodByMakeResponseModel!.data[index]);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  ${getPeriodByMakeResponseModel!.data[index].year}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
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

  void callGetPeriodByMakeApi() {
    GetPeriodByMakeRequestModel getPeriodByMakeRequestModel =
        GetPeriodByMakeRequestModel(
            makeId:
                ProductSellJourneyScreen.addCarRequestModel.makeId!.toInt());
    setState(() {
      isDataLoading = true;
    });

    Future<GetPeriodByMakeResponseModel> response =
        ApiService(context).getPeriodByMake(getPeriodByMakeRequestModel);
    response
        .then((value) => {
              getPeriodByMakeResponseModel = value,
              originalData.addAll(value.data),

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
