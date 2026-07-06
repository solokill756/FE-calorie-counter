import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';
import 'package:caloriecounter/src/modules/more/presentation/application/more_cubit/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../calorie_counter/presentation/pages/dashboard_page.dart';

import '../../../diary/presentation/pages/diary_page.dart';
import '../../../more/presentation/pages/more_page.dart';

import '../../../add/presentation/add_bottom_sheet.dart';
import '../../../../common/widgets/bottom_navigation_widget.dart';
import '../../../progress/presentation/pages/progress_page.dart';

@RoutePage()
class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigationView();
  }
}

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _currentIndex = 0;
  late final List<Widget?> _pages;
  bool _hasLoadedMoreData = false;

  @override
  void initState() {
    super.initState();
    _pages = List<Widget?>.filled(5, null);
    _ensurePage(0);
    if (Storage.userID != null) {
      unawaited(context.read<UserProfileCubit>().refresh());
    }
  }

  Widget _buildPage(int index) {
    return switch (index) {
      0 => DashboardPage(
        onNavigateToDiary: () => _navigateToTab(1),
        onNavigateToProgress: () => _navigateToTab(3),
      ),
      1 => const DiaryPage(),
      3 => const ProgressPage(), // No AppBar for bottom nav
      4 => const MorePage(),
      _ => const _PlaceholderPage(title: 'Add'),
    };
  }

  void _ensurePage(int index) {
    _pages[index] ??= _buildPage(index);
  }

  void _navigateToTab(int index) {
    _ensurePage(index);
    setState(() {
      _currentIndex = index;
    });
    if (index == 4) {
      _loadMoreDataOnce();
    }
  }

  void _loadMoreDataOnce() {
    if (_hasLoadedMoreData) return;
    _hasLoadedMoreData = true;
    context.read<MoreCubit>().loadMoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          for (var index = 0; index < _pages.length; index++)
            if (_pages[index] != null)
              Offstage(
                offstage: _currentIndex != index,
                child: TickerMode(
                  enabled: _currentIndex == index,
                  child: _pages[index]!,
                ),
              ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
      ),
    );
  }

  void _onNavigationTap(int index) {
    if (index == 2) {
      // Show Add bottom sheet instead of navigating
      AddBottomSheet.show(context);
    } else {
      _ensurePage(index);
      setState(() {
        _currentIndex = index;
      });
      if (index == 4) {
        _loadMoreDataOnce();
      }
    }
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Coming Soon!',
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
