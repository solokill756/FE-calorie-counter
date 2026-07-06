import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/hide_keyboard_widget.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../app/app_router.dart';
import '../application/cubit/auth_cubit.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterView();
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fonusNodePassword = FocusNode();
  final _fonusNodeEmail = FocusNode();
  bool _obscurePassword = true;

  Future<void> _submitRegistration() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'Please fill in all fields',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      AppDialogs.showSnackBar(
        message: 'Please enter a valid email address',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (password.length < 8) {
      AppDialogs.showSnackBar(
        message: 'Password must be at least 8 characters',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    await context.read<AuthCubit>().register(email: email, password: password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fonusNodeEmail.dispose();
    _fonusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return HideKeyboardOnTap(
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: scheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Sign Up',
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
              loading: () {
                context.showLoadingDialog(message: 'Registering...');
              },
              registered: (message) async {
                context.hideLoadingDialog();
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
              },
              error: (message) {
                context.hideLoadingDialog();
                AppDialogs.showErrorSnackBar(message: message);
              },
              orElse: () {},
            );
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 60.h),

                    Text(
                      'Welcome! Let\'s customize\nCalorie Counter for your goals.',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 40.h),

                    // Email Address Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _emailController,
                      focusNode: _fonusNodeEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) => FocusScope.of(
                        context,
                      ).requestFocus(_fonusNodePassword),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: scheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: scheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: scheme.primary, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Password Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _passwordController,
                      focusNode: _fonusNodePassword,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) => _fonusNodePassword.unfocus(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: scheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: scheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: scheme.primary, width: 2),
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

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitRegistration();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: scheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: scheme.onPrimary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.router.maybePop();
                            context.router.push(const LoginRoute());
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: scheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),

                    // Privacy Policy Text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: scheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(text: 'By signing up, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: scheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: scheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
