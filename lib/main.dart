import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart'; // ✅ Add this import
import 'package:tricycle_booking_app/Pages/callScreen.dart';
import 'package:tricycle_booking_app/Pages/forgotpassword.dart';
import 'package:tricycle_booking_app/Pages/landingPage.dart';
import 'package:tricycle_booking_app/Pages/loginPage.dart';
import 'package:tricycle_booking_app/Pages/orderRide.dart';
import 'package:tricycle_booking_app/Pages/riderChat.dart';
import 'package:tricycle_booking_app/Pages/signUp.dart';
import 'package:tricycle_booking_app/Pages/userProfile.dart';
import 'package:tricycle_booking_app/providers/auth_provider.dart';
import 'package:tricycle_booking_app/providers/booking_provider.dart';
import 'package:tricycle_booking_app/providers/driver_provider.dart';
import 'package:tricycle_booking_app/services/api_service.dart';
import 'package:tricycle_booking_app/services/auth_service.dart';
import 'package:tricycle_booking_app/services/storage_service.dart';
import 'package:tricycle_booking_app/Pages/availableDrivers.dart';
import 'package:tricycle_booking_app/Pages/splashScreen.dart';
import 'package:tricycle_booking_app/services/connectivity_service.dart';
import 'package:tricycle_booking_app/Pages/BookingConfirmed.dart'; // ✅ needed for navigation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectivityService _connectivityService = ConnectivityService();
  final AppLinks _appLinks = AppLinks(); // ✅ Moved inside the class

  @override
  void initState() {
    super.initState();
    _initDeepLinks(); // ✅ Start listening when app initializes
  }

  // ✅ Deep link listener is now properly inside the class
  void _initDeepLinks() {
    _appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme == 'tricycleapp' && uri.host == 'payment') {
        final reference = uri.queryParameters['reference'];
        if (reference != null && mounted) {
          // Navigate to BookingConfirmed or verify payment
          Navigator.pushNamed(context, '/BookingConfirmed');
        }
      }
    });
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final storageService = StorageService();
            final apiService = ApiService(storageService);
            return AuthProvider(AuthService(apiService), storageService);
          },
        ),
        ChangeNotifierProvider(create: (_) => DriverProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        title: 'Tricycle Booking',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/LandingPage': (context) => const LandingPage(),
          '/LoginPage': (context) => LoginPage(),
          '/SignUpPage': (context) => SignUpPage(),
          '/ForgotPasswordScreen': (context) => ForgotPasswordScreen(),
          '/OrderRide': (context) => const BookingScreen(),
          '/CallScreen': (context) => const CallScreen(),
          '/RiderChat': (context) => const RiderChatScreen(),
          '/UserProfileScreen': (context) => UserProfileScreen(),
          '/AvailableDrivers': (context) => AvailableDriversScreen(),
          '/BookingConfirmed': (context) =>
              const BookingConfirmedScreen(), // ✅ Add this
        },
        builder: (context, child) {
          _connectivityService.init(context);
          return child!;
        },
      ),
    );
  }
}
