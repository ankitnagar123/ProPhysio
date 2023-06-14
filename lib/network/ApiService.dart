import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;

import 'Apis.dart';

class ApiService extends GetxService {
  static var client = http.Client();
  final int timeoutInSeconds = 30;

  Future<http.Response> postData(String url, dynamic body) async {
    return await client.post(Uri.parse(MyAPI.BaseUrl + url), body: body)
        .timeout(Duration(seconds: timeoutInSeconds));
  }

  Future<http.Response> getData(String uri) async {
    http.Response response = await client.get(Uri.parse(MyAPI.BaseUrl + uri))
        .timeout(Duration(seconds: timeoutInSeconds));
    return response;
  }


// Future<http.StreamedResponse> multipartData(String url, Map<String,String> map, File? file,String key) async {
//   http.MultipartRequest request =
//   http.MultipartRequest('Post', Uri.parse(MyAPI.BaseUrl + url));
//
//   if (file != null) {
//     request.files.add(http.MultipartFile(
//         key, file.readAsBytes().asStream(), file.lengthSync(),
//         filename: file.path.split('/').last));
//   }
//
//   request.fields.addAll(map);
//
//   print("multipartData request.fields:--- ${map.toString()}");
//   http.StreamedResponse response = await request.send();
//   return response;
// }

}
