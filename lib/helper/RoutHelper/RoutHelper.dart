import 'package:get/get.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/DoctorMainPage.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_booking_page/doctor_search_appointments/DoctorSearchAppoinmentsScreen.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_chat_page/DoctorChatProfile.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_chat_page/DoctorChatingScreen.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_about_page/DoctorAboutPage.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_profile/DoctorAddSpecialization.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_profile/DoctorPersonalData.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_profile/DoctorProfile.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_settings_screen/DoctorSettingsScreen.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_settings_screen/doctor_change_password_screen/DoctorChangePasswordScreen.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_support_screen/DoctorSupportScreen.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/doctor_term_condition_page/DoctorTermCondition.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/earning_page/DoctorEarningScreen.dart';
import 'package:medica/forgot_password/ForgotPasswordScreen.dart';
import 'package:medica/forgot_password/OtpVerificationScreen.dart';
import 'package:medica/forgot_password/SetNewPassword.dart';
import 'package:medica/forgot_password/SetPasswordSuccess.dart';
import 'package:medica/medica_center/center_more/center_setting/CenterSupport.dart';
import 'package:medica/onboarding_screen/onBoardingScreen.dart';
import 'package:medica/patient_screens/view/doctor_detail_screen/SpecializationDetailScreen.dart';
import 'package:medica/patient_screens/view/patient_filters_sceen/FilterScreen.dart';
import 'package:medica/patient_screens/view/patient_filters_sceen/Location&DistanceFilter.dart';
import 'package:medica/patient_screens/view/patient_filters_sceen/RatingFilter.dart';
import 'package:medica/patient_screens/view/patient_main_screen/PatientMainScreen.dart';
import 'package:medica/patient_screens/view/patient_main_screen/chating_page/PatinetChatingScreen.dart';
import 'package:medica/signin_screen/SignInScreen.dart';
import 'package:medica/singup_screen/SingUpScreen.dart';
import 'package:medica/singup_screen/doctor_signup_page/DoctorSignUpOtp.dart';
import 'package:medica/singup_screen/patient_pages/PatinetSignUpOtp.dart';

import '../../doctor_screens/view/doctor_main_page/doctor_home_page/CancelAppoiemntSucces.dart';

import '../../doctor_screens/view/doctor_main_page/doctor_more_page/Center_request/DCenterRequest.dart';
import '../../doctor_screens/view/doctor_main_page/doctor_more_page/earning_page/CalculateEarnings.dart';
import '../../medica_center/add_ward/CenterAddNewWard.dart';
import '../../medica_center/add_ward/EditWard/AddMoreDrWard.dart';
import '../../medica_center/add_ward/EditWard/EditWardPage.dart';
import '../../medica_center/center_home/CenterBottomNavigate.dart';
import '../../medica_center/center_home/CenterDoctorView.dart';
import '../../medica_center/center_more/center_earning/CenterEarning.dart';
import '../../medica_center/center_more/center_earning/CenterEarningList.dart';
import '../../medica_center/center_more/center_profile/CenterProfile.dart';
import '../../medica_center/center_more/center_setting/CenterChangePass.dart';
import '../../medica_center/center_more/center_setting/CenterSetting.dart';
import '../../patient_screens/view/book_appointment/AppointmentBookedSucces.dart';
import '../../patient_screens/view/doctor_detail_screen/PNavigateDrScreen.dart';
import '../../patient_screens/view/doctor_detail_screen/ReviewsScreen.dart';
import '../../patient_screens/view/doctor_detail_screen/ViewCertificateScreen.dart';
import '../../patient_screens/view/patient_filters_sceen/PatinetPriceRangeFilter.dart';
import '../../patient_screens/view/patient_main_screen/booking_history_page/PatientBookingCancelSuccess.dart';
import '../../patient_screens/view/patient_main_screen/booking_history_page/past_appointments/PastAppointmentsScreen.dart';
import '../../patient_screens/view/patient_main_screen/booking_history_page/search_appointments_screen/SearchAppoinmentsScreen.dart';
import '../../patient_screens/view/patient_main_screen/patient_home_page/HomePage/CenterSide/PWardDrList.dart';
import '../../patient_screens/view/patient_payment_screen/PatientAddNewCardScreen.dart';
import '../../patient_screens/view/patient_main_screen/more_page/MorePage.dart';
import '../../patient_screens/view/patient_main_screen/more_page/patient_profile_screen/PatientProfileScreen.dart';
import '../../patient_screens/view/patient_main_screen/more_page/patient_settings_screen/PatientSettingsScreen.dart';
import '../../patient_screens/view/patient_main_screen/more_page/patient_settings_screen/patient_change_password_screen/PatientChangePasswordScreen.dart';
import '../../patient_screens/view/patient_main_screen/more_page/patient_support_screen/PatientSupportScreen.dart';
import '../../patient_screens/view/patient_payment_screen/PatientPaymentScreen.dart';
import '../../singup_screen/doctor_signup_page/DoctorSelectAddress.dart';
import '../../singup_screen/medical_center_signup/MedicalCenterOtp.dart';
import '../../splash_screen/SplaceScreen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String onBoarding = '/OnBoarding';
  static const String singUpScreen = '/singUpScreen';
  static const String patientSignUpOtpScreen = '/PatientSignupOtpScreen';
  static const String loginScreen = '/LoginScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String setPassword = '/SetPassword';

  static const String SetPassSuccess = '/PSetPassSuccess';

/*------------------Patient Side----------------------------*/
  static const String patientBottomNavigation = '/PBottomnavigation';
  static const String pastAppointmentsScreen = '/pastAppointmentsScreen';
  static const String filterScreen = '/filterScreen';
  static const String searchAppointmentScreen = '/searchAppointmentScreen';

  static const String locationDistanceFilter = '/locationDistanceFilter';
  static const String pSetLocation = '/pSetLocation';
  static const String pEditSetLocation = '/pEditSetLocation';
  static const String pPriceRangeFilter = '/pPriceRangeFilter';


  static const String specializationScreen = '/specializationScreen';
  static const String specializationDetailsScreen = '/specializationDetailsScreen';

  static const String ratingFilterScreen = '/ratingFilterScreen';
  static const String morePage = '/morePage';
  static const String patientProfileScreen = '/patientProfileScreen';
  static const String patientPaymentScreen = '/patientPaymentScreen';
  static const String patientAddNewCardScreen = '/patientAddNewCardScreen';
  static const String viewCertificateScreen = '/viewCertificateScreen';
  static const String reviewsScreen = '/reviewsScreen';
  static const String pNavigateDrScreen = '/pNavigateDrScreen';

  static const String doctorDetailScreen = '/doctorDetailScreen';
  static const String patientSettingsScreen = '/patientSettingsScreen';
  static const String patientChangePasswordScreen = '/patientChangePasswordScreen';
  static const String patientSupportScreen = '/patientSupportScreen';
  static const String pChatScreen = '/ChatScreen';
  static const String pBookingReqSuccess = '/BookingReqSuccess';
  static const String pCancelAppointSucces = '/pCancelAppointSucces';
  static const String pCenterWardDrList = '/pCenterWardDrList';


  /*----------Doctor Side Screen's-------------------*/
/*||||||||||||||||||||||||||||||||||||||||||||||||||||*/
  static const String dSignUpOtp = '/dSignUpOtp';
  static const String dSearchLocation = '/dSearchLocation';

  static const String dHomeScreen = '/dhomeScreen';
  static const String dCancelAppointSucces = '/dCancelAppointSucces';
  static const String dSearchAppointment = '/dSearchAppointment';
  static const String dChatScreen = '/dChatScreen';
  static const String dChatProfile = '/dChatProfile';
  static const String dPersonalData = '/dPersonalData';
  static const String dProfile = '/dProfile';
  static const String dAddSpecialization = '/dAddSpecialization';

  static const String dEarningCalculate = '/dEarningCalculate';
  static const String dEarningListScreen = '/dEarningListScreen';
  static const String dSetting = '/dSetting';
  static const String dChangePassword = '/dChangePassword';
  static const String dTermCondition = '/dTermCondition';
  static const String dAbout = '/dAbout';
  static const String dCenterRequest = '/dCenterRequest';

  static const String dSupport = '/dSupport';



/*||||||||||||||||||||||||||||||||||||||||||||||||||||*/
  // static const String SearchScreen = '/searchScreen';
  //
  // static const String PDrListCatWise = '/ListCatWise';
  // static const String PSubcat = '/psubcat';
  // static const String PDrInformation = '/DrInformation';
  // static const String PViewCertificate = '/ViewCertificate';
  // static const String PAppointmentScreen = '/AppointmentScreen';
  // static const String PHealthCard = '/HealthCard';
  // static const String PAddNewCard = '/AddNewCard';
  // static const String PManageCard = '/ManageCard';
  //
  // /*------menu---------*/
  // static const String PProfile = '/ProfileScreen';
  // static const String PChatContact = '/ChatContact';
  // static const String PSetting = '/SettingPage';
  //
  // /*----In Setting Page---------*/
  // static const String PTermsCondition = '/TermsCondition';
  // static const String PChangePassword = '/ChangePassword';
  // static const String PContactUs = '/ContactUs';
  // static const String PDeleteAccount = '/DeleteAccount';
  // static const String PAbout = '/AboutPage';
  //
  // /*--------------------Doctor Side-----------------------------------------*/
  // static const String DSignup = '/dsignup';
  // static const String DUploadD = '/duploadd';
  // static const String DVerification = '/dverification';
  // static const String Dlogin = '/dlogin';
  // static const String Dforgotpass = '/dForgotpass';
  // static const String DSetpass = '/dsetpass';
  // static const String Dsetpassucces = '/setpassucces';
  // static const String DHome = '/dhome';
  // static const String DEarning = '/dearning';
  // static const String DBooking = '/dbooking';

  /*------menu---------*/
  static const String Dmenu = '/dmenu';
  static const String Dprofile = '/dprofile';
  static const String DChageDegree = '/dchangedegree';
  static const String DchatList = '/dchatlist';

  /*----In Setting Page---------*/
  static const String DSetting = '/dsetting';
  static const String DtrmCondition = '/dtrmcondition';
  static const String DChangePass = '/dchangepass';
  static const String DContactuUs = '/dcontactus';
  static const String DDeleteAc = '/ddeleteac';
  static const String DAbout = '/dabout';




  /*----------Medical center Side Screen's-------------------*/
  static const String cSignUpOtp = '/cSignUpOtp';
  static const String cHomeScreen = '/chomeScreen';
  static const String cCenterDoctorViewScreen = '/cCenterDoctorViewScreen';
  static const String cCenterAddWard = '/cCenterAddWard';

  static const String cBottomNavigation = '/cBottomNavigation';
  static const String cEditWard = '/cEditWard';
  static const String cProfile = '/cProfile';
  static const String cEarningCalculate = '/cEarningCalculate';
  static const String cEarningList = '/cEarningList';
  static const String cSetting = '/cSetting';
  static const String cChangePassword = '/cChangePassword';
  static const String cTandC = '/cTandC';
  static const String cAbout = '/cAbout';
  static const String cSupport = '/cSupport';
  static const String cAddMoreDr = '/cAddMoreDr';



  /*-------------------- Functions ---------------*/
  static String getInitialRoute() => initial;

  static String getSplashScreen() => splash;

  static String getOnBoardingScreen() => onBoarding;

  // static String getSelectPerson() => ChosePerson;
  static String getSingUpOtpScreen() => patientSignUpOtpScreen;

  static String getSingUpScreen() => singUpScreen;

  static String getForgotPasswordScreen() => forgotPasswordScreen;

  static String getVerification() => verificationScreen;

  //******--------------------Patient Screen's------------------*******//
  // static String getSignUpScreen() => PatientSignUpScreen;
  static String getLoginScreen() => loginScreen;

  static String getPastAppointmentsScreen() => pastAppointmentsScreen;

  static String getSetPassword() => setPassword;

  static String getSetPassSuccess() => SetPassSuccess;

  static String getBottomNavigation() => patientBottomNavigation;

  static String getFilterScreen() => filterScreen;

  static String getSearchAppointmentScreen() => searchAppointmentScreen;

  static String getSpecializationScreen() => specializationScreen;

  static String getSpecializationDetailsScreen() => specializationDetailsScreen;


  static String getRatingFilterScreen() => ratingFilterScreen;

  static String getMorePage() => morePage;

  static String getPatientProfileScreen() => patientProfileScreen;

  static String getPatientPaymentScreen() => patientPaymentScreen;

  static String getPatientAddNewCardScreen() => patientAddNewCardScreen;

  static String getViewCertificateScreen() => viewCertificateScreen;

  static String getReviewsScreen() => reviewsScreen;

  static String getNavigateDoctor() => pNavigateDrScreen;

  static String getDoctorDetailScreenMap() => doctorDetailScreen;

  static String getPatientSettingsScreen() => patientSettingsScreen;

  static String getPatientChangePasswordScreen() => patientChangePasswordScreen;

  static String getPatientSupportScreen() => patientSupportScreen;

  static String getLocationDistanceFilter() => locationDistanceFilter;
  static String getPriceRange()=> pPriceRangeFilter;
  static String getChatScreen() => pChatScreen;

  static String getBookingSuccess() => pBookingReqSuccess;
 static String getCancelBookingScreen() => pCancelAppointSucces;
  static String getCenterWardDrList() => pCenterWardDrList;

/*------------Doctor Screen------------------*/
  static String DSignUpOtp() => dSignUpOtp;
  static String DSearchLocation() => dSearchLocation;

  static String DHomePage() => dHomeScreen;
  static String DCancelAppointSucces() => dCancelAppointSucces;
  static String DSearchAppointment() => dSearchAppointment;
  static String DChatScreen() => dChatScreen;
  static String DChatProfile() => dChatProfile;

  static String DPersonalData() => dPersonalData;
  static String DProfile() => dProfile;
  static String DAddSpecialization() => dAddSpecialization;

  static String DEarningCalculate() => dEarningCalculate;
  static String DEarningListScreen() => dEarningListScreen;

  static String DSettingScreen() => dSetting;
  static String DChangePassScreen() => dChangePassword;
  static String DTandCScreen() => dTermCondition;
  static String DAboutScreen() => dAbout;
  static String DCenterRequest() => dCenterRequest;

  static String DSupportScreen() => dSupport;

/*------------Medical Center Screen------------------*/
  static String CSignUpOtp() => cSignUpOtp;
  static String CCenterDoctorViewScreen() => cCenterDoctorViewScreen;
  static String CCenterAddWardScreen() => cCenterAddWard;

  static String CBottomNavigation() => cBottomNavigation;
  static String CEditWard() => cEditWard;
  static String CProfile() => cProfile;
  static String cEarningCal() => cEarningCalculate;
  static String cEarningLists() => cEarningList;
  static String cSettings() => cSetting;
  static String cChangePass() => cChangePassword;
  static String cTermCondition() => cTandC;
  static String cAbouts() => cAbout;
  static String cSupports() => cSupport;
  static String cAddMoreDrs() => cAddMoreDr;



  /// ****

/* -----------------------------------All Screen's List --------------------------- */
  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onBoarding, page: () => const OnBordingScreen()),
    GetPage(name: singUpScreen, page: () => const SingUpScreen()),
    GetPage(name: patientSignUpOtpScreen, page: () => const PatientSignUpOtp()),

    GetPage(name: loginScreen, page: () => const SignInScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPassword()),
    GetPage(name: verificationScreen, page: () => const OtpVerificationScreen()),
    GetPage(name: setPassword, page: () => const SetNewPassword()),
    GetPage(name: SetPassSuccess, page: () => const SetPasswordSuccess()),
    GetPage(name: patientBottomNavigation, page: () => const PatientMainScreen()),
    GetPage(name: pastAppointmentsScreen, page: () => const PastAppointmentsScreen()),
    GetPage(name: filterScreen, page: () => const FilterScreen()),
    GetPage(name: ratingFilterScreen, page: () => const RatingFilterScreen()),
    GetPage(name: locationDistanceFilter, page: () => const LocationDistanceFilter()),
    GetPage(name: pPriceRangeFilter, page: () => const PatientPriceRangeFilter()),

    GetPage(name: searchAppointmentScreen, page: () => const SearchAppointmentScreen()),
    GetPage(name: morePage, page: () => const MorePage()),

    GetPage(name: patientProfileScreen, page: () => const PatientProfileScreen()),
    GetPage(name: patientPaymentScreen, page: () => const PatientPaymentScreen()),
    GetPage(name: patientAddNewCardScreen, page: () => const PatientAddNewCardScreen()),
    GetPage(name: viewCertificateScreen, page: () => const ViewCertificateScreen()),
    GetPage(name: reviewsScreen, page: () => const ReviewsScreen()),
    GetPage(name: pNavigateDrScreen, page: () =>  const NavigateMapViewScreen()),

    // GetPage(name: doctorDetailScreen, page: () => const DoctorDetailScreen()),
    GetPage(name: pChatScreen, page: () =>  const PatientChatScreen()),
    GetPage(name: patientSettingsScreen, page: () => const PatientSettingsScreen()),
    GetPage(name: patientChangePasswordScreen, page: () => const PatientChangePasswordScreen()),
    GetPage(name: patientSupportScreen, page: () => const PatientSupportScreen()),
    GetPage(name: specializationDetailsScreen, page: () => const SpecializationScreen()),
    GetPage(name: pBookingReqSuccess, page: () => const AppointmentBookedSucces()),
    GetPage(name: pCancelAppointSucces, page: () => const PatientBookingCancelSuccess()),
    GetPage(name: pCenterWardDrList, page: () => const PWardDrListScreen()),


/*--------Doctor Side--------*/
    GetPage(name: dSignUpOtp, page: () => const DoctorSignUpOtp()),

    GetPage(name: dSearchLocation, page: () => const DoctorSelectAddress()),

    GetPage(name: dHomeScreen, page: () => const DoctorMainScreen()),
    GetPage(name: dCancelAppointSucces, page: () => const CancelAppointmentSuccess()),
    GetPage(name: dSearchAppointment, page: () => const DoctorSearchAppointments()),
    GetPage(name: dChatScreen, page: () =>  const DoctorChatScreen()),
    GetPage(name: dChatProfile, page: () => const DoctorChatProfile()),
    GetPage(name: dPersonalData, page: () => const DoctorPersonalData()),
    GetPage(name: dProfile, page: () => const DoctorProfileScreen()),
    GetPage(name: dAddSpecialization, page: () => const DoctorAddSpecialization()),

    GetPage(name: dEarningCalculate, page: () => const CalculateEarning()),
    GetPage(name: dEarningListScreen, page: () => const DoctorEarning()),

    GetPage(name: dSetting, page: () => const DoctorSettingsScreen()),
    GetPage(name: dChangePassword, page: () => const DoctorChangePasswordScreen()),
    GetPage(name: dTermCondition, page: () => const DoctorTermCondition()),
    GetPage(name: dAbout, page: () => const DoctorAboutScreen()),
     GetPage(name: dCenterRequest, page: () => const DCenterRequests()),
    GetPage(name: dSupport, page: () => const DoctorSupportScreen()),



/*--------Medical center side Side--------*/
    GetPage(name: cSignUpOtp, page: () => const MedicalCenterOtp()),
    GetPage(name: cCenterDoctorViewScreen, page: () => const CenterDoctorViewScreen()),
    GetPage(name: cCenterAddWard, page: () => const CenterAddWardScreen()),

    GetPage(name: cBottomNavigation, page: () => const CenterMainScreen()),
    GetPage(name: cEditWard, page: () => const CenterEditWardScreen()),
    GetPage(name: cProfile, page: () => const CenterProfile()),

    GetPage(name: cEarningCalculate, page: () => const CenterEarningCalculate()),
    GetPage(name: cEarningList, page: () => const CenterEarningList()),
    GetPage(name: cSetting, page: () => const CenterSettingsScreen()),
    GetPage(name: cChangePassword, page: () => const CenterChangePasswordScreen()),
    GetPage(name: cSupport, page: () => const CenterSupportScreen()),
    GetPage(name: cAddMoreDr, page: () => const WardAddMoreDoctor()),


  ];
}
