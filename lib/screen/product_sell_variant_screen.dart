import 'package:euvande/model/request/GetVariantByModelRequestModel.dart';
import 'package:euvande/model/response/GetVariantByModelResponseModel.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:flutter/material.dart';

class ProductSellVariantScreen extends StatefulWidget {
  const ProductSellVariantScreen({super.key, required this.onNext});

  final TabChangeCallback onNext;

  @override
  State<ProductSellVariantScreen> createState() =>
      _ProductSellVariantScreenState();
}

class _ProductSellVariantScreenState extends State<ProductSellVariantScreen> {
  bool isDataLoading = true;

  final List<bool> _selectedTransmission = <bool>[
    true,
    false,
    false,
    false,
    false,
    false
  ];
  List<Widget> transmissionTypes = <Widget>[
    Text('Petrol'),
    Text('Diesel'),
    Text('CNG'),
    Text('LNG'),
    Text('FCV'),
    Text('EV')
  ];

  GetVariantByModelResponseModel? getVariantByModelResponseModel;

  @override
  void initState() {
    super.initState();
    callGetVariantByModelApi("Petrol", ProductSellJourneyScreen.addCarRequestModel.modelId!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildTitleSection(),
            SizedBox(
              height: 10,
            ),
            _buildCategory(),
            isDataLoading ? _showLoader() : _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select variant",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      child: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                callGetVariantByModelApi((transmissionTypes[index] as Text).data!, ProductSellJourneyScreen.addCarRequestModel.modelId!.toInt());
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedTransmission.length; i++) {
                    _selectedTransmission[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.black,
              selectedColor: Colors.black,
              // fillColor: Colors.black26,
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedTransmission,
              children: transmissionTypes,
            ),
          )
        ],
      ),
    );
  }

  void callGetVariantByModelApi(String fuelType, int modelId) {

    GetVariantByModelRequestModel getVariantByModelRequestModel =
        GetVariantByModelRequestModel(fuelType: fuelType, modelId: modelId);
    setState(() {
      isDataLoading = true;
    });

    Future<GetVariantByModelResponseModel> response =
        ApiService(context).getVariantByModel(getVariantByModelRequestModel);
    response
        .then((value) => {
              setState(() {
                isDataLoading = false;
              }),
              getVariantByModelResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }

  Widget _buildList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 450,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: getVariantByModelResponseModel!.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () {

                  widget.onNext(getVariantByModelResponseModel!.data[index]);
                },
                child: Container(
            color: Colors.transparent,
            child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " ${getVariantByModelResponseModel!.data[index]
                          .variantName} ${(ProductSellDashboardScreen
                          .getPendingCarsResponseModel != null &&
                          ProductSellDashboardScreen
                              .getPendingCarsResponseModel!.data.length > 0
                          && ProductSellDashboardScreen
                              .getPendingCarsResponseModel!.data[0].variant!
                              .id == getVariantByModelResponseModel!.data[index].id) ? " ✓" : ""}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }

}
