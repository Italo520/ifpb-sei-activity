import 'package:explora_jampa/screens/home_screen.dart';
import 'package:explora_jampa/screens/splash_screen.dart';
import 'package:explora_jampa/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData && snapshot.data != null) {
          return HomeScreen();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
