import 'package:flutter/material.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'presentation/pages/video_call_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await di.initializeDependencies();

  runApp(const BuzzCallApp());
}

class BuzzCallApp extends StatelessWidget {
  const BuzzCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuzzCall',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}

// Home Page with Video Call Button
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BuzzCall'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_call,
                size: 100,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to BuzzCall!',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Start a video call with anyone',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VideoCallPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.video_call),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text('Start Video Call'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
