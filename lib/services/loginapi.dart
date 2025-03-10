
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_tracking/screens/PARENTS/Phomepage.dart';
import 'package:smart_tracking/screens/student/bottombar.dart';
import 'package:smart_tracking/screens/teacher/THomepage.dart';
import 'package:smart_tracking/services/parent/parentprofileapi.dart';
import 'package:smart_tracking/services/student/getattendance.dart';
import 'package:smart_tracking/services/student/getnotificationapi.dart';
import 'package:smart_tracking/services/student/studentprofileapi.dart';
import 'package:smart_tracking/services/teacher/teacherprofileapi.dart';

String baseurl = 'http://192.168.99.244:5000/administrator';
String imageurl='http://192.168.99.244:5000';
int? lid;
String? userType;  
String? loginStatus;

Future<void> loginApi(
  
    String username, String password, BuildContext context) async {
  try {
    print('object');
    Dio dio = Dio();

    // Prepare the form data for the POST request
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
      
    });

    // Perform the POST request

    final response = await dio.post('$baseurl/loginapi', data: formData);
    print(formData);

    // Check the status code and response data
    print(response.data);

    int statusCode = response.statusCode ?? 0;
    print('Status code: $statusCode');

    // Decode the JSON response
    final data = response.data;

    loginStatus = data['message'] ?? 'failed';

    if (statusCode == 200 && loginStatus == 'success') {
      userType = data['type'];
      lid = data['login_id'];
      // await getProfileAPI();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctxt) => AgriHomePage()));
      // Navigate based on userType
      if (userType == 'teacher') {
        await teacherprofileAPI();
         await getnotificationAPI();
        Navigator.pushReplacement
        (
          context,
          MaterialPageRoute(builder: (ctx) => const THomepage()),
        );
      } else if (userType == 'student') {
       await studentprofileAPI();
      await getnotificationAPI();
      await getattendanceAPI();
      
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const BottomNavBarScreen()),
        );
      } else if (userType == 'parent') {
await parentprofileAPI();
 await getnotificationAPI();
      
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const PHomepage()),
        );
      } else {
        // Handle unknown userType
        print('Unknown userType: $userType');
      }
    } else {
      print('Login failed: $loginStatus');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $loginStatus'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error during login: $e'),
      ),
    );  
    print('Error during login: $e');
}
}