import 'package:bus_seat_booking_user/pages/confirm_booking_page.dart';
import 'package:bus_seat_booking_user/pages/search_page.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_user/providers/seat_plan_provider.dart';
import 'package:bus_seat_booking_user/utils/widget_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (context.read<FirebaseAuthProvider>().currentUser != null &&
        !context.read<FirebaseAuthProvider>().isUserAnonymous) {
      Future.delayed(const Duration(seconds: 1),() {
        Navigator.pushReplacementNamed(context, SearchPage.routeName);
      });
    } else {
      context.read<FirebaseAuthProvider>().anonymousUserLogin().then((_) {
        Navigator.pushReplacementNamed(context, SearchPage.routeName);
      }).catchError((error) {
        showMsg(context, error, false);
      });
    }
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
