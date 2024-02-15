import 'dart:convert';

import 'package:euvande/main.dart';
import 'package:euvande/model/response/GetUserDetailResponseModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/address_list_screen.dart';
import 'package:euvande/screen/change_password_screen.dart';
import 'package:euvande/screen/login_screen.dart';
import 'package:euvande/screen/pending_product_list_screen.dart';
import 'package:euvande/screen/profile_setting_screen.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  LoginResponseModel? loginResponseModel = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPrefManager.getLoginData().then((value) => {
          setState(() {
            loginResponseModel = value;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(
              height: 15 / 8,
            ),
            _buildSection(),
          ],
        ),
      ),
    ));
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      alignment: Alignment.center,
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(25), // Image radius
              child:
                  Image.asset('assets/images/imgCar1.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 12),
          _buildProfileItem(),
          // _buildProfileItem("9876543210"),
          // Text("user-name"),
          //
          // Text("mobile-number")
        ],
      ),
    );
  }

  Future<void> _navigateUpdateProfileScreen(
      BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileSettingScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    if (result != null) {

      GetUserDetailResponseModel getUserDetailResponseModel =   GetUserDetailResponseModel.fromJson(json.decode(result["data"]));

      SharedPrefManager.getLoginData().then((value) => {
        setState(() {
          loginResponseModel = value;
          loginResponseModel!.data.name = getUserDetailResponseModel.data!.name;
          print(getUserDetailResponseModel.data!.name);

          SharedPrefManager.setLoginData(jsonEncode(loginResponseModel!.toJson()));
        }),
      });
    }
  }

  Widget _buildSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 300,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PendingProductListScreen()),
              );
            },
            child: _buildMenuItem("My Cars", Icons.production_quantity_limits),
          ),
          GestureDetector(
            onTap: () {

            },
            child: _buildMenuItem("Shortlisted Vehicles", Icons.card_giftcard),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.white,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Profile Setting",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _navigateUpdateProfileScreen(context);
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddressListScreen()),
                              );
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Manage Addresses",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: _buildMenuItem("Profile Setting", Icons.settings),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()),
              );
            },
            child: _buildMenuItem("Change Password", Icons.settings),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              loginResponseModel == null ? "Login" : "Logout",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              if (loginResponseModel == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                SharedPrefManager.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: "title")),
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData iconData) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        children: [
          Icon(iconData),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildProfileItem() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loginResponseModel == null ? "N/A" : loginResponseModel!.data.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            loginResponseModel == null ? "N/A" : loginResponseModel!.data.email,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


