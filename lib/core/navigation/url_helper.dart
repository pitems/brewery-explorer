import 'package:url_launcher/url_launcher.dart';

abstract final class UrlHelper {
  static Future<bool> openWebsite(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
