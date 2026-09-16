import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  // Relative paths (e.g. the CV in /web) resolve against the page's base URL,
  // so they keep working when the site is served from a sub-path.
  final uri = Uri.parse(url).hasScheme ? Uri.parse(url) : Uri.base.resolve(url);
  await launchUrl(uri, webOnlyWindowName: '_blank');
}
