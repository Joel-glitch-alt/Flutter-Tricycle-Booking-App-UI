import 'package:flutter/material.dart';
import 'package:tricycle_booking_app/Pages/callScreen.dart';
import 'package:tricycle_booking_app/Pages/forgotpassword.dart';
import 'package:tricycle_booking_app/Pages/google.dart';
import 'package:tricycle_booking_app/Pages/landingPage.dart';
import 'package:tricycle_booking_app/Pages/loginPage.dart';
import 'package:tricycle_booking_app/Pages/orderRide.dart';
import 'package:tricycle_booking_app/Pages/paymentSelection.dart';
import 'package:tricycle_booking_app/Pages/riderChat.dart';
import 'package:tricycle_booking_app/Pages/signUp.dart';
import 'package:tricycle_booking_app/Pages/userProfile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: 'Tricycle Booking App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/LoginPage': (context) => const LoginPage(),
        '/SignUpPage': (context) => const SignUpPage(),
        '/ForgotPasswordScreen': (context) => const ForgotPasswordScreen(),
        '/OrderRide': (context) => const TricycleBookingPage(),
        '/CallScreen': (context) => const CallScreen(),
        //'/PaymentSelection': (context) => const PaymentSelectionScreen(),
        '/RiderChat': (context) => const RiderChatScreen(),
        //'/UserProfile': (context) => const UserProfileScreen(),
        '/UserProfileScreen': (context) => UserProfileScreen(),
      },
    );
  }
}
