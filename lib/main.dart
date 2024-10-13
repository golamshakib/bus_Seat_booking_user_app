import 'package:bus_seat_booking_user/pages/confirm_booking_page.dart';
import 'package:bus_seat_booking_user/pages/launcher_page.dart';
import 'package:bus_seat_booking_user/pages/login_page.dart';
import 'package:bus_seat_booking_user/pages/schedule_page.dart';
import 'package:bus_seat_booking_user/pages/search_page.dart';
import 'package:bus_seat_booking_user/pages/seat_plan_page.dart';
import 'package:bus_seat_booking_user/providers/booking_provider.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_user/providers/seat_plan_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => SeatPlanProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        SchedulePage.routeName: (context) => const SchedulePage(),
        SearchPage.routeName: (context) => const SearchPage(),
        SeatPlanPage.routeName: (context) => const SeatPlanPage(),
        ConfirmBookingPage.routeName: (context) => const ConfirmBookingPage(),

      },
    );
  }
}
