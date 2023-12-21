// import 'dart:developer';
//
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// import '../helper/sharedpreference/SharedPrefrenc.dart';
//
// class SocketIo {
//
//   static late IO.Socket socket;
//
//   static SharedPreferenceProvider sp = SharedPreferenceProvider();
//
//   static void userConnect()async{
//     String? userId = "";
//     var userType = await sp.getStringValue(sp.USER_TYPE);
//
//     if(userType =="Doctor"){
//        userId = await sp.getStringValue(sp.DOCTOR_ID_KEY);
//     }else{
//       userId = await sp.getStringValue(sp.PATIENT_ID_KEY);
//     }
//     log('user id -----$userId');
//
//     try{
//       socket = IO.io("ws://192.168.1.29:3008",
//           IO.OptionBuilder()
//               .setTransports(['websocket']) // for Flutter or Dart VM
//               .disableAutoConnect()  // disable auto-connection
//               .build()
//       );
//       socket.connect();
//       socket.emit("signIn",userId);
//       socket.emit("userConnected",userId);
//
//       socket.onConnect((data) {
//         print("Connected");
//       });
//     }catch(e){
//       log("Exception ----",error: e.toString());
//     }
//   }
// }