//api post

//api post


import 'package:dio/dio.dart';
import 'package:smart_tracking/services/loginapi.dart';

Map<String, dynamic> parentprofileData = {};

final dio = Dio();

Future<Map<String, dynamic>> parentprofileAPI() async {
  try {  
    Response response = await dio.get(
      '$baseurl/parentprofile/$lid',
    );
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      // List<dynamic> products = response.data;
      // List<Map<String, dynamic>> listdata =
      //     List<Map<String, dynamic>>.from(products);
      parentprofileData = response.data;
      return response.data;
    } else {
      return {};
    }
  } catch (e) {
    print(e.toString());
    return{};
}
}