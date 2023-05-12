import 'dart:core';

class MyAPI{
  static const String BaseUrl = "https://cisswork.com/Android/Medica/Apis/process.php?action=";
  /*--------Patient Side API-----------*/
  static const String Login = "user_login";
  static const String forgotPassword = "get_user_forgot_password";
  static const String setNewPassword = "user_reset_pass";


  static const String PSignUp = "user_signup";
  static const String PSignUpOtp = "signup_email_otp";

  static const String PFetchProfile = "fetch_user_profile";
  static const String PUpdateProfile = "update_user_profile";
  static const String PChangePassword = "user_change_pass";
  static const String PDeleteAccount ="delete_user_account";
  static const String pSupport = "user_support";

  /*----Card API-------*/
  static const String addCard = "user_add_card";
  static const String cardFetch = "user_card_list";
  static const String cardRemove = "remove_card";

  /*-----Doctor List API-------*/
  static const String pDoctorList = "doctor_list";
  static const String pDoctorDetails ="fetch_doctor";

  /*----Specialization-----*/
  static const String pFetchSpecialization ="category";
  static const String pFetchSpecializationDetials ="specialization_details";

  /*--Calender API for Date Show---*/
  static const String pCalenderDate = "calender";

  /*---Appointment Api...----*/
  static const String pDoctorVisitCharge = "visit_charges";
  static const String pBookingAppointment = "booking";
  static const String pDoctorTimeSlot = "user_date";

  /*---Booking List{Past,Pending,Upcoming,Cancel,All Details}------*/
  static const String pBookingAppointmentList = "user_history";
  static const String pBookingAppointmentDetail = "user_booking_detail";
  static const String pBookingAppointmentCancel = "cancle_user_reason";
  static const String pCancelAppointmentRemove = "delete_booking";

/*-----Rating list and rating to dr------*/
  static const String pFetchRating = "rating_review_list";
  static const String pAddRating = "add_review_rating";

  /*---Filter side----*/
  static const String pSetLocation = "update_user_address";

/*-------------------- patient Chat Api's------------*/
  static const String pSendMsg = "send_msg";
  static const String pChatViewListFetch = "fetch_messages";
  static const String pChatListFetch = "user_msg_list";
  static const String pChatListDelete = "delete_doctor_msg_list";

/*---Prescription api with type Medical report and prescription----*/
  static const String pFetchPrescription= "fetch_user_prescription";



/*--------Doctor Side API-----------*/

  /*----Dr SignUp Time Add Cat and Sub-Cat multiple------*/
  static const String catSubcategoryList= "fetch_all_sub_category";
  static const String subcategoryList= "subcategory_list";
  static const String DCategorySignUp= "category_list";
  static const String DSignUpOtp = "doctor_otp_signup";
  static const String DSignUp = "doctor_signup";
  static const String DForgotPassword = "get_doctor_forgot_password";
  static const String DFetchProfile = "fetch_doctor_profile";
  static const String DUpdateProfile = "update_Doctor_profile";
  static const String DUpdateDegree= "Update_doctor_document";
  static const String DDeleteAccount ="delete_doctor_account";
  static const String DChangePassword = "doctor_change_pass";
  static const String DSupport = "doctor_support";

  /*----Add Specialization with visit charge-----*/
  static const String DAddSpecialization = "specialization";
  static const String DAddSpecializationFee = "add_visit";

  /*----Add Date, multiple Time slot's -----*/
  static const String dAddAvailibitly = "date";
  static const String dAddMultipleTime = "select_time";
  static const String dFetchTime ="Time_lists";

  /*---Booking List{Past,Pending,Upcoming,Cancel,All Details}------*/
  static const String dBookingAppointmentList = "booking_history";
  static const String dBookingAppointmentDetial = "userbooking_history";

  static const String dBookingAppointmentReject = "booking_reject";
  static const String dBookingAppointmentAccept = "booking_confirm";
  static const String dBookingAppointmentDone = "booking_complete";
  static const String dAppointmentCancelList = "cancle_doctor_reason";
  static const String dBookingAppointmentCancel = "booking_cancle";

  /*For Calculate dr earning*/
  static const String dCalculateEarning = "calculate_earnings";

  static const String dSelectedCategory = "category";
  static const String dSelectedSubCategory = "selected_subcategory";

/*----Add Prescription by doctor------*/
static const String dAddPrescription= "prescription";
  static const String fetchPrescription= "fetch_prescription";

  /*Chat list Dr*/
  static const String dChatListFetch = "doctor_msg_list";
  static const String dChatListDelete = "delete_user_msg_list";


static const String updateToken = "android_update_userdevice_id";

/*-------------Medical Center side api---------------------*/

  static const String CSignUpOtp = "medical_otp_signup";
  static const String CSignUp = "medical_signup";
  static const String cAllDoctorList = "medical_center_doctor_list";
  static const String cAddDoctor = "add_medical_center_doctor";
  static const String cSelectedDoctor = "fetch_medical_center_doctor";

}
