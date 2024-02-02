import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider{

  String ON_BOARDING_KEY = 'ON_BOARDING_KEY';
  String FIREBASE_TOKEN_KEY = 'FIREBASE_TOKEN_KEY';
  String CURRENT_DEVICE_KEY = 'CURRENT_DEVICE_KEY';

  String LOGIN_KEY_TYP = 'LOGIN_KEY_TYP';
  String USER_TYPE = 'USER_TYPE';

  String PATIENT_LOGIN_KEY = 'LOGIN_KEY';
  String PATIENT_ID_KEY = 'PATIENT_ID_KEY';
  String PATIENT_NAME_KEY = 'PATIENT_NAME_KEY';
  String PATIENT_SURE_NAME_KEY ="PATIENT_SURE_NAME_KEY";
  String PATIENT_PROFILE ="PATIENT_PROFILE";
  String PATIENT_BRANCH ="PATIENT_BRANCH";


  String PATIENT_EMAIL_KEY = 'PATIENT_EMAIL_KEY';
  String PATIENT_PHONE_KEY = 'PATIENT_PHONE_KEY';
  String PATIENT_COUNTRYCODE_KEY = 'PATIENT_COUNTRYCODE_KEY';

  /*--------Doctor side------*/
String DOCTOR_LOGIN_KEY = 'DOCTOR_LOGIN_KEY';
String DOCTOR_ID_KEY = 'DOCTOR_ID_KEY';
String DOCTOR_BRANCH_ID_KEY = 'DOCTOR_BRANCH_ID_KEY';
String DOCTOR_NAME_KEY ="DOCTOR_NAME_KEY";
String DOCTOR_SURE_NAME_KEY ="DOCTOR_SURE_NAME_KEY";

  /*--------Medical Center side------*/
  String CENTER_LOGIN_KEY = 'CENTER_LOGIN_KEY';
  String CENTER_ID_KEY = 'CENTER_ID_KEY';

/*for filter location store*/
  String FILTER_LABLE = 'FILTER_LABLE';
  String FILTER_LOCATION = 'FILTER_LOCATION';
  String FILTER_LAT = 'FILTER_LAT';
  String FILTER_LONG = 'FILTER_LONG';
  String FILTER_CAP = 'FILTER_CAP';

  String LANGUAGE = 'LANGUAGE';

  void setBoolValue(String keyBool, bool valueBool) async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(keyBool, valueBool);
  }

  Future<bool?> getBoolValue(String keyBool) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(keyBool);
  }

  void setStringValue(String keyString, String valueString) async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(keyString, valueString);
  }
  void setStringTyp(String keyString, String type) async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(keyString, type);
  }
  Future<String?> getStringValue(String keyString) async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(keyString);
  }

  void clearSharedPreference() async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}