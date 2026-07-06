import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class ProgressComponents {
  
  // Combined Steps Header with Period Selector
  static Widget buildStepsHeaderWithPeriod(
    BuildContext context, {
    required String selectedPeriod,
    required Function(String) onPeriodChanged,
  }) {
    final periods = ['1 Week', '1 Month', '3 Months', '1 Year'];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Steps icon and text
          Row(
            children: [
              Icon(
                FontAwesomeIcons.shoePrints,
                size: 20,
                color: Colors.blue,
              ),
              const Gap(8),
              const Text(
                'Steps',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Period dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: selectedPeriod,
              underline: const SizedBox(),
              icon: Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              items: periods.map((String period) {
                return DropdownMenuItem<String>(
                  value: period,
                  child: Text(period),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onPeriodChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Simple Steps Header (không có Goals toggle)
  static Widget buildStepsHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.shoePrints,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const Gap(8),
                  const Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.bullseye,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                  const Gap(8),
                  Text(
                    '1 Month',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header với toggle buttons (Steps/Goals)
  static Widget buildProgressHeader(
    BuildContext context, {
    required bool isStepsSelected,
    required VoidCallback onStepsTap,
    required VoidCallback onGoalsTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onStepsTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isStepsSelected ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isStepsSelected ? Colors.blue : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.shoePrints,
                      size: 16,
                      color: isStepsSelected ? Colors.white : Colors.grey.shade600,
                    ),
                    const Gap(8),
                    Text(
                      'Steps',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isStepsSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: GestureDetector(
              onTap: onGoalsTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isStepsSelected ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: !isStepsSelected ? Colors.blue : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.bullseye,
                      size: 16,
                      color: !isStepsSelected ? Colors.white : Colors.grey.shade600,
                    ),
                    const Gap(8),
                    Text(
                      'Goals',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: !isStepsSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Period selector (1 Month dropdown)
  static Widget buildPeriodSelector(
    BuildContext context, {
    required String selectedPeriod,
    required ValueChanged<String> onPeriodChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: selectedPeriod,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down, size: 20),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              items: [
                '1 Month',
                '3 Months',
                '6 Months',
                '1 Year',
              ].map((String period) {
                return DropdownMenuItem<String>(
                  value: period,
                  child: Text(period),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onPeriodChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Stats cards (Average, Best, Total)
  static Widget buildStatsCards({
    required double averageValue,
    required double bestValue,
    required double totalValue,
    required String unit,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              title: 'AVERAGE',
              value: averageValue.toInt().toString(),
              unit: unit,
            ),
          ),
          const Gap(16),
          Expanded(
            child: _buildStatCard(
              title: 'BEST',
              value: bestValue.toInt().toString(),
              unit: unit,
            ),
          ),
          const Gap(16),
          Expanded(
            child: _buildStatCard(
              title: 'TOTAL',
              value: totalValue.toInt().toString(),
              unit: unit,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatCard({
    required String title,
    required String value,
    required String unit,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Gap(4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // No Data Available section
  static Widget buildNoDataSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.chartLine,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const Gap(16),
          Text(
            'No Data Available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const Gap(8),
          Text(
            'Start tracking your progress to see data here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Entries section
  static Widget buildEntriesSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entries',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.calendar,
                  size: 32,
                  color: Colors.grey.shade400,
                ),
                const Gap(12),
                Text(
                  'No previous measurements.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Floating Action Button
  static Widget buildFloatingActionButton({
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
