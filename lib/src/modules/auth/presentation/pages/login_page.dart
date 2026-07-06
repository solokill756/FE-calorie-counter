import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/hide_keyboard_widget.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:caloriecounter/src/core/data/local/storage.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../app/app_router.dart';
import '../application/cubit/auth_cubit.dart';
import 'forgot_password_page.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _focusNodePassword = FocusNode();
  final _focusNodeEmail = FocusNode();
  bool _obscurePassword = true;

  Future<void> _submitLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppDialogs.showErrorSnackBar(
        message: 'Please enter both email and password.',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      AppDialogs.showErrorSnackBar(
        message: 'Please enter a valid email address.',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    await context.read<AuthCubit>().login(email: email, password: password);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return HideKeyboardOnTap(
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: scheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Log In',
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: (message) {
                context.hideLoadingDialog();
                Future.delayed(const Duration(milliseconds: 300), () async {
                  if (!context.mounted) return;
                  AppDialogs.showSuccessSnackBar(message: message);
                  try {
                    final isComplete = Storage.isProfileComplete ?? false;
                    if (isComplete) {
                      await context.router.pushAndPopUntil(
                        const MainNavigationRoute(),
                        predicate: (route) => false,
                      );
                    } else {
                      await context.router.pushAndPopUntil(
                        const SignUpFlowRoute(),
                        predicate: (route) => false,
                      );
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    // Fallback navigation
                    final isComplete = Storage.isProfileComplete ?? false;
                    await Navigator.of(
                      context,
                    ).pushReplacementNamed(
                      isComplete ? '/main-navigation' : '/signup-flow',
                    );
                  }
                });
              },
              error: (message) {
                context.hideLoadingDialog();
                // Show error message
                Future.delayed(const Duration(milliseconds: 300), () async {
                  AppDialogs.showErrorSnackBar(message: message);
                });
              },
              loading: () {
                context.showLoadingDialog(
                  message: 'Signing up...',
                  type: LoadingType.dots,
                );
              },
              orElse: () {},
            );
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),

                      // Email Address Field
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _emailController,
                        focusNode: _focusNodeEmail,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) {
                          _focusNodePassword.requestFocus();
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: scheme.outlineVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: scheme.outlineVariant,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: scheme.primary,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Password Field
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        focusNode: _focusNodePassword,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: scheme.outlineVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: scheme.outlineVariant,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: scheme.primary,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: scheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Log In Button
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _submitLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: scheme.onPrimary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: scheme.primary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // OR Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: scheme.outlineVariant),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: scheme.outlineVariant),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Continue with Google
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: OutlinedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await context.read<AuthCubit>().loginGoogle();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: scheme.outlineVariant),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Continue with Apple
                      if (Platform.isIOS) ...[
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: OutlinedButton(
                            onPressed: () async {
                              await context.read<AuthCubit>().loginApple();
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: scheme.outlineVariant),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.apple,
                                  size: 20.sp,
                                  color: scheme.onSurface,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Continue with Apple',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: scheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      // Flexible spacer
                      Expanded(child: const SizedBox()),

                      // Privacy Text
                      Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Text(
                          'We will never post anything without your permission.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: scheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ), // Column
                ), // IntrinsicHeight
              ), // ConstrainedBox
            ), // SingleChildScrollView
          ), // SafeArea
        ), // BlocListener inside body
      ),
    ); // Scaffold return
  } // build method
}
