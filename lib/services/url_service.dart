import 'package:cash_app/constants/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunch {
  _message(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Something is wrong!'),
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ),
    );
  }

  Future<void> launchTelegram(String url, BuildContext context) async {
    if (await canLaunch("https://t.me/" + url)) {
      await launch(url);
    } else {
      _message(context);
    }
  }

  Future<void> launchPhone(String number, BuildContext context) async {
    if (await canLaunch("tel:" + number)) {
      await launch("tel:" + number);
    } else {
      _message(context);
    }
  }

  Future<void> launchWeb(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _message(context);
    }
  }
}
