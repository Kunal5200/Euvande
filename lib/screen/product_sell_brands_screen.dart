import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';

class ProductSellBrandsScreen extends StatefulWidget {
  const ProductSellBrandsScreen({super.key});

  @override
  State<ProductSellBrandsScreen> createState() =>
      _ProductSellBrandsScreenState();
}

class _ProductSellBrandsScreenState
    extends State<ProductSellBrandsScreen> {
  

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitleSection(),
            SizedBox(height: 10,),
            _buildSearch(),
            _buildBrandsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
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
      keyboardType: TextInputType.name,
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
        Container(
          height: 450,
          child: GridView.count(

            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 4,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(
                    content: Text("Coming Soon"),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                              AssetImage("assets/logos/logo.png")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Brand name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12, ),
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

  Widget _buildInfoRow(IconData? icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 16,
            color: Colors.black45,
          ),
        if (icon != null)
          SizedBox(
            width: 10,
          ),
        Text(
          title,
          style: TextStyle(color: Colors.black45, fontSize: 12),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
