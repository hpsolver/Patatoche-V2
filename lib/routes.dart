import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/view/account_settings_view.dart';
import 'package:patatoche_v2/view/change_password_view.dart';
import 'package:patatoche_v2/view/contact_us_view.dart';
import 'package:patatoche_v2/view/create_memory_view.dart';
import 'package:patatoche_v2/view/dashboard_view.dart';
import 'package:patatoche_v2/view/edit_memory_page.dart';
import 'package:patatoche_v2/view/forgot_password_view.dart';
import 'package:patatoche_v2/view/get_started_view.dart';
import 'package:patatoche_v2/view/introduction_view.dart';
import 'package:patatoche_v2/view/langauage_view.dart';
import 'package:patatoche_v2/view/login_view.dart';
import 'package:patatoche_v2/view/membership_plan_view.dart';
import 'package:patatoche_v2/view/preview_view.dart';
import 'package:patatoche_v2/view/register_view.dart';
import 'package:patatoche_v2/view/reset_password_view.dart';
import 'package:patatoche_v2/view/splash_view.dart';
import 'package:patatoche_v2/view/success_view.dart';
import 'package:patatoche_v2/view/verify_otp_view.dart';

final router = GoRouter(
  initialLocation: AppPaths.splash,
  routes: <RouteBase>[
    GoRoute(
      path: AppPaths.splash,
      name: AppPaths.splash,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SplashView());
      },
    ),
    GoRoute(
      path: AppPaths.introduction,
      name: AppPaths.introduction,
      pageBuilder: (context, state) {
        return const MaterialPage(child: IntroductionView());
      },
    ),
    GoRoute(
      path: AppPaths.dashboard,
      name: AppPaths.dashboard,
      pageBuilder: (context, state) {
        return const MaterialPage(child: DashboardView());
      },
    ),
    GoRoute(
      path: AppPaths.getStarted,
      name: AppPaths.getStarted,
      pageBuilder: (context, state) {
        return MaterialPage(child: GetStartedView());
      },
    ),
    GoRoute(
      path: AppPaths.login,
      name: AppPaths.login,
      pageBuilder: (context, state) {
        return MaterialPage(child: LoginView());
      },
    ),
    GoRoute(
      path: AppPaths.register,
      name: AppPaths.register,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: RegisterView(from: args?['from']));
      },
    ),
    GoRoute(
      path: AppPaths.verifyOtp,
      name: AppPaths.verifyOtp,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: VerifyOtpView(type: args?['type']));
      },
    ),
    GoRoute(
      path: AppPaths.forgotPassword,
      name: AppPaths.forgotPassword,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: ForgotPasswordView());
      },
    ),
    GoRoute(
      path: AppPaths.accountSettings,
      name: AppPaths.accountSettings,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: AccountSettingsView());
      },
    ),
    GoRoute(
      path: AppPaths.changePassword,
      name: AppPaths.changePassword,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: ChangePasswordView());
      },
    ),
    GoRoute(
      path: AppPaths.contactUs,
      name: AppPaths.contactUs,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: ContactUsView());
      },
    ),
    GoRoute(
      path: AppPaths.language,
      name: AppPaths.language,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: LanguageView());
      },
    ),

    GoRoute(
      path: AppPaths.resetPassword,
      name: AppPaths.resetPassword,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: ResetPasswordView());
      },
    ),
    GoRoute(
      path: AppPaths.membershipPlanView,
      name: AppPaths.membershipPlanView,
      pageBuilder: (context, state) {
        Map<String, dynamic>? args = state.extra as Map<String, dynamic>?;
        return MaterialPage(child: MembershipPlanView());
      },
    ),
    GoRoute(
      path: AppPaths.createMemory,
      name: AppPaths.createMemory,
      pageBuilder: (context, state) {
        return MaterialPage(child: CreateMemoryView());
      },
    ),
    GoRoute(
      path: AppPaths.preview,
      name: AppPaths.preview,
      pageBuilder: (context, state) {
        return MaterialPage(child: PreviewView());
      },
    ),
    GoRoute(
      path: AppPaths.editMemory,
      name: AppPaths.editMemory,
      pageBuilder: (context, state) {
        return MaterialPage(child: EditMemoryPage());
      },
    ),
    GoRoute(
      path: AppPaths.successView,
      name: AppPaths.successView,
      pageBuilder: (context, state) {
        return MaterialPage(child: SuccessView());
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(
          state.fullPath ??
              state.error?.toString() ??
              state.name ??
              "unknown error",
          textAlign: TextAlign.center,
        ),
      ),
    );
  },
);

class AppPaths {
  static const splash = '/splash';
  static const introduction = '/introduction';
  static const getStarted = '/getStarted';
  static const login = '/login';
  static const register = '/register';
  static const verifyOtp = '/verifyOtp';
  static const forgotPassword = '/forgotPassword';
  static const dashboard = '/dashboard';

  static const accountSettings = '/accountSettings';
  static const changePassword = '/changePassword';
  static const contactUs = '/contactUs';
  static const language = '/language';
  static const resetPassword = '/resetPassword';
  static const membershipPlanView = '/membershipPlanView';
  static const createMemory = '/createMemory';
  static const preview = '/preview';
  static const editMemory = '/editMemory';
  static const successView = '/successView';
}
