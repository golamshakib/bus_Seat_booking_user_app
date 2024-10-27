import 'package:bus_seat_booking_user/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_auth_provider.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = '/edit_profile';

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    final provider = context.read<FirebaseAuthProvider>();
    _fullNameController.text = provider.userModel!.fullName;
    _addressController.text = provider.userModel!.address;
    _phoneNumberController.text = provider.userModel!.number;
    _emailController.text = provider.userModel!.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FirebaseAuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 120, // Adjust the width
                  height: 120, // Adjust the height
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Makes the container circular
                    image: DecorationImage(
                      image: provider.userModel?.image != null
                          ? NetworkImage(provider.userModel!.image!)
                          : AssetImage('assets/images/person.png')
                              as ImageProvider,
                      // Use a default image if null
                      fit: BoxFit.cover, // Cover the entire container
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Handle edit image action here
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        // Background color for the edit icon
                        shape: BoxShape.circle, // Circular shape
                      ),
                      padding: EdgeInsets.all(5), // Adjust padding for the icon
                      child: Icon(
                        Icons.edit,
                        color: Colors.white, // Icon color
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text(
                'SAVE',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() async {
    EasyLoading.show(status: 'Saving...');
    final provider = context.read<FirebaseAuthProvider>();
    provider.userModel!.fullName = _fullNameController.text;
    provider.userModel!.address = _addressController.text;
    provider.userModel!.number = _phoneNumberController.text;

    await provider.updateUSerProfile(provider.userModel!);
    EasyLoading.dismiss();
    showMsg(context, 'Your profile is updated', true);
    Navigator.pop(context, true);
  }
}
