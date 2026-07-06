import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/presentation/home_page.dart';
import '../more/presentation/pages/more_page.dart';
import '../progress/presentation/pages/progress_page.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const Placeholder(child: Text('Diary')),
    const Placeholder(child: Text('Add')),
    const ProgressPage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: const EdgeInsets.all(12),
        snakeViewColor: const Color(0xFF4285F4),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, size: 18),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book, size: 18),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plus, size: 24),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartLine, size: 18),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.ellipsis, size: 18),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
