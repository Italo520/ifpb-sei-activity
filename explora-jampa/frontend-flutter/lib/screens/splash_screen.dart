import 'package:explora_jampa/screens/login_screen.dart';
import 'package:explora_jampa/screens/signup_screen.dart';
import 'package:explora_jampa/theme/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBeXJ8HuV9tAqDklntoVJBKo7EUW10F-m9p9idfCGOiXOfn4dwpYvkOJygyIxSgDcUw1ljGghaXPQifx_WNjDN7KmnZQN5R7T_T5oWKrh1qB4wvMhQ7MpEcgAoGJ5xadZWW_U7ydicZGBXLb0F6irzVmicHlBaPHW5dMAHfjuVCUg_axQFMudGlr25jVuWLxt0o5Zqcujt0Wn8WAk19yNYWnABGEFqtVuyVsrmBoi0f0f9udb1tY7sL1V0DMFgp7ZE68kP0zlRt7Ok',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: AppColors.backgroundDark),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.backgroundDark.withOpacity(0.3),
                  AppColors.backgroundDark.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header
                  header(),
                  // Main Content
                  Expanded(
                    child: mainContent(context),
                  ),
                  // Footer
                  footer(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, color: AppColors.primary, size: 48),
          SizedBox(width: 12),
          Text(
            'Explora Jampa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sua Aventura em João Pessoa Começa Aqui.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w900,
            fontFamily: 'Plus Jakarta Sans',
            height: 1.2,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Descubra os segredos da cidade que abraça o sol. Complete missões, ganhe recompensas e explore Jampa como nunca antes.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        SizedBox(height: 32),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );
          },
          child: Text(
            'COMEÇAR AVENTURA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget footer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text(
          'Já tenho uma conta',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
