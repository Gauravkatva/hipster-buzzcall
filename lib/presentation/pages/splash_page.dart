import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Splash screen - First screen shown when app launches
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    // Wait for 2 seconds then navigate to login
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.buzzYellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BuzzCall Logo Icon (bee)
            Icon(
              Icons.settings_input_antenna,
              size: 120,
              color: AppTheme.buzzBlack,
            ),
            const SizedBox(height: 24),
            Text(
              'BuzzCall',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppTheme.buzzBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Connect Instantly',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.buzzBlack.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.buzzBlack),
            ),
          ],
        ),
      ),
    );
  }
}
