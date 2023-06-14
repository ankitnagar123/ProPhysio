/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

import '../doctor_screens/controller/DoctorSignUpController.dart';
import '../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  var selectedIndexes = [];
  var subCatIdArray = [];

  @override
  void initState() {
    doctorSignUpCtr.DoctorCategory();
    super.initState();
  }

  String? slectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SearchChoices.single(
              isCaseSensitiveSearch: false,
              items: doctorSignUpCtr.category.map((items) {
                return DropdownMenuItem(
                  value: items.categoryId,
                  child: Text(items.categoryName),
                );
              }).toList(),
              value: slectedCategory,
              hint: "Select one",
              searchHint: "Select one",
              onChanged: (value) {
                setState(() {
                  slectedCategory = value;
                  print("category.$slectedCategory");
                  doctorListCtr.subCatList(slectedCategory!);
                });
              },
              isExpanded: true,
            ),
            const SizedBox(
              height: 30,
            ),
            SearchChoices.multiple(
              doneButton: (selectedItemsDone, doneContext) {
                return (TextButton(
                    onPressed: () {
                      Navigator.pop(doneContext);
                      setState(() {
                        subCatIdArray = doneContext;
                      });
                    },
                    child: Text("Save")));
              },
              onSaved: (newValue) {
                // subCatIdArray = newValue;
                print(newValue);
                print(subCatIdArray);
                if (selectedIndexes.contains(newValue)) {
                  selectedIndexes.remove(newValue);
                  // subCatIdArray.remove(doctorListCtr.subCategory[newValue].subcatId);
                } else {
                  selectedIndexes.add(newValue);
                  // subCatIdArray.add(doctorListCtr.subCategory[newValue].subcatId);
                  log(".............$subCatIdArray");
                }
              },
              isCaseSensitiveSearch: false,
              items: doctorListCtr.subCategory.map((items) {
                return DropdownMenuItem(
                  value: items.subcatId,
                  child: Text(items.subcatName),
                );
              }).toList(),
              label: subCatIdArray,
              hint: "Select one",
              searchHint: "Select one",
              onChanged: (value) {
                setState(() {
                  subCatIdArray = value;
                  print(value);
                  print(subCatIdArray);
                  if (selectedIndexes.contains(value)) {
                    selectedIndexes.remove(value);
                    subCatIdArray
                        .remove(doctorListCtr.subCategory[value].subcatId);
                  } else {
                    selectedIndexes.add(value);
                    subCatIdArray
                        .add(doctorListCtr.subCategory[value].subcatId);
                    log(".............$subCatIdArray");
                  }
                });
              },
              isExpanded: true,
            )
          ],
        ),
      ),
    );
  }
}
*/
import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late  final Completer<GoogleMapController> controllers = Completer();
  final List<Marker> _markers = [];
  final LatLng _center = const LatLng(37.7749, -122.4194);
  final List<LatLng> _locations = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.7882, -122.4075),
    const LatLng(37.7559, -122.4148),
  ];

  Future<Map<String, dynamic>> _getMarkerData(
      double latitude, double longitude) async {
    const String apiUrl =
        'https://cisswork.com/Android/Medica/Apis/process.php?action=doctor_list';
    final response = await http.post(Uri.parse(apiUrl),body: {
      "cat_id":"101",
      "subcat_id":"29"
    });
    final data = json.decode(response.body.toString());
    final results = data['result'];
    if (results.isNotEmpty) {
      final address = results['location'];
      return {'location': address, 'description': 'latitude: $latitude, longitude: $longitude'};
    }
    return {'title': 'Unknown location', 'description': ''};
  }

  Future<void> _createMarkers() async {
    for (int i = 0; i < _locations.length; i++) {
      final LatLng location = _locations[i];
      final data = await _getMarkerData(location.latitude, location.longitude);
      final Marker marker = Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        onTap: () async {
          final data =
          await _getMarkerData(location.latitude, location.longitude);
          setState(() {
            _markers[i] = _markers[i].copyWith(
              infoWindowParam: InfoWindow(title: data['title'],
                snippet: data['description'],),
            );
          });
        },
      );
      _markers.add(marker);
    }
  }
  // given camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(22.7196, 75.8577),
    zoom: 17,
  );
   late GoogleMapController _mapController;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps Demo'),
          backgroundColor: Colors.green[700],
        ),
        body:   GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            _createMarkers();
          },
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
          markers: Set<Marker>.of(_markers),
        ),
      ),
    );
  }
}
