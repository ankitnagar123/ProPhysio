import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:latlong2/latlong.dart' as latLng;

import '../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../helper/AppConst.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';

class DoctorSelectAddress extends StatefulWidget {
  const DoctorSelectAddress({
    super.key,
  });

  @override
  State<DoctorSelectAddress> createState() => _DoctorSelectAddressState();
}

class _DoctorSelectAddressState extends State<DoctorSelectAddress> {
  // final kGoogleApiKey = "AIzaSyAy5sPNT7IwQZie2Zq-yUWqRUOktE5arxE";
  // final kGoogleApiKey = "AIzaSyB9lmosWwo-xA_IuZi0h01fllv0ydzks_4";
   final kGoogleApiKey = "AIzaSyAA838tqJK4u1_Rzef1Qv2FtqFwm3T9bEA";

  // late latLng.LatLng destination;
  // late latLng.LatLng source;
  // double? lat;
  // double? lag;
  String location = '';
  CustomView customView = CustomView();
  TextEditingController destinationController = TextEditingController();
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  void clear() {
    destinationController.clear();
  }

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.location.value;
    print(doctorSignUpCtr.location.value);
    // print(lat);
    // print(lag);
    print("my loc${destinationController.text.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: customView.text("Search medical centers or offices", 15,
            FontWeight.w500, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      location.trim();
                    },
                    child: customView.text(
                        "Cancel", 13, FontWeight.w500, MyColor.lightblue))),
            customView.searchField(
                context,
                destinationController,
                location,
                TextInputType.text,
                const Text(""),
                const Icon(Icons.search_rounded), () async {
              var place = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: kGoogleApiKey,
                  mode: Mode.overlay,
                  types: [],
                  strictbounds: false,
                  components: [],
                  onError: (err) {
                    print(err);
                  });
              if (place != null) {
                setState(() {
                  location = place.description.toString();
                });

                final plist = GoogleMapsPlaces(
                  apiKey: kGoogleApiKey,
                  // apiHeaders: await const GoogleApiHeaders().getHeaders(),
                );
                String placeId = place.placeId ?? "0";
                final detail = await plist.getDetailsByPlaceId(placeId);
                final geometry = detail.result.geometry!;
                final lat = geometry.location.lat;
                final lang = geometry.location.lng;
                var newlatlang = latLng.LatLng(lat, lang);
                log(newlatlang.latitude.toString());
                log(newlatlang.longitude.toString());
                log(">>>>>>>>>>>>>>>>>>",error: location);
                try{
                  AppConst.LATITUDE = newlatlang.latitude.toString();
                  AppConst.LONGITUDE = newlatlang.longitude.toString();
                  AppConst.LOCATION = location.toString();
                }catch(e){
                  print("Exception :-- ${e.toString()}");
                }
                print("My latitude AppCont : -- ${AppConst.LATITUDE}");
                print("My LONGITUDE AppCont : -- ${AppConst.LONGITUDE}");
                print("My latitude AppCont : -- ${AppConst.LOCATION}");

              }
            }, () {}),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),

                SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: customView.text(AppConst.LOCATION, 12,
                      FontWeight.normal, MyColor.black),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: customView.MyButton(context, "Select", () {
                Get.back();
              }, MyColor.primary,
                  const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

/*-----------Google Search------------------*/
  Future<Prediction?> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      components: [],
      types: [],
      hint: "Search City",
    );
    return p;
  }

  Future<latLng.LatLng> buildLatLngFromAddress(dynamic place) async {
    List<geoCoding.Location> locations =
        await geoCoding.locationFromAddress(place);
    return latLng.LatLng(locations.first.latitude, locations.first.longitude);
  }
}
