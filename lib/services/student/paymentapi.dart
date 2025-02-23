//api post

//api post


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_tracking/services/loginapi.dart';

final dio = Dio();

Future<void> makepaymentApi(data,context) async {
  try {
    print(data);
    Response response = await dio.post('$baseurl/feepayment',data: data );
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success");
      // List<dynamic> products = response.data;
      // List<Map<String, dynamic>> listdata =
      //     List<Map<String, dynamic>>.from(products);
     Navigator.pop(context);
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment success ')));
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
    
}
}