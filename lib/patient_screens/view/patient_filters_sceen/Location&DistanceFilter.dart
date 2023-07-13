import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:medica/patient_screens/view/patient_filters_sceen/set_location/PatinetSetLoaction.dart';

import 'package:geolocator/geolocator.dart';
import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/AppConst.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/filter_controller/PatientFilterController.dart';

class LocationDistanceFilter extends StatefulWidget {
  const LocationDistanceFilter({Key? key}) : super(key: key);

  @override
  State<LocationDistanceFilter> createState() => _LocationDistanceFilterState();
}

class _LocationDistanceFilterState extends State<LocationDistanceFilter> {
  TextEditingController destinationController = TextEditingController();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  LocalString text = LocalString();

  String location = '';
  final kGoogleApiKey = "AIzaSyAA838tqJK4u1_Rzef1Qv2FtqFwm3T9bEA";
  CustomView custom = CustomView();
  int selectedCard = -1;
  int km = 100;
  PatientFilterCtr patientFilterCtr = Get.put(PatientFilterCtr());

  /*---current location--*/
  String? _currentAddress;
  Position? _currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(
              text.locationServicesDisabledPleaseEnableServices.tr)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(text.locationPermissionsDenied.tr)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(
              text.locationPermissionsPermanentlyRequestPermissions.tr)));
      return false;
    }
    return true;
  }


  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }


  Future<void> _getAddressFromLatLng(Position position) async {
    await geoCoding.placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<geoCoding.Placemark> placemarks) {
      geoCoding.Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        AppConst.FILTER_LATITUDE = _currentPosition!.latitude.toString();
        AppConst.FILTER_LOCATION = _currentPosition!.longitude.toString();
        AppConst.FILTER_LOCATION = _currentAddress!;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _getCurrentPosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text(
            text.Location_and_distance.tr, 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.offNamed(RouteHelper.getFilterScreen());
          },
          icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: custom.MyButton(context, text.Submit.tr, () {
          Get.offNamed(RouteHelper.getFilterScreen());
        }, MyColor.primary,
            const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Divider(),
              SizedBox(
                height: height * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    text.Search_city.tr, 17, FontWeight.w500, MyColor.black),
              ),
              const SizedBox(
                height: 6.0,
              ),
              custom.searchField(
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
                  log(">>>>>>>>>>>>>>>>>>", error: location);
                  try {
                    AppConst.FILTER_LATITUDE = newlatlang.latitude.toString();
                    AppConst.FILTER_LONGITUDE = newlatlang.longitude.toString();
                    AppConst.FILTER_LOCATION = location.toString();
                  } catch (e) {
                    print("Exception :-- ${e.toString()}");
                  }
                  print("My latitude AppCont : -- ${AppConst.FILTER_LATITUDE}");
                  print(
                      "My LONGITUDE AppCont : -- ${AppConst.FILTER_LONGITUDE}");
                  print("My location AppCont : -- ${AppConst.FILTER_LOCATION}");
                }
              }, () {}),
              SizedBox(
                height: height * 0.03,
              ),
              /*   Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    "Most searched", 14, FontWeight.normal, MyColor.grey),
              ),
              GridView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      // childAspectRatio: 3/ 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      mainAxisExtent: 54),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCard = index;
                          print(selectedCard);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          */
              /*Demo only*/
              /*
                          Container(
                            // margin: EdgeInsets.all(10),
                            height: 40.0,
                            width: widht * 0.38,
                            decoration: BoxDecoration(
                              color: selectedCard == index
                                  ? MyColor.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x5b000000),
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  // spreadRadius: 1
                                ),
                              ],
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  size: 18,
                                  Icons.pin_drop_outlined,
                                  color: selectedCard == index
                                      ? MyColor.white
                                      : Colors.black,
                                ),
                                Text(
                                  'Turin, Italy',
                                  style: TextStyle(
                                    fontWeight: selectedCard == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: selectedCard == index
                                        ? MyColor.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    );
                  }),*/
              const Divider(),
              SizedBox(
                height: height * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  custom.text(
                      text.Select_distance.tr, 16, FontWeight.w500, MyColor.black),
                  custom.text("$km+${text.km.tr}", 14, FontWeight.w500, MyColor.lightblue),
                ],
              ),
              Slider(
                activeColor: MyColor.lightblue,
                thumbColor: MyColor.midgray,
                label: text.select_Km.tr,
                value: km.toDouble(),
                onChanged: (value) {
                  setState(() {
                    km = value.toInt();
                    AppConst.FILTER_DISTANCE = km.toString();
                  });
                },

                min: 5,
                max: 100,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(text.From.tr, 16, FontWeight.w300, MyColor.black),
              ),
              radioList()
            ],
          ),
        ),
      ),
    );
  }

  String? _groupValue;

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  Widget radioList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RadioListTile(
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            value: text.From_current_location.tr,
            groupValue: _groupValue,
            activeColor:
                MaterialStateColor.resolveWith((states) => MyColor.lightblue),
            onChanged: (val) async{
              setState(() {
                _getCurrentPosition();
                log('LAT: ${_currentPosition?.latitude ?? ""}');
                log('LNG: ${_currentPosition?.longitude ?? ""}');
                log('ADDRESS: ${_currentAddress ?? ""}');
                _groupValue = val.toString();

                log(val.toString());
                log(_groupValue!);
               /* AppConst.FILTER_LATITUDE = _currentPosition!.latitude.toString();
                AppConst.FILTER_LOCATION = _currentPosition!.longitude.toString();
                AppConst.FILTER_LOCATION = _currentAddress!;


                log("current lat${AppConst.FILTER_LATITUDE}");
                log("current long${AppConst.FILTER_LONGITUDE}");
                log("current location${AppConst.FILTER_LOCATION}");*/

              });
            },
            title: custom.text(
                text.From_current_location.tr, 12, FontWeight.w500, MyColor.black)),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientSetLocation()));
          },
          child: RadioListTile(
              subtitle: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatientSetLocation()));
                  },
                  child: custom.text(
                      patientFilterCtr.address.value == null
                          ? " ${sp.getStringValue(sp.FILTER_LAT)}"
                          : "${sp.getStringValue(sp.FILTER_LOCATION)} ",
                      12,
                      FontWeight.w500,
                      MyColor.grey)),
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              value: patientFilterCtr.address.value,
              activeColor:
                  MaterialStateColor.resolveWith((states) => MyColor.lightblue),
              groupValue: _groupValue,
              onChanged: (val) {
                setState(() async{
                  AppConst.FILTER_LATITUDE = (await sp.getStringValue(sp.FILTER_LAT))!;
                  AppConst.FILTER_LONGITUDE = (await sp.getStringValue(sp.FILTER_LONG))!;
                  AppConst.FILTER_LOCATION =(await sp.getStringValue(sp.FILTER_LOCATION))!;
                  _groupValue = val.toString();
                  print(patientFilterCtr.caps.value);
                  print(_groupValue);
                });
              },
              title:
                  custom.text(text.from_Home.tr, 12, FontWeight.w500, MyColor.black)),
        ),
        RadioListTile(
            subtitle: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PatientSetLocation()));
                },
                child: custom.text(
                    text.setLocation.tr, 12, FontWeight.w500, MyColor.grey)),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            value: text.fromOffice.tr,
            activeColor:
                MaterialStateColor.resolveWith((states) => MyColor.lightblue),
            groupValue: _groupValue,
            onChanged: (val) {
              setState(() {

                _groupValue = val.toString();
                print(_groupValue);
              });
            },
            title:
                custom.text(text.fromOffice.tr, 12, FontWeight.w500, MyColor.black)),
        const SizedBox(
          height: 80,
        )
      ],
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
      hint: text.Search_city.tr
    );
    return p;
  }

  // late Positioned currentPostion;
  Future<latLng.LatLng> buildLatLngFromAddress(dynamic place) async {
    List<geoCoding.Location> locations =
        await geoCoding.locationFromAddress(place);
    return latLng.LatLng(locations.first.latitude, locations.first.longitude);
  }
}
