import 'package:bus_seat_booking_user/pages/booking_successful_page.dart';
import 'package:bus_seat_booking_user/pages/confirm_booking_page.dart';
import 'package:bus_seat_booking_user/pages/edit_profile_page.dart';
import 'package:bus_seat_booking_user/pages/launcher_page.dart';
import 'package:bus_seat_booking_user/pages/login_page.dart';
import 'package:bus_seat_booking_user/pages/my_booking_page.dart';
import 'package:bus_seat_booking_user/pages/my_profile_page.dart';
import 'package:bus_seat_booking_user/pages/registration_page.dart';
import 'package:bus_seat_booking_user/pages/schedule_page.dart';
import 'package:bus_seat_booking_user/pages/search_page.dart';
import 'package:bus_seat_booking_user/pages/seat_plan_page.dart';
import 'package:bus_seat_booking_user/providers/booking_provider.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_user/providers/seat_plan_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegistrationPage.routeName: (context) => const RegistrationPage(),
        SchedulePage.routeName: (context) => const SchedulePage(),
        SearchPage.routeName: (context) => const SearchPage(),
        SeatPlanPage.routeName: (context) => const SeatPlanPage(),
        ConfirmBookingPage.routeName: (context) => const ConfirmBookingPage(),
        BookingSuccessfulPage.routeName: (context) => const BookingSuccessfulPage(),
        MyProfilePage.routeName: (context) => const MyProfilePage(),
        MyBookingPage.routeName: (context) => const MyBookingPage(),
        EditProfilePage.routeName: (context) => const EditProfilePage(),
      },
    );
  }
}
