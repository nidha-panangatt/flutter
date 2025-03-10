import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:smart_tracking/services/loginapi.dart';
import 'package:smart_tracking/services/student/getstudentprofileapi.dart';
import 'package:smart_tracking/services/student/studentprofileapi.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  // Function to pick image from gallery or camera
  // Future<void> _pickImage(ImageSource source) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous page
          },
        ),
        title: const Text('My Profile'),
        backgroundColor: const Color.fromARGB(255, 63, 81, 181),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              :  NetworkImage('$imageurl${studentprofileData['student_image']}')
                                  as ImageProvider,
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: InkWell(
                        //     onTap: () {
                        //       showModalBottomSheet(
                        //         context: context,
                        //         builder: (_) {
                        //           return Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               ListTile(
                        //                 leading: Icon(Icons.photo_camera),
                        //                 title: Text('Take Photo'),
                        //                 onTap: () {
                        //                   Navigator.pop(context);
                        //                   // _pickImage(ImageSource.camera);
                        //                 },
                        //               ),
                        //               ListTile(
                        //                 leading: Icon(Icons.photo_library),
                        //                 title: Text('Choose from Gallery'),
                        //                 onTap: () {
                        //                   Navigator.pop(context);
                        //                   // _pickImage(ImageSource.gallery);
                        //                 },
                        //               ),
                        //             ],
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.blue,
                        //       radius: 20,
                        //       child: Icon(Icons.camera_alt, color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 16),
                     Text(
                      '${studentprofileData['Name']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                     Text('Admission No: ${studentprofileData['admissionno']}'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Divider(thickness: 1),

              // Personal Information Section
              _buildSectionHeader('Personal Information'),
              _buildInfoField('Department', '${studentprofileData['department']??"Not Available"}'),
              _buildInfoField('Semester', '${studentprofileData['sem']?? "Not Available"}'),
              _buildInfoField('Email ID', '${studentprofileData['email']?? "Not Available"}'),
              _buildInfoField('Date of Birth', '${studentprofileData['dob']?? "Not Available"}'),
              _buildInfoField('Phone No',  '${studentprofileData['ph_no']?? "+91 9876543210"}'),
              _buildInfoField('Guardian', '${studentprofileData['guardianname']?? " Mr. Kader"}'),
              _buildInfoField('Guardian Phone No', '${studentprofileData['phoneno']?? "+91 9876543210"}'),
              _buildInfoField('Address',  '${studentprofileData['address']?? '123, XYZ Street, ABC Colony, PQR City'}'),
              _buildInfoField('Place', '${studentprofileData['place']?? "Kochi"}'),
              const Divider(thickness: 1),

              // Commuter Information Section
              // _buildSectionHeader('Commuter Information'),
              // _buildDropdown(
              //   title: 'Commuter Type',
              //   options: ['Daily Commuters', 'Hostelers'],
              //   onChanged: (value) {
              //     // Handle commuter type change
              //   },
              // ),
              const SizedBox(height: 16),
              // _buildDropdown(
              //   title: 'Transportation Type',
              //   options: ['By College Bus', 'By Own Vehicle'],
              //   onChanged: (value) {
              //     // Handle transportation type change
              //   },
              // ),

              const SizedBox(height: 32),

              // Button to go to the previous page
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Navigate to the previous page
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Info Field Widget
  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Dropdown Widget
  // Widget _buildDropdown({
  //   required String title,
  //   required List<String> options,
  //   required ValueChanged<String?> onChanged,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(fontSize: 14, color: Colors.grey),
  //       ),
  //       SizedBox(height: 8),
  //       DropdownButtonFormField<String>(
  //         isExpanded: true,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           contentPadding: EdgeInsets.symmetric(horizontal: 12),
  //         ),
  //         items: options.map((String option) {
  //           return DropdownMenuItem<String>(
  //             value: option,
  //             child: Text(option),
  //           );
  //         }).toList(),
  //         onChanged: onChanged,
  //       ),
  //     ],
  //   );
  // }
}
