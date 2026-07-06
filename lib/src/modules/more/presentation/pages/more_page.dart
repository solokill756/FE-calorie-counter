import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../app/app_router.dart';
import '../application/more_cubit/more_cubit.dart';
import '../components/component.dart';

@RoutePage()
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoreView();
  }
}

class MoreView extends StatefulWidget {
  const MoreView({super.key});
  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  late bool _autoCreatePlanRecipes;

  @override
  void initState() {
    super.initState();
    _autoCreatePlanRecipes = Storage.autoCreatePlanRecipes;
  }

  void _confirmDeleteAccount(BuildContext context, MoreCubit cubit) {
    final theme = Theme.of(context);
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 10,
          shadowColor: Colors.black26,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          titlePadding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 14, 24, 4),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.red.shade50,
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red.shade700,
                  size: 26,
                ),
              ),
              const Gap(14),
              Expanded(
                child: Text(
                  'Delete account?',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: Colors.grey[900],
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your profile will be closed and you will be signed out. You can sign up again with the same email if you want.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: Colors.grey[700],
                ),
              ),
              const Gap(14),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: Colors.amber.shade900,
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          'This action cannot be undone from the app.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.amber.shade900,
                            fontWeight: FontWeight.w600,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      foregroundColor: Colors.grey[800],
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      cubit.deleteAccount();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<MoreCubit, MoreState>(
        listener: (context, state) {
          state.maybeWhen(
            logOutSuccess: () {
              AppDialogs.showSnackBar(
                message: 'Logged out successfully!',
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              );
              context.router.pushAndPopUntil(
                WelcomeRoute(),
                predicate: (route) => false,
              );
            },
            accountDeletedSuccess: () {
              AppDialogs.showSnackBar(
                message: 'Your account has been deleted.',
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              );
              context.router.pushAndPopUntil(
                WelcomeRoute(),
                predicate: (route) => false,
              );
            },
            logOutError: (message) {
              AppDialogs.showSnackBar(
                message: message,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              );
            },
            deleteAccountError: (message) {
              AppDialogs.showSnackBar(
                message: message,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              );
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20),
              // User Profile Section
              BlocBuilder<MoreCubit, MoreState>(
                buildWhen: (previous, current) => current.maybeMap(
                  loaded: (_) => true,
                  loading: (_) => true,
                  error: (_) => true,
                  initial: (_) => true,
                  orElse: () => false,
                ),
                builder: (context, state) {
                  final isWeightGainGoal = _isWeightGainGoal();
                  return state.maybeWhen(
                    loaded: (imageUser, nameUser, steakDays, weightLost) {
                      return MoreComponents.buildUserProfileSection(
                        context,
                        imageUser,
                        nameUser ?? 'Guest',
                        steakDays,
                        weightLost,
                        isWeightGainGoal: isWeightGainGoal,
                      );
                    },
                    loading: () => LoadingWidget(
                      color: Colors.grey[300]!,
                      message: 'Loading user profile...',
                    ),
                    error: (message) {
                      return MoreComponents.buildUserProfileSection(
                        context,
                        null,
                        'Guest',
                        0,
                        0,
                        isWeightGainGoal: isWeightGainGoal,
                      );
                    },
                    orElse: () {
                      return MoreComponents.buildUserProfileSection(
                        context,
                        null,
                        'Guest',
                        0,
                        0,
                        isWeightGainGoal: isWeightGainGoal,
                      );
                    },
                  );
                },
              ),
              const Gap(12),
              // Menu Items
              _buildMenuSection(context),
            ],
          ),
        ),
      ),
    );
  }

  bool _isWeightGainGoal() {
    final profile = readServerProfile();
    if (profile == null) return false;
    if (profile.currentWeightKg <= 0 || profile.goalWeightKg <= 0) {
      return false;
    }
    return profile.goalWeightKg > profile.currentWeightKg;
  }

  Widget _buildMenuSection(BuildContext context) {
    final cubit = context.read<MoreCubit>();
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
          InkWell(
            onTap: () {
              context.router.push(const UserProfileRoute());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.person_outline, color: Colors.grey[700], size: 20),
                  const Gap(16),
                  Expanded(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            height: 1,
            color: Colors.grey[200],
          ),
          InkWell(
            onTap: () async {
              await context.router.push(EditGoalRoute());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.flag_outlined, color: Colors.grey[700], size: 20),
                  const Gap(16),
                  Expanded(
                    child: Text(
                      'Goal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            height: 1,
            color: Colors.grey[200],
          ),
          InkWell(
            onTap: () {
              context.router.push(const ExerciseHomeRoute());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.fitness_center_outlined,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  const Gap(16),
                  Expanded(
                    child: Text(
                      'Exercise',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            height: 1,
            color: Colors.grey[200],
          ),
          InkWell(
            onTap: () {
              context.router.push(
                StapleFoodsRoute(availableFoods: const [], pantryOnly: true),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.kitchen_outlined,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  const Gap(16),
                  Expanded(
                    child: Text(
                      'Pantry',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            height: 1,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.auto_mode_outlined,
                  color: Colors.grey[700],
                  size: 20,
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto create plan recipes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[900],
                        ),
                      ),
                      const Gap(2),
                      Text(
                        'When off, generate manually from Pantry',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _autoCreatePlanRecipes,
                  onChanged: (value) async {
                    setState(() => _autoCreatePlanRecipes = value);
                    await Storage.setAutoCreatePlanRecipes(value);
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            height: 1,
            color: Colors.grey[200],
          ),
          BlocBuilder<MoreCubit, MoreState>(
            builder: (context, state) {
              final loggingOut = state.maybeWhen(
                logOutLoading: () => true,
                orElse: () => false,
              );
              final deleting = state.maybeWhen(
                deleteAccountLoading: () => true,
                orElse: () => false,
              );
              final busy = loggingOut || deleting;

              return InkWell(
                onTap: busy
                    ? null
                    : () => _confirmDeleteAccount(context, cubit),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: Colors.red[800],
                        size: 20,
                      ),
                      const Gap(16),
                      Expanded(
                        child: Text(
                          'Delete account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                      if (deleting) ...[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red[800]!,
                            ),
                          ),
                        ),
                      ] else ...[
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            height: 1,
            color: Colors.grey[200],
          ),
          BlocBuilder<MoreCubit, MoreState>(
            builder: (context, state) {
              final loggingOut = state.maybeWhen(
                logOutLoading: () => true,
                orElse: () => false,
              );
              final deleting = state.maybeWhen(
                deleteAccountLoading: () => true,
                orElse: () => false,
              );
              final busy = loggingOut || deleting;

              return InkWell(
                onTap: busy
                    ? null
                    : () async {
                        await cubit.logOut();
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red[600], size: 20),
                      const Gap(16),
                      Expanded(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red[600],
                          ),
                        ),
                      ),
                      if (loggingOut) ...[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red[600]!,
                            ),
                          ),
                        ),
                      ] else ...[
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
