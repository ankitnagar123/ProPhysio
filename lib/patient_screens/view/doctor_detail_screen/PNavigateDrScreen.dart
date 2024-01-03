

import 'dart:async';
import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';
class NavigateMapViewScreen extends StatefulWidget {
  const NavigateMapViewScreen({Key? key}) : super(key: key);

  @override
  State<NavigateMapViewScreen> createState() => _NavigateMapViewScreenState();
}

class _NavigateMapViewScreenState extends State<NavigateMapViewScreen> {


  CustomInfoWindowController customInfoWindowController =
  CustomInfoWindowController();
  CustomView customView = CustomView();
  late GoogleMapController mapController;
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  String lat ="";
  String long="";
  String name="";
  String surname="";
  String img = "";
  String address = "";
  String doctorId = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};



  Future<void> _onMapCreated(GoogleMapController controller) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size.fromHeight(10.0)),
      "assets/images/map.png",
    );
    setState(() {
      const String markerIdVal = 'marker_id';
      const MarkerId markerId = MarkerId(markerIdVal);
      final marker = Marker(
        icon: markerIcon,
        markerId: markerId,
        position: LatLng( double.parse(lat),
          double.parse(long),),
        onTap: () {
          customInfoWindowController.addInfoWindow!(
              GestureDetector(
                onTap: () {

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
                            placeholder: "assets/images/loading.gif",
                            alignment: Alignment.center,
                            image: img,
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
                              "$name $surname",
                              13,
                              FontWeight.w600,
                              MyColor.black),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18),
                              SizedBox(
                                  width: 150,
                                  child: Text(
                                    address,
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
              LatLng(double.parse(lat), double.parse(long)));
        },
      );
      setState(() {
        markers[markerId] = marker;
      });
    });
  }
@override
  void initState() {
    lat = Get.parameters["lat"].toString();

    long = Get.parameters["long"].toString();
    log("$lat$long");
    name = Get.parameters["name"].toString();
    surname = Get.parameters["surname"].toString();
    img = Get.parameters["img"].toString();
    address = Get.parameters["address"].toString();
    doctorId = Get.parameters["doctorId"].toString();
    super.initState();
  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }


  LocalString text = LocalString();
  SharedPreferenceProvider sp = SharedPreferenceProvider();


  @override
  Widget build(BuildContext context) {
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

        initialCameraPosition:  CameraPosition(
          target: LatLng(
            double.parse(lat.toString()),
            double.parse(long.toString()),
          ),
          zoom: 15.0,
        ),
        // onMapCreated: _onMapCreated,
        onMapCreated: (GoogleMapController controllers) async {
          _onMapCreated(controllers);
          customInfoWindowController.googleMapController = controllers;
          mapController = controllers;
          for (var marker in markers.values) {
            mapController.showMarkerInfoWindow(marker.markerId);
          }
        },
        markers:markers.values.toSet(),
      ),
      CustomInfoWindow(
        controller: customInfoWindowController,
        height: 100,
        width: 300,
        offset: 50,
      ),
      // Positioned(
      //   top: 25,
      //   right: 15,
      //   left: 15,
      //   child: SizedBox(
      //     width: MediaQuery
      //         .of(context)
      //         .size
      //         .width,
      //     child: TextFormField(
      //       onChanged: (value) {
      //         setState(() {
      //           // _keyword = value;
      //         });
      //         print(value);
      //       },
      //       cursorWidth: 0.0,
      //       cursorHeight: 0.0,
      //       onTap: () {},
      //       textInputAction: TextInputAction.next,
      //       keyboardType: TextInputType.name,
      //       cursorColor: Colors.black,
      //       // controller: searchCtr,
      //       decoration: InputDecoration(
      //         prefixIcon: const Icon(Icons.search),
      //         prefixIconColor: MyColor.primary1,
      //         suffixIcon: InkWell(
      //             onTap: () {
      //               Get.toNamed(RouteHelper.getFilterScreen());
      //             },
      //             child: const Icon(Icons.filter_list_alt)),
      //         suffixIconColor: MyColor.primary1,
      //         contentPadding: const EdgeInsets.only(top: 3, left: 20),
      //         hintText: "search doctor",
      //         hintStyle: const TextStyle(
      //             fontSize: 12, color: MyColor.primary1),
      //         fillColor: MyColor.lightcolor,
      //         filled: true,
      //         border: const OutlineInputBorder(
      //           borderSide: BorderSide.none,
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(10),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    ]);
  }

}
