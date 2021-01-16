import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:petland/share/import.dart';

Future<bool> showConfirmImageDialog(
    BuildContext context,String title, String message, String image) async {
  bool val = false;
  await showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
            image: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
            title: Text(
                    title,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
            description: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            entryAnimation: EntryAnimation.DEFAULT,
            onOkButtonPressed: () {
              val = true;
              Navigator.of(context).maybePop();
            },
          ));
  return val;
}
