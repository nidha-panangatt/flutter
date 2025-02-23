//api post

//api post


import 'package:dio/dio.dart';
import 'package:smart_tracking/services/loginapi.dart';

Map<String, dynamic> studentprofileData = {};

final dio = Dio();

Future<Map<String, dynamic>> studentprofileAPI() async {
  try {
    Response response = await dio.get(
      '$baseurl/studentprofile/$lid',
    );
    print(response);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      // List<dynamic> products = response.data;
      // List<Map<String, dynamic>> listdata =
      //     List<Map<String, dynamic>>.from(products);
      studentprofileData = response.data;
      print(studentprofileData);
      return response.data;
    } else {
      return {};
    }
  } catch (e) {
    print(e.toString());
    return{};
}
}