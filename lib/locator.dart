import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:patatoche_v2/provider/account_settings_provider.dart';
import 'package:patatoche_v2/provider/activation_code_provider.dart';
import 'package:patatoche_v2/provider/add_spotify_playlist_provider.dart';
import 'package:patatoche_v2/provider/change_password_provider.dart';
import 'package:patatoche_v2/provider/contact_us_provider.dart';
import 'package:patatoche_v2/provider/create_memory_provider.dart';
import 'package:patatoche_v2/provider/dashboard_provider.dart';
import 'package:patatoche_v2/provider/forgot_provider.dart';
import 'package:patatoche_v2/provider/get_started_provider.dart';
import 'package:patatoche_v2/provider/home_provider.dart';
import 'package:patatoche_v2/provider/introduction_provider.dart';
import 'package:patatoche_v2/provider/language_provider.dart';
import 'package:patatoche_v2/provider/login_provider.dart';
import 'package:patatoche_v2/provider/membership_plan_provider.dart';
import 'package:patatoche_v2/provider/nfc_scan_view_provider.dart';
import 'package:patatoche_v2/provider/otp_provider.dart';
import 'package:patatoche_v2/provider/preview_provider.dart';
import 'package:patatoche_v2/provider/register_provider.dart';
import 'package:patatoche_v2/provider/reset_password_provider.dart';
import 'package:patatoche_v2/provider/settings_provider.dart';
import 'package:patatoche_v2/provider/shop_provider.dart';
import 'package:patatoche_v2/services/api.dart';
import 'package:patatoche_v2/services/interceptor.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => IntroductionProvider());
  locator.registerFactory(() => GetStartedProvider());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => OtpProvider());
  locator.registerFactory(() => ForgotProvider());
  locator.registerFactory(() => RegisterProvider());
  locator.registerFactory(() => DashboardProvider());
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => ShopProvider());
  locator.registerFactory(() => SettingsProvider());
  locator.registerFactory(() => AccountSettingsProvider());
  locator.registerFactory(() => ChangePasswordProvider());
  locator.registerFactory(() => ContactUsProvider());
  locator.registerFactory(() => LanguageProvider());
  locator.registerFactory(() => ResetPasswordProvider());
  locator.registerFactory(() => MembershipPlanProvider());
  locator.registerFactory(() => CreateMemoryProvider());
  locator.registerFactory(() => PreviewProvider());
  locator.registerFactory(() => NfcScanViewProvider());
  locator.registerFactory(() => ActivationCodeProvider());
  locator.registerFactory(() => AddSpotifyPlaylistProvider());

  locator.registerLazySingleton<Dio>(() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(AuthInterceptor());
    return dio;
  });
}
