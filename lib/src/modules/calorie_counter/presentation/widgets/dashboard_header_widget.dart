import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/widgets/header_widget.dart';
import '../application/calorie_cubit/calorie_cubit.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final Animation<double> loadingAnimation;

  const DashboardHeaderWidget({super.key, required this.loadingAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: loadingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - loadingAnimation.value)),
          child: Opacity(
            opacity: loadingAnimation.value,
            child: BlocBuilder<CalorieCubit, CalorieState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded:
                      (
                        isLoading,
                        isError,
                        errorMessage,
                        todayCalories,
                        todayMacros,
                        todayActivities,
                        weightHistory,
                        steps,
                        stepGoal,
                      ) {
                        return const HeaderWidget(avatarLink: null);
                      },
                  orElse: () => const HeaderWidget(avatarLink: null),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
