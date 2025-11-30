import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'user_list_page.dart';
import 'video_call_page.dart';

/// Home page with bottom navigation
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const UserListPage(), const VideoCallPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppTheme.buzzWhite,
        indicatorColor: AppTheme.buzzYellow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Users',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_call_outlined),
            selectedIcon: Icon(Icons.video_call),
            label: 'Video Call',
          ),
        ],
      ),
    );
  }
}
