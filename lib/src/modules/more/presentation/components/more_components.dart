import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MoreComponents {
  // User Profile Section Widget
  static Widget buildUserProfileSection(
    BuildContext context,
    String? avatarLink,
    String username,
    int streakDays,
    double weightProgressKg, {
    required bool isWeightGainGoal,
  }) {
    final regressing = weightProgressKg < 0;
    final displayKg = weightProgressKg.abs();
    final progressPrefix = regressing ? '+ ' : '';
    final progressLabel = regressing
        ? (isWeightGainGoal ? 'kgs lost' : 'kgs gained')
        : (isWeightGainGoal ? 'kgs gained' : 'kgs lost');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Streak Section
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Streak',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Gap(4),
                Text(
                  streakDays.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'day',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // User Avatar Section
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4285F4),
                    shape: BoxShape.circle,
                  ),
                  child: avatarLink != null
                      ? ClipOval(
                          child: Image.network(
                            avatarLink,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              );
                            },
                          ),
                        )
                      : const Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const Gap(8),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Progress Section
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Gap(4),
                Text(
                  '$progressPrefix${displayKg.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  progressLabel,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Menu Item Widget
  static Widget buildMenuItem({
    required IconData icon,
    required String title,
    Color? iconColor,
    bool isNew = false,
    required VoidCallback onTap,
    bool showLastDivider = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Colors.grey[600], size: 20),
            const Gap(16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            if (isNew)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const Gap(8),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  // Divider Widget
  static Widget buildDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 56),
      height: 1,
      color: Colors.grey[200],
    );
  }

  // Menu Section Widget
  static Widget buildMenuSection(
    BuildContext context, {
    required VoidCallback onPremiumTap,
    required VoidCallback onProfileTap,
    required VoidCallback onIntermittentFastingTap,
    required VoidCallback onSleepTap,
    required VoidCallback onRecipeDiscoveryTap,
    required VoidCallback onWorkoutRoutinesTap,
    required VoidCallback onGoalsTap,
    required VoidCallback onProgressTap,
    required VoidCallback onWeeklyReportTap,
    required VoidCallback onNutritionTap,
    required VoidCallback onMealsTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          buildMenuItem(
            icon: Icons.star,
            title: 'Try Premium for Free',
            iconColor: Colors.orange,
            onTap: onPremiumTap,
          ),
          buildDivider(),
          buildMenuItem(
            icon: Icons.person_outline,
            title: 'My Profile',
            onTap: onProfileTap,
          ),
          buildDivider(),
          buildMenuItem(
            icon: Icons.access_time,
            title: 'Intermittent Fasting',
            onTap: onIntermittentFastingTap,
          ),
          buildDivider(),
          buildMenuItem(icon: Icons.bedtime, title: 'Sleep', onTap: onSleepTap),
          buildDivider(),
          buildMenuItem(
            icon: Icons.restaurant,
            title: 'Recipe Discovery',
            onTap: onRecipeDiscoveryTap,
          ),
          buildDivider(),
          buildMenuItem(
            icon: Icons.fitness_center,
            title: 'Workout Routines',
            onTap: onWorkoutRoutinesTap,
          ),
          buildDivider(),
          buildMenuItem(icon: Icons.flag, title: 'Goals', onTap: onGoalsTap),
          buildDivider(),
          buildMenuItem(
            icon: Icons.trending_up,
            title: 'Progress',
            onTap: onProgressTap,
          ),
          buildDivider(),
          buildMenuItem(
            icon: Icons.bar_chart,
            title: 'My Weekly Report',
            isNew: true,
            onTap: onWeeklyReportTap,
          ),
          buildDivider(),
          buildMenuItem(
            icon: Icons.apple,
            title: 'Nutrition',
            onTap: onNutritionTap,
          ),
          buildDivider(),
          buildMenuItem(
            icon: Icons.restaurant_menu,
            title: 'My Meals, Recipes & Foods',
            onTap: onMealsTap,
            showLastDivider: false,
          ),
        ],
      ),
    );
  }
}
