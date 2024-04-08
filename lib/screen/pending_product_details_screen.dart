import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/screen/image_viewer_screen.dart';
import 'package:flutter/material.dart';

class PendingProductDetailsScreen extends StatefulWidget {
  final GetPendingCarsData getPendingCarsData;

  const PendingProductDetailsScreen(this.getPendingCarsData, {super.key});

  @override
  State<PendingProductDetailsScreen> createState() =>
      _PendingProductDetailsScreenState();
}

class _PendingProductDetailsScreenState
    extends State<PendingProductDetailsScreen> {
  final items = [
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/rear-left-view-121.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/front-view-118.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/rear-view-119.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/grille-97.jpg",
    "https://stimg.cardekho.com/images/carexteriorimages/930x620/BMW/M5/8490/1625142409938/front-fog-lamp-41.jpg",
  ];

  bool isPendingCarLoading = true;
  GetAllMakeResponseModel? getAllMakeResponseModel;
  final TextEditingController cityController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Review Details"),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                // horizontal: 40.0,
                // vertical: 120.0,
                ),
            child: Column(
              children: [
                _buildProductOverviewSection(),
                _buildProductGallerySection(),
              ],
            ),
          ),
        ));
  }

  Widget _buildProductOverviewSection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.getPendingCarsData.period!.year}  ${widget.getPendingCarsData.make!.makeName} ${widget.getPendingCarsData.model!.modelName}",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "${widget.getPendingCarsData.odometer} kms • ${widget.getPendingCarsData.variant!.fuelType} • ${widget.getPendingCarsData.specification!.transmission} • ${widget.getPendingCarsData.ownership} Owner",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 10,
          ),
          _buildInfoRow(
              null, "Fuel Type", widget.getPendingCarsData.variant!.fuelType),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Vehicle Type",
              widget.getPendingCarsData.specification!.vehicleType.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Doors",
              widget.getPendingCarsData.specification!.doors.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Drive Type 4X4",
              widget.getPendingCarsData.specification!.driveType4Wd.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "Seats",
              widget.getPendingCarsData.specification!.seats.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(
              null,
              "Interior Material",
              widget.getPendingCarsData.specification!.interiorMaterial
                  .toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(null, "POSSIBILITY OF VAT DEDUCTION",
              widget.getPendingCarsData.specification!.vatDeduction.toString()),
          SizedBox(
            height: 5,
          ),
          _buildInfoRow(
              null, "KMS Driven", "${widget.getPendingCarsData.odometer} kms"),
        ],
      ),
    );
  }

  Widget _buildProductGallerySection() {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Images",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(widget.getPendingCarsData.carImages.length,
                (index) {
              return GestureDetector( behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageViewerScreen(widget.getPendingCarsData.carImages, index)),
                  );
                },
                child: Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              widget.getPendingCarsData.carImages[index])),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityController.dispose();
  }
}
