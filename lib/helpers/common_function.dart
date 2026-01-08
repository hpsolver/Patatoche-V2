
import 'dart:io';
import 'dart:math' as math;

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  static String extractLastIdFromUrl(String url) {
    if (url.contains('?')) {
      return url.split('?').last; // everything after '?'
    } else {
      Uri uri = Uri.parse('https://$url'); // add scheme to parse
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    }
  }

  static Future<String?> generateHighQualityThumbnail(String videoPath) async {
    final dir = await getTemporaryDirectory();
    final filename = DateTime.now().millisecondsSinceEpoch;
    final thumbPath = '${dir.path}/thumb_$filename.jpg';

    final command =
        "-ss 00:00:00.2 -i '$videoPath' -vframes 1 -q:v 2 '$thumbPath'";
    await FFmpegKit.execute(command);

    return File(thumbPath).existsSync() ? thumbPath : null;
  }

  static Future<String> getXFileSizeFormatted(XFile file, {int decimals = 2}) async {
    final bytes = await file.length();

    if (bytes <= 0) return "0 B";

    const units = ["B", "KB", "MB", "GB", "TB"];
    final index = (math.log(bytes) / math.log(1024)).floor();

    return "${(bytes / math.pow(1024, index)).toStringAsFixed(decimals)} ${units[index]}";
  }

  static bool isValidSpotifyUrl(String url) {
    // regex covers typical Spotify open URLs
    final pattern =
        r'^(https?:\/\/)?(open\.spotify\.com\/(track|album|playlist|artist|show|episode)\/[A-Za-z0-9]+)(\?.*)?$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(url.trim());
  }
}
