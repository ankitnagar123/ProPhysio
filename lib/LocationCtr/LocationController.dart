
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
class PermissionController extends GetxController{


  var latitude = "".obs;
  var longitude = "".obs;
  var locations = "".obs;


  Future<void> permissionHandle()async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.photos,
      Permission.notification
      //add more permission to request here.
    ].request();

    if(statuses[Permission.location]!.isDenied){ //check each permission status after.
      print("Location permission is denied.");
    }
    if(statuses[Permission.photos]!.isDenied){ //check each permission status after.
      print("Photos permission is denied.");
    }
    if(statuses[Permission.notification]!.isDenied){ //check each permission status after.
      print("Notification permission is denied.");
    }

    if(statuses[Permission.camera]!.isDenied){ //check each permission status after.
      print("Camera permission is denied.");
    }
  }


  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('', "Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        Get.snackbar('', "Location permissions are denied");
        Geolocator.openAppSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('', "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }
}