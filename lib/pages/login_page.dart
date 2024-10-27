import 'dart:async';

import 'package:bus_seat_booking_user/custom_widgets/divider_text.dart';
import 'package:bus_seat_booking_user/models/user_model.dart';
import 'package:bus_seat_booking_user/pages/confirm_booking_page.dart';
import 'package:bus_seat_booking_user/pages/registration_page.dart';
import 'package:bus_seat_booking_user/providers/firebase_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String errMsg = '';
@override
  void initState() {
    _emailController.text = 'golam.shakib.hosen@gmail.com';
    _passwordController.text = '123456';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: 'Email address',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide your email address';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        )),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: _loginUser,
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New User?', style: TextStyle(fontSize: 16.0)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegistrationPage.routeName);
                        },
                        child: const Text('REGISTER',
                            style: TextStyle(
                                fontSize: 16.0,
                                decoration: TextDecoration.underline)))
                  ],
                )),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0),
                child: DividerText(),
                ),
              const SizedBox(height: 10.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: OutlinedButton(
                    onPressed: _googleSignIn,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 30.0,
                          width: 30.0,
                        ),
                        const SizedBox(width: 10.0),
                        const Text('Google',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500))
                      ],
                    ),
                  )),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                    child: Text(
                  errMsg,
                  style: const TextStyle(fontSize: 16.0, color: Colors.red),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      EasyLoading.show(status: 'Please wait');
      try {
        await context.read<FirebaseAuthProvider>().loginUser(email, password);
        await context.read<FirebaseAuthProvider>().getUserInfo();
        Navigator.pushReplacementNamed(context, ConfirmBookingPage.routeName);
      } on FirebaseAuthException catch (error) {
        setState(() {
          errMsg = error.message!;
        });
        Timer(const Duration(seconds: 2), () {
          setState(() {
            errMsg = '';
          });
        });
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  void _googleSignIn() async {
    try {
      final credential =
          await context.read<FirebaseAuthProvider>().signInWithGoogle();
      EasyLoading.show(status: 'Please wait...');
      final userExits =
          await context.read<FirebaseAuthProvider>().doesUserExit();
      if (userExits) {
        EasyLoading.dismiss();
        await context.read<FirebaseAuthProvider>().getUserInfo();
        Navigator.pushReplacementNamed(context, ConfirmBookingPage.routeName);
      } else {
        EasyLoading.dismiss();
        final user = UserModel(
          id: credential.user!.uid,
          fullName: credential.user!.displayName ?? '',
          number: credential.user!.phoneNumber ?? '',
          email: credential.user!.email!,
          address: '',
        );
        await context.read<FirebaseAuthProvider>().saveNewUser(user);
        await context.read<FirebaseAuthProvider>().getUserInfo();
        Navigator.pushReplacementNamed(context, ConfirmBookingPage.routeName);
      }
    } on FirebaseAuthException catch (error) {
      errMsg = error.toString();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
