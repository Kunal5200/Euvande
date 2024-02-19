import 'package:euvande/model/request/AddAddressRequestModel.dart';
import 'package:euvande/model/request/EditAddressRequestModel.dart';
import 'package:euvande/model/response/AddAddressResponseModel.dart';
import 'package:euvande/model/response/EditAddressResponseModel.dart';
import 'package:euvande/model/response/GetAddressResponseModel.dart';
import 'package:euvande/utilities/ApiService.dart';
import 'package:euvande/utilities/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerScreen extends StatefulWidget {
  final List<String> galleryItems;

  const ImageViewerScreen(
    this.galleryItems, {
    super.key,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.black,
          child: Container(
              child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.galleryItems[index]),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(tag: index),
              );
            },
            itemCount: widget.galleryItems.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                          event.expectedTotalBytes!.toInt(),
                ),
              ),
            ),
          )),
        ));
  }
}
