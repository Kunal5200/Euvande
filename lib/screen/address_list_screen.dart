import 'package:euvande/model/request/EditAddressRequestModel.dart';
import 'package:euvande/model/response/AddAddressResponseModel.dart';
import 'package:euvande/model/response/EditAddressResponseModel.dart';
import 'package:euvande/model/response/GetAddressResponseModel.dart';
import 'package:euvande/screen/add_address_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  bool isDataLoading = true;
  GetAddressResponseModel? getAddressResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callGetAddressApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address List"),
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
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemCount: getAddressResponseModel!.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 1),
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
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: RadioListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text(
                                                "Make default address"),
                                            value: getAddressResponseModel!
                                                .data[index].isDefault,
                                            groupValue: getAddressResponseModel!
                                                    .data[index].isDefault
                                                ? true
                                                : null,
                                            onChanged: (bool? value) {
                                              callEditAddressApi(
                                                  getAddressResponseModel!
                                                      .data[index]);
                                            },
                                          ),
                                        ),
                                        Text(
                                          "${getAddressResponseModel!.data[index].addressType.toUpperCase()}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "${getAddressResponseModel!.data[index].street}, ${getAddressResponseModel!.data[index].houseNo}, ${getAddressResponseModel!.data[index].city}, ${getAddressResponseModel!.data[index].country}, ${getAddressResponseModel!.data[index].postalCode} ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () => {
                                                _navigateAddressScreen(
                                                    context,
                                                    getAddressResponseModel!
                                                        .data[index])
                                              },
                                              child: Text(
                                                "Edit Address",
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black54,
                                                          offset: Offset(0, -3))
                                                    ],
                                                    color: Colors.transparent,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            InkWell(
                                              onTap: () => {
                                                showModalBottomSheet<void>(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  backgroundColor: Colors.white,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: SizedBox(
                                                        height: 150,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Are you sure to delete this address ?",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  16,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width / 2 - 30,
                                                                  padding: EdgeInsets.only(right: 10),
                                                                  child: OutlinedButton(
                                                                    style: raisedButtonStyleFormOutline,
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                                                    ),
                                                                    onPressed: () {
                                                                       Navigator.pop(context);
                                                                    },
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width / 2 - 30,
                                                                  padding: EdgeInsets.only(left: 10),
                                                                  child: ElevatedButton(
                                                                    style: raisedButtonStyleForm,
                                                                    child: Text(
                                                                      'Save Change',
                                                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                                                    ),
                                                                    onPressed: () {
                                                                      callRemoveAddressApi(
                                                                          getAddressResponseModel!
                                                                              .data[index].id);
                                                                      Navigator.pop(context);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),

                                              },
                                              child: Text(
                                                "Remove Address",
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.red,
                                                          offset: Offset(0, -3))
                                                    ],
                                                    color: Colors.transparent,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          GestureDetector(
                            onTap: () {
                              _navigateAddressScreen(context, null);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "+ Add New Address",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ));
  }

  Future<void> _navigateAddressScreen(
      BuildContext context, GetAddressData? getAddressData) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAddressScreen(getAddressData)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    if (result != null) {
      callGetAddressApi();
    }
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  void callGetAddressApi() {
    setState(() {
      isDataLoading = true;
    });

    Future<GetAddressResponseModel> response =
        ApiService(context).getAddresses();
    response
        .then((value) => {
              setState(() {
                isDataLoading = false;
              }),
              getAddressResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }

  void callRemoveAddressApi(int addressId) {
    setState(() {
      isDataLoading = true;
    });

    Future<AddAddressResponseModel> response =
        ApiService(context).removeAddress(addressId);
    response
        .then((value) => {
              callGetAddressApi()
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }

  void callEditAddressApi(GetAddressData getAddressData) {
    setState(() {
      isDataLoading = true;
    });

    EditAddressRequestModel editAddressRequestModel =
        EditAddressRequestModel.fromJson(getAddressData.toJson());
    editAddressRequestModel.isDefault = true;

    Future<EditAddressResponseModel> response =
        ApiService(context).editAddress(editAddressRequestModel);
    response
        .then((value) => {
              callGetAddressApi(),
              setState(() {
                isDataLoading = false;
              }),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message),
              )),
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }
}
