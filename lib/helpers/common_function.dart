import 'package:url_launcher/url_launcher.dart';

class CommonFunction {
  static Future<void> openUrl(String url, {LaunchMode? launchMode}) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: launchMode ?? LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
