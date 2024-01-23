import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Network/ApiService.dart';
import '../../../Network/Apis.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';

class PatientProfileCtr extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  var loading = false.obs;
  var loadingU = false.obs;


  var resultVar = RxnInt(0);

  var username = "".obs;
  var name = "".obs;
  var title = "".obs;
  var surename = "".obs;
  var healthCard = "".obs;
  var Email = "".obs;
  var phone = "".obs;
  var code = "".obs;
  var Password = "".obs;
  var address = "".obs;
  var image = "".obs;
  var gender = "".obs;

  /*--new filed added--*/

  var age = "".obs;
  var height = "".obs;
  var weight = "".obs;
  var taxCode = "".obs;
  var birthplace = "".obs;
  var qrCode = "".obs;
  var flag = "".obs;
  var dob = "".obs;
  var branchId = "".obs;

  /*---------------NEW Variable--------------*/
  /*-----Identification Document-------*/
  var idType = "".obs;
  var idNumber = "".obs;

  /*-----kin-------*/
  var kinName = "".obs;
  var kinContact = "".obs;

  /*-----Home Address-------*/
  var homeTitle1 = "".obs;
  var homeTitle2 = "".obs;
  var homeAddress = "".obs;
  var homeState = "".obs;
  var homePostalCode = "".obs;
  var homeCountry = "".obs;
  var homePhone = "".obs;

  /*-----Office Address-------*/
  var officeTitle1 = "".obs;
  var officeTitle2 = "".obs;
  var employmentStatus = "".obs;
  var occupation = "".obs;
  var employer = "".obs;
  var officeAddress = "".obs;
  var officeState = "".obs;
  var officePostalCode = "".obs;
  var officeCountry = "".obs;
  var officePhone = "".obs;

  /*-----Medical Doctor INfo-------*/

  var medicalTitle1 = "".obs;
  var medicalTitle2 = "".obs;
  var medicalName = "".obs;
  var medicalPracticeName = "".obs;
  var medicalAddress = "".obs;
  var medicalState = "".obs;
  var medicalPostalCode = "".obs;
  var medicalCountry = "".obs;
  var medicalPhone = "".obs;

  var aboutUs = "".obs;




/*----------Fetch Patient API-----------*/
  void patientProfile(BuildContext context) async {
    loading.value = true;
    resultVar.value = 0;
    final Map<String, dynamic> ProfilePerameter = {
      // "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "patient_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    print("Patient Login Parameter$ProfilePerameter");

    final response =
        await apiService.postData(MyAPI.PFetchProfile, ProfilePerameter);
    try {
      log("response of Patient Profile :-${response.body}");
      log("my id ${sp.PATIENT_ID_KEY}");
      loading.value = false;
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'].toString();

        name.value = jsonResponse["name"].toString();
        title.value = jsonResponse["title"].toString();
        gender.value = jsonResponse["gender"].toString();
        log(name.value);
        surename.value = jsonResponse["surname"].toString();
        username.value = jsonResponse["username"].toString();
        healthCard.value = jsonResponse["health_card"].toString();
        image.value = jsonResponse["user_profile"].toString();
        qrCode.value = jsonResponse["QR_Code"].toString();
        flag.value = jsonResponse["flag"].toString();

        log(healthCard.value);
        Email.value = jsonResponse["email"].toString();
        phone.value = jsonResponse["contact"].toString();
        code.value = jsonResponse["code"].toString();
        Password.value = jsonResponse["password"].toString();
        address.value = jsonResponse["location"].toString();

        /*--new filed added--*/
        age.value = jsonResponse["age"].toString();
        weight.value = jsonResponse["weight"].toString();
        height.value = jsonResponse["height"].toString();
        birthplace.value = jsonResponse["birth_place"].toString();
        taxCode.value = jsonResponse["tax_code"].toString();
        dob.value = jsonResponse["dob"].toString();
        branchId.value = jsonResponse["branch_id"].toString();

        idType.value = jsonResponse["id_type"].toString();
        idNumber.value = jsonResponse['id_number'].toString();
        /*-----kin-------*/
        kinName.value = jsonResponse['kin_name'].toString();
        kinContact.value = jsonResponse['kin_phone'].toString();
        /*-----Home Address-------*/
        homeTitle1.value = jsonResponse['home_line1'].toString();
        homeTitle2.value = jsonResponse['home_line2'].toString();
        homeAddress.value = jsonResponse['home_city'].toString();
        homeState.value = jsonResponse['home_state'].toString();
        homePostalCode.value = jsonResponse['home_postal_code'].toString();
        homeCountry.value = jsonResponse['home_country'].toString();
        homePhone.value = jsonResponse['home_phone'].toString();
        /*-----Office Address-------*/
        officeTitle1.value = jsonResponse['employer_line1'].toString();
        officeTitle2.value = jsonResponse['employer_line2'].toString();
        employmentStatus.value = jsonResponse['employer_state'].toString();
        occupation.value = jsonResponse['occupation'].toString();
        employer.value = jsonResponse['employer'].toString();
        officeAddress.value = jsonResponse['employer_city'].toString();
        officeState.value = jsonResponse['employer_state'].toString();
        officePostalCode.value = jsonResponse['employer_postal_code'].toString();
        officeCountry.value = jsonResponse['employer_country'].toString();
        officePhone.value = jsonResponse['employer_phone'].toString();
        /*-----Medical Doctor INfo-------*/
        medicalTitle1.value = jsonResponse['doctor_line1'].toString();
        medicalTitle2.value = jsonResponse['doctor_line2'].toString();
        medicalName.value = jsonResponse['doctor_name'].toString();
        medicalPracticeName.value = jsonResponse['doctor_practice_name'].toString();
        medicalAddress.value = jsonResponse['doctor_city'].toString();
        medicalState.value = jsonResponse['doctor_state'].toString();
        medicalPostalCode.value = jsonResponse['doctor_postal_code'].toString();
        medicalCountry.value = jsonResponse['doctor_country'].toString();
        medicalPhone.value = jsonResponse['doctor_phone'].toString();
        aboutUs.value = jsonResponse['about_us'].toString();

        resultVar.value = 1;
      } else {
        resultVar.value = 2;

        loading.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      resultVar.value = 2;
      loading.value = false;
      log("exception-$e");
    }
  }

/*----------Update Patient API-----------*/
  void patientProfileUpdate(
      BuildContext context,
      String title,
      String name,
      String surname,
      String email,
      String countrycode,
      String mobileNo,
      String flag,
      String password,
      String age,
      String weight,
      String birthplace,
      String height,
      String taxCode,
      String gender,
      String dob,
      String branchId,
      String imageName,
      String imageStr,

      /*---New---*/
      String idType,
      String idNumber,

      String kinName,
      String kinContact,

      String homeTitle1,
      String homeTitle2,
      String homeAddress,
      String homeState,
      String homePostalCode,
      String homeCountry,
      String homePhone,

      String officeTitle1,
      String officeTitle2,
      String employmentStatus,
      String occupation,
      String employer,
      String officeAddress,
      String officeState,
      String officePostalCode,
      String officeCountry,
      String officePhone,

      String medicalTitle1,
      String medicalTitle2,
      String medicalName,
      String medicalPracticeName,
      String medicalAddress,
      String medicalState,
      String medicalPostalCode,
      String medicalCountry,
      String medicalPhone,
      String aboutUs,

      VoidCallback callback) async {
    loadingU.value = true;
    final Map<String, dynamic> profileUpdatePerameter = {
      "patient_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "title": title,
      "name": name,
      "surname": surname,
      "email": email,
      "code": countrycode,
      "contact": mobileNo,
      "flag": flag,
      "password": password,
      "health_card":"",
      "username":"",
      "age": age,
      "weight": weight,
      "birth_place": birthplace,
      "height": height,
      "tax_code": taxCode,
      "gender": gender,
      "dob": dob,
      "branch_id": branchId,
      "image_name": imageName,
      "image_str": imageStr,
      /*-----NEW--------*/
      "id_type": idType,
      "id_number": idNumber,

      "kin_name": kinName,
      "kin_phone": kinContact,

      "home_line1": homeTitle1,
      "home_line2": homeTitle2,
      "home_city": homeAddress,
      "home_state": homeState,
      "home_postal_code": homePostalCode,
      "home_country": homeCountry,
      "home_phone": homePhone,

      "employment_status": employmentStatus,
      "occupation": occupation,
      "employer": employer,
      "employer_line1": officeTitle1,
      "employer_line2": officeTitle2,
      "employer_city": officeAddress,
      "employer_state": officeState,
      "employer_postal_code": officePostalCode,
      "employer_country": officeCountry,
      "employer_phone": officePhone,

      "doctor_name": medicalName,
      "doctor_practice_name": medicalPracticeName,
      "doctor_line1": medicalTitle1,
      "doctor_line2": medicalTitle2,
      "doctor_city": medicalAddress,
      "doctor_state": medicalState,
      "doctor_postal_code": medicalPostalCode,
      "doctor_country": medicalCountry,
      "doctor_phone": medicalPhone,
      "about_us":aboutUs,
    };
    log("Patient Profile Update Parameter$profileUpdatePerameter");
    final response = await http.post(
        Uri.parse(
          MyAPI.PUpdateProfile,
        ),
        body: profileUpdatePerameter);
    // final response =
    //     await apiService.postData(MyAPI.PUpdateProfile, profileUpdatePerameter);
    try {
      log("response of Patient Profile Update :-${response.body}");
      loadingU.value = false;
      var jsonResponse = jsonDecode(response.body);
      String result = jsonResponse['result'];
      if (response.statusCode == 200) {
        callback();
        patientProfile(context);
        // custom.massenger(context, 'Profile Update Successfully');
        print("success profile update patient");
      } else {
        loadingU.value = false;
        custom.massenger(context, "Invalid Inputs");
      }
    } catch (e) {
      loadingU.value = false;
      log("excaption$e");
    }
  }
}
