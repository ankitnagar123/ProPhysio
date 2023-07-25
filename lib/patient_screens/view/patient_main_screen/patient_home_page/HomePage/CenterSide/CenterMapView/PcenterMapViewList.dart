import 'dart:async';
import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../controller/patinet_center_controller/PCenterController.dart';
import '../PCenterDetailsPage.dart';



class CenterMapViewScreen extends StatefulWidget {

  CenterMapViewScreen({Key? key,})
      : super(key: key);

  @override
  State<CenterMapViewScreen> createState() => _CenterMapViewScreenState();
}

class _CenterMapViewScreenState extends State<CenterMapViewScreen> {

  CustomInfoWindowController customInfoWindowController =
  CustomInfoWindowController();
  CustomView customView = CustomView();
  late GoogleMapController controller;
  PCenterCtr pCenterCtr = PCenterCtr();


  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List latlang = [];

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size.fromHeight(10.0)),
      "assets/images/img.png",
    );
    setState(() {
      for (int i = 0; i < pCenterCtr.centerList.length; i++) {
        latlang.add(
          LatLng(double.parse(pCenterCtr.centerList[i].latitude.toString()),
              double.parse(pCenterCtr.centerList[i].longitude.toString())),
        );
        log("my lat longs in new lat-long list=> $latlang");
      }
      for (int i = 0; i < latlang.length; i++) {
        final String markerIdVal = 'marker_id_$i';
        final MarkerId markerId = MarkerId(markerIdVal);
        final marker = Marker(
          icon: markerIcon,
          markerId: markerId,
          position: latlang[i],
          onTap: () {
            customInfoWindowController.addInfoWindow!(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PCenterDetailScreen(
                              id: pCenterCtr.centerList[i].centerId,
                            )));
                  },
                  child: Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 6.0),
                    color: MyColor.white,
                    elevation: 2.2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          // margin: const EdgeInsets.all(6),
                          child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/YlWC.gif",
                              alignment: Alignment.center,
                              image: pCenterCtr.centerList[i].image
                                  .toString(),
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/noimage.png',
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customView.text(
                                pCenterCtr.centerList[i].name.toString(),
                                13,
                                FontWeight.w600,
                                MyColor.black),
                            const SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                                width: 150,
                                child: Text(
                                  pCenterCtr.centerList[i].biography
                                      .toString(),
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 18),
                                SizedBox(
                                    width: 150,
                                    child: Text(
                                      pCenterCtr.centerList[i].address
                                          .toString(),
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
                latlang[i]);
          },
        );
        setState(() {
          markers[markerId] = marker;
        });
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pCenterCtr.centerListApi();
    });

    super.initState();
  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Doctor MAP");
    return Obx(() {
      return Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          scrollGesturesEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          padding: const EdgeInsets.all(0),
          buildingsEnabled: true,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
          rotateGesturesEnabled: true,
          tiltGesturesEnabled: true,
          trafficEnabled: false,
          onTap: (position) {
            customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            customInfoWindowController.onCameraMove!();
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(
              double.parse(pCenterCtr.centerList[0].latitude.toString()),
              double.parse(pCenterCtr.centerList[0].longitude.toString()),
            ),
            zoom: 15.0,
          ),
                                                            onMapCreated: (GoogleMapController controllers) async {
            _onMapCreated(controllers);
            customInfoWindowController.googleMapController = controllers;
            controller = controllers;
            for (var marker in markers.values) {
              controller.showMarkerInfoWindow(marker.markerId);
            }

          },
          markers: markers.values.toSet(),
        ),
        CustomInfoWindow(
          controller: customInfoWindowController,
          height: 100,
          width: 300,
          offset: 50,
        ),

      ]);
    });
  }
}
