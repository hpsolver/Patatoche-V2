import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:patatoche_v2/helpers/shared_pref.dart';
import 'package:patatoche_v2/provider/base_provider.dart';
import 'package:patatoche_v2/routes.dart';
import '../models/option_model.dart';

class SettingsProvider extends BaseProvider {
  List<OptionModel> optionList = [
    OptionModel(
      icon: AssetsResource.icAccountSettings,
      title: 'account_settings',
    ),
    OptionModel(
      icon: AssetsResource.icChangePassword,
      title: 'change_password',
    ),
    OptionModel(icon: AssetsResource.icContactUs, title: 'contact_us'),
    OptionModel(
      icon: AssetsResource.icTermsAndConditions,
      title: 'terms_and_conditions',
    ),
    OptionModel(icon: AssetsResource.icLanguage, title: 'language'),
    OptionModel(icon: AssetsResource.icAboutApp, title: 'about_app'),
  ];

  void logout(BuildContext context) {
    SharedPref.prefs?.clear();
    context.go(AppPaths.getStarted);
  }
}
