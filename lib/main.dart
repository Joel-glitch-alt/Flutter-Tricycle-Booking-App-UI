import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tricycle_booking_app/Pages/callScreen.dart';
import 'package:tricycle_booking_app/Pages/forgotpassword.dart';
import 'package:tricycle_booking_app/Pages/landingPage.dart';
import 'package:tricycle_booking_app/Pages/loginPage.dart';
import 'package:tricycle_booking_app/Pages/orderRide.dart';
import 'package:tricycle_booking_app/Pages/riderChat.dart';
import 'package:tricycle_booking_app/Pages/signUp.dart';
import 'package:tricycle_booking_app/Pages/userProfile.dart';
import 'package:tricycle_booking_app/providers/auth_provider.dart';
import 'package:tricycle_booking_app/services/api_service.dart';
import 'package:tricycle_booking_app/services/auth_service.dart';
import 'package:tricycle_booking_app/services/storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final storageService = StorageService();
            final apiService =
                ApiService(storageService); // ← pass StorageService
            return AuthProvider(
              AuthService(apiService),
              storageService, // ← reuse same instance
            );
          },
        )
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        title: 'Tricycle Booking',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LandingPage(),
          '/LoginPage': (context) => LoginPage(),
          '/SignUpPage': (context) => SignUpPage(),
          '/ForgotPasswordScreen': (context) => const ForgotPasswordScreen(),
          '/OrderRide': (context) => const TricycleBookingPage(),
          '/CallScreen': (context) => const CallScreen(),
          '/RiderChat': (context) => const RiderChatScreen(),
          '/UserProfileScreen': (context) => UserProfileScreen(),
        },
      ),
    );
  }
}
