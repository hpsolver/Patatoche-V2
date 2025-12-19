import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:patatoche_v2/provider/theme_provider.dart';
import 'package:patatoche_v2/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'constants/color_constants.dart';
import 'constants/dimensions_constants.dart';
import 'constants/string_constants.dart';
import 'helpers/custom_scroll_behavior.dart';
import 'helpers/secure_storage.dart';
import 'helpers/shared_pref.dart';
import 'helpers/theme_color.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  SharedPref.prefs = await SharedPreferences.getInstance();

  SecureStorage.secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(lightTheme)),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: Size(
        DimensionsConstants.screenWidth,
        DimensionsConstants.screenHeight,
      ),
      builder: (context, child) => GlobalLoaderOverlay(
        duration: Durations.medium4,
        reverseDuration: Durations.medium4,
        overlayColor: Colors.grey.withValues(alpha: 0.7),
        overlayWidgetBuilder: (_) {
          return Center(
            child: SpinKitCubeGrid(
              color: ColorConstants.primaryColor,
              size: 50.0,
              key: UniqueKey(),
            ),
          );
        },
        child: ToastificationWrapper(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: StringConstants.appName,
            theme: themeProvider.themeData,
            routerConfig: router,
            scrollBehavior: CustomScrollBehavior(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (context, child) {
              return SafeArea(
                bottom: true, // fixes Android bottom nav overlap
                top: false,
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
