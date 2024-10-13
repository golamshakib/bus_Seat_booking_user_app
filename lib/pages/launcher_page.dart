import 'package:bus_seat_booking_user/main.dart';
import 'package:bus_seat_booking_user/pages/search_page.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_user/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void didChangeDependencies() {
    context.read<FirebaseAuthProvider>().anonymousUserLogin().then((_){
      Navigator.pushNamed(context, SearchPage.routeName);
    }).catchError((error){
      showMsg(context, 'Something went wrong', false);
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
