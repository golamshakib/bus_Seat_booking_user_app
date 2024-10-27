import 'package:bus_seat_booking_user/pages/my_booking_page.dart';
import 'package:bus_seat_booking_user/pages/my_profile_page.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_user/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../pages/search_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 180.0,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/done.png',
                    height: 120,
                    width: 120.0,
                  ),
                  Consumer<FirebaseAuthProvider>(
                      builder: (context, provider, child) {
                        if (provider.isUserAnonymous || provider.currentUser == null) {
                          return const Text('Hello, Guest');
                        }
                        final user = provider.userModel!.fullName;
                        return Text('Hello, $user');
                  })
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyProfilePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online_rounded),
              title: const Text('My bookings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyBookingPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                EasyLoading.show(status: 'Signing out...');
                await context.read<FirebaseAuthProvider>().logout();
                await context.read<FirebaseAuthProvider>().anonymousUserLogin();
                EasyLoading.dismiss();
                showMsg(
                    context,
                    'Successfully signed out, now you can use this app anonymously',
                    true);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
