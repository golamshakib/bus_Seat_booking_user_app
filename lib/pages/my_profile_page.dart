import 'package:bus_seat_booking_user/pages/edit_profile_page.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  static const String routeName = '/my_profile';

  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<FirebaseAuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: 120, // Adjust the width
              height: 120, // Adjust the height
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Makes the container circular
                image: DecorationImage(
                  image: provider.userModel?.image != null
                      ? NetworkImage(provider.userModel!.image!)
                      : const AssetImage('assets/images/person.png')
                          as ImageProvider,
                  // Use a default image if null
                  fit: BoxFit.cover, // Cover the entire container
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(provider.userModel!.fullName),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(provider.userModel!.address),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(provider.userModel!.number),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(provider.userModel!.email),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfilePage.routeName)
                    .then((updated) {
                  if (updated == true) {
                    setState(() {});
                  }
                });
              },
              child: const Text(
                'Edit profile',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
