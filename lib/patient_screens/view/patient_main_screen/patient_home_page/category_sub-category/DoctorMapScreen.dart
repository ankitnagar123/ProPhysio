import 'dart:async';
import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../doctor_detail_screen/DoctorDetailScreen.dart';

class MapViewScreen extends StatefulWidget {
  String catId, subCatID;

  MapViewScreen({Key? key, required this.catId, required this.subCatID})
      : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  CustomView customView = CustomView();
  late GoogleMapController controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List latlang = [];
  Future<void> _onMapCreated(GoogleMapController controller) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size.fromHeight(10.0)),
      "assets/images/map.png",
    );
    setState(() {
      for (int i = 0; i < doctorListCtr.doctorList.length; i++) {
        log("lat-long${double.parse(doctorListCtr.doctorList[i].branchLat.toString())},${double.parse(doctorListCtr.doctorList[i].branchLong.toString())}");
        latlang.clear();
        latlang.add(
          LatLng(double.parse(doctorListCtr.doctorList[i].branchLat.toString()),
              double.parse(doctorListCtr.doctorList[i].branchLong.toString())),
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
              buildInfoWindowContent(i),
              latlang[i],
            );
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorListCtr.doctorlistfetch(
          context, widget.catId,"", "", "", "", "");
      log("MAP page");
    });

  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Doctor MAP");
    return Obx(() {
      if (doctorListCtr.loadingFetch.value) {
        return Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8),
          child: Column(
            children: [
              customView.MyIndicator(),
            ],
          ),
        );
      }else{
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
              target: doctorListCtr.doctorList.isEmpty?LatLng(
                double.parse("21.7679"),
                double.parse("78.8718"),
              ):LatLng(
                double.parse(doctorListCtr.doctorList[0].branchLat.toString()),
                double.parse(doctorListCtr.doctorList[0].branchLong.toString()),
              ),
              zoom: 20.0,
            ),
            // onMapCreated: _onMapCreated,
            onMapCreated: (GoogleMapController controllers) async {
              setState(() {
                _onMapCreated(controllers);
              });
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
      }

    });
  }

  Widget buildInfoWindowContent(int i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetailScreen(
                  id: doctorListCtr.doctorList[i].doctorId
                      .toString(),
                  branchId: doctorListCtr
                      .doctorList[i].branchId,
                  drImg: doctorListCtr
                      .doctorList[i].doctorProfile
                      .toString(), cat: widget.catId,
                )));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: 7, vertical: 6.0),
        color: MyColor.white,
        elevation: 2.2,
        child: Row(
          children: [
            SizedBox(
              width: 70,
              height: 70,
              // margin: const EdgeInsets.all(6),
              child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",
                  alignment: Alignment.center,
                  image: doctorListCtr.doctorList[i].doctorProfile
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
                const SizedBox(
                  height: 12,
                ),
                customView.text(
                    "${doctorListCtr.doctorList[i].name.toString()} ${doctorListCtr.doctorList[i].surname.toString()}",
                    13,
                    FontWeight.w500,
                    MyColor.black),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 18,color: MyColor.primary1,),
                    SizedBox(
                        width: 150,
                        child: Text(
                          doctorListCtr.doctorList[i].branchAddress
                              .toString(),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                    child: customView.text(
                        doctorListCtr.doctorList[i].category
                            .toString(),
                        12,
                        FontWeight.w500,
                        MyColor.black)),
              ],
            )
          ],
        ),
      ),
    );
  }


}
/* Positioned(
          top: 25,
          right: 15,
          left: 15,
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  // _keyword = value;
                });
                print(value);
              },
              cursorWidth: 0.0,
              cursorHeight: 0.0,
              onTap: () {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              cursorColor: Colors.black,
              // controller: searchCtr,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: MyColor.primary1,
                suffixIcon: InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getFilterScreen());
                    },
                    child: const Icon(Icons.filter_list_alt)),
                suffixIconColor: MyColor.primary1,
                contentPadding: const EdgeInsets.only(top: 3, left: 20),
                hintText: "search doctor",
                hintStyle: const TextStyle(
                    fontSize: 12, color: MyColor.primary1),
                fillColor: MyColor.lightcolor,
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),*/
