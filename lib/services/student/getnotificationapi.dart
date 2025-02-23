//api post

//api post


import 'package:dio/dio.dart';
import 'package:smart_tracking/services/loginapi.dart';

final dio = Dio();

List<Map<String, dynamic>>studentNotifications=[];

Future<List<Map<String, dynamic>>> getnotificationAPI() async {
  try {
    Response response = await dio.get('$baseurl/notification/$lid', );
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      List<dynamic> products = response.data;
      List<Map<String, dynamic>> listdata =
          List<Map<String, dynamic>>.from(products);
          studentNotifications=listdata;
      return listdata;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return[];
}
}