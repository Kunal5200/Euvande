import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/login_screen.dart';
import 'package:euvande/screen/registration_screen.dart';
import 'package:euvande/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfileSettingScreen extends StatefulWidget {
  final Key? key;

  const ProfileSettingScreen({this.key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: 25),
              _buildFormSection(),

            ],
          ),
        ),
      ),
    );
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
              size: Size.fromRadius(25),
              child:
                  Image.asset('assets/images/imgCar1.png', fit: BoxFit.cover),
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter your user name',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.person, size: 24),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter your mobile number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.phone, size: 24),
            ),
            keyboardType: TextInputType.phone, // Use TextInputType.phone
          ),
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter your email',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              prefixIcon: Icon(Icons.email, size: 24),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: raisedButtonStyleForm,
            child: Text(
              'Link your Email',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              // Handle button press
            },
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                padding: EdgeInsets.only(right: 10),
                child: OutlinedButton(
                  style: raisedButtonStyleFormOutline,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: raisedButtonStyleForm,
                  child: Text(
                    'Save Change',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
