import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/profile_setting_screen.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
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
          _buildMenuItem("My Orders", Icons.card_giftcard),
          _buildMenuItem("Shortlisted Vehicles", Icons.card_giftcard),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileSettingScreen()),
              );
            },
            child: _buildMenuItem("Profile Setting", Icons.settings),
          ),

          SizedBox(height: 30),
          ElevatedButton(
            style: raisedButtonStyle,
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //   content: Text("Sending Message"),
              // ));
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
            "Anshuman",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            "9876543210",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
