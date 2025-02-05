import 'package:carousel_slider/carousel_slider.dart';
import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/request/GetCarListRequestModel.dart';
import 'package:euvande/model/request/LoginRequestModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetCarListResponseModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/screen/product_details_screen.dart';
import 'package:euvande/screen/product_sell_dashboard_screen.dart';
import 'package:euvande/screen/product_sell_journey_screen.dart';
import 'package:euvande/screen/product_sell_vin_screen.dart';
import 'package:euvande/screen/search_product_list_screen.dart';
import 'package:euvande/screen/temp_product_sell_journey_screen.dart';
import 'package:euvande/screen/used_product_list_screen.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/ProductItemList.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:euvande/utilities/TitleDescriptionItemList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ProductItemList> productItemList = [];
  List<TitleDescription> howWorksItemList = [];

  final items = [
    Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        image: DecorationImage(
          image: AssetImage("assets/images/banner1.png"),
          fit: BoxFit.fill,
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        image: DecorationImage(
          image: AssetImage("assets/images/banner2.png"),
          fit: BoxFit.fill,
        ),
      ),
    ),
  ];
  bool isDataLoading = true;
  bool isBrandLoading = true;
  GetAllMakeResponseModel? getAllMakeResponseModel;
  GetCarListResponseModel? getCarListResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productItemList.add(ProductItemList(
        productName: "Mercedes Maybach S",
        productStartPrice: "€ 47899 - € 5000",
        productMaxPrice: "",
        productImageURLs: "assets/images/mercedes/1.jpg"));

    productItemList.add(ProductItemList(
        productName: "BMW i5",
        productStartPrice: "€ 47899 - € 5000",
        productMaxPrice: "",
        productImageURLs: "assets/images/bmw/1.jpg"));

    productItemList.add(ProductItemList(
        productName: "Range Rover",
        productStartPrice: "€ 47899 - € 5000",
        productMaxPrice: "",
        productImageURLs: "assets/images/rangerover/1.jpg"));

    howWorksItemList.add(TitleDescription(
        title: "European Dreams, Driven Reality.",
        description:
            "Turn your European dreams into reality with the perfect car. Explore iconic destinations, scenic routes, and cityscapes on your terms. Your dream ride awaits.",
        imageURLs: 'assets/icons/european_dreams_driven_reality.svg'));
    howWorksItemList.add(TitleDescription(
        title: "Expert Eyes, Thorough Inspection.",
        description:
            "Our expert eyes ensure a meticulous inspection, guaranteeing your peace of mind.",
        imageURLs: 'assets/icons/expert_eyes_thorough_inspection.svg'));
    howWorksItemList.add(TitleDescription(
        title: "Delivered to Your Doorstep.",
        description:
            "Experience seamless convenience with our direct-to-your-door delivery service – your dream car, delivered effortlessly to your home.",
        imageURLs: 'assets/icons/delivered_to_your_doorstep.svg'));

    callGetCarListApi();
    callGetAllMakeApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
            // horizontal: 40.0,
            // vertical: 120.0,
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSearch(),
            _buildCarouselSlider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Row(
                children: [
                  Expanded(child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            // const TempProductSellDashboardScreen()
                            const UsedProductListScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/icons/car1.png"),
                          height: 40,
                          width: 40,
                        ),
                        Text("Buy Premium Car", style: TextStyle(color: Colors
                            .white,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )),
                  Container(color: Colors.white,height: 50,width: 1,),
                  Expanded(child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            // const TempProductSellDashboardScreen()
                            const ProductSellVinScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/icons/car1.png", ),
                          height: 40,
                          width: 40,
                        ),
                        Text("Sell Premium Car", style: TextStyle(color: Colors
                            .white,
                            fontWeight: FontWeight.bold),),
                      ],
                    )),
                  ),

                ],
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(color: Colors.black, width: 1),
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child: Stack(
            //     children: [
            //       Align(
            //         alignment: Alignment.centerRight,
            //         child: Container(
            //           width: 150.0,
            //           height: 110.0,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             image: DecorationImage(
            //                 fit: BoxFit.cover,
            //                 image: AssetImage("assets/images/vintage.jpg")),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text("Want to sell your Car ?", style: TextStyle
            //               (fontSize: 18, fontWeight: FontWeight.bold),)
            //             , Text("Sell your car at best price.", style: TextStyle
            //               (fontSize:
            //             14, fontWeight: FontWeight.normal, color: Colors.black54,
            //                 fontStyle: FontStyle.italic),),
            //             SizedBox(height: 10,),
            //             SizedBox(
            //               width: 200,
            //               child: ElevatedButton(
            //                 style: raisedButtonStyle,
            //                 child: Text(
            //                   'Sell Car'.toUpperCase(),
            //                   style: TextStyle(color: Colors.white, fontSize: 14),
            //                 ),
            //                 onPressed: () {
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) =>
            //                         // const TempProductSellDashboardScreen()
            //                         const ProductSellVinScreen()),
            //                   );
            //                 },
            //
            //               ),
            //             )
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   _buildSellPurchase(
            //       () => {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       const UsedProductListScreen()),
            //             )
            //           },
            //       AssetImage("assets/icons/car.png"),
            //       "Buy Used Car",
            //       "pre-owned car for sale →",
            //       Colors.green[100]),
            //   SizedBox(
            //     width: 10,
            //   ),
            //   _buildSellPurchase(
            //       () => {
            //     Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       // const TempProductSellDashboardScreen()
            //                       const ProductSellVinScreen()),
            //             )
            //           },
            //       AssetImage("assets/icons/car.png"),
            //       "Sell Car",
            //       "from your home →",
            //       Colors.blue[100])
            // ]),
            SizedBox(
              height: 10,
            ),
            _buildHowWorksList(),
            isDataLoading ? _showLoader() : _buildPopularProductList(),
            isDataLoading ? _showLoader() : _buildUsedProductList(),
            isBrandLoading ? _showLoader() : _buildBrandsSection(),
          ],
        ),
      ),
    ));
  }

  Widget _buildSearch() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchProductListScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            // border: Border.all(
            //   // color: Colors.black12,
            // ),
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.black54,
            ),
            SizedBox(width: 10.0),
            Text(
              "Search Cars",
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
      ),
      itemCount: this.items.length,
      itemBuilder: (context, itemIndex, realIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: items[itemIndex],
        );
      },
    );
  }

  Widget _buildSellPurchase(var onTap, AssetImage logo, String title,
      String subTitle, Color? bgColor) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: bgColor,
              ),
              width: MediaQuery.of(context).size.width / 2 - 25,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(subTitle,
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 10)),
                  Image(
                    image: logo,
                    height: 80,
                    width: 80,
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildPopularProductList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "Popular new cars",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: getCarListResponseModel!.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildProductItem(
                        getCarListResponseModel!.data!.docs[index]);
                  })),
        ],
      ),
    );
  }

  Widget _buildUsedProductList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "Trusted used cars",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: getCarListResponseModel!.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildProductItem(
                        getCarListResponseModel!.data!.docs[index]);
                  })),
        ],
      ),
    );
  }

  Widget _buildProductItem(Doc doc) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen(doc)),
        )
      },
      child: Container(
        width: 180,
        // padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: doc.carImages.isNotEmpty
                        ? NetworkImage(doc.carImages[0]) as ImageProvider
                        : AssetImage("assets/images/mercedes/1.jpg")),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              " ${doc.make!.makeName} ${doc.model!.modelName}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            Text(
              " € ${doc.price}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              " Click to check",
              style: TextStyle(
                color: Colors.blueAccent[200],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowWorksItem(TitleDescription itemList) {
    return Container(
      // padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            itemList.imageURLs,
            width: 50.0,
            height: 50.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            itemList.title,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            itemList.description,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHowWorksList() {
    return Container(
      color: Color(0xFFF5F7FB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "How does it work",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  _buildHowWorksItem(howWorksItemList[1]),
                  _buildHowWorksItem(howWorksItemList[0]),
                  _buildHowWorksItem(howWorksItemList[2]),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildBrandsSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Text(
              "Popular brands",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(
                  getAllMakeResponseModel!.data.length > 11
                      ? 12
                      : getAllMakeResponseModel!.data.length, (index) {
                return index < 11
                    ? Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: InkWell(
                          onTap: () {
                            ProductSellDashboardScreen
                                .getPendingCarsResponseModel = null;
                            ProductSellJourneyScreen.addCarRequestModel =
                                AddCarRequestModel();
                            ProductSellJourneyScreen
                                    .addSpecificationRequestModel =
                                AddSpecificationRequestModel();
                            ProductSellJourneyScreen.addCarRequestModel.makeId =
                                getAllMakeResponseModel!.data[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TempProductSellJourneyScreen()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          getAllMakeResponseModel!
                                              .data[index].logo)),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                getAllMakeResponseModel!.data[index].makeName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          ProductSellDashboardScreen
                              .getPendingCarsResponseModel = null;
                          ProductSellJourneyScreen.addCarRequestModel =
                              AddCarRequestModel();
                          ProductSellJourneyScreen
                                  .addSpecificationRequestModel =
                              AddSpecificationRequestModel();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TempProductSellJourneyScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View All\nBrands",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ));
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showLoader() {
    return Center(
      heightFactor: 12,
      child: CircularProgressIndicator(),
    );
  }

  void callGetCarListApi() {
    setState(() {
      isDataLoading = true;
    });

    GetCarListRequestModel getCarListRequestModel = GetCarListRequestModel();

    Future<GetCarListResponseModel> response =
        ApiService(context).getCarList(getCarListRequestModel);
    response
        .then((value) => {
              setState(() {
                isDataLoading = false;
              }),
              getCarListResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isDataLoading = false;
      });
    });
  }

  void callGetAllMakeApi() {
    setState(() {
      isBrandLoading = true;
    });

    Future<GetAllMakeResponseModel> response =
        ApiService(context).getAllMakePublic();
    response
        .then((value) => {
              setState(() {
                isBrandLoading = false;
              }),
              getAllMakeResponseModel = value,
            })
        .catchError((onError) {
      setState(() {
        isBrandLoading = false;
      });
    });
  }

}
