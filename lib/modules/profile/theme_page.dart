import 'package:petland/share/import.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:petland/themes/dartTheme.dart';
import 'package:petland/themes/lightTheme.dart';
import 'package:petland/utils/spref.dart';

class ThemePage extends StatefulWidget {
  static Future navigate() {
    return navigatorKey.currentState.push(pageBuilder(ThemePage()));
  }

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isLightMode;

  @override
  void initState() {
    SPref.instance.get('isLightMode').then((value) async {
      if (!mounted) await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        isLightMode = value ?? true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: MyAppBar(
          automaticallyImplyLeading: true,
          title: 'Theme',
        ),
        body: Container(
          child: Center(
            child: Transform.scale(
              scale: 2.5,
              child: ThemeSwitcher(
                builder: (context2) => Switch(
                  value: isLightMode,
                  activeColor: ptPrimaryColor(context),
                  onChanged: (val) {
                    ThemeData theme = val ? lightTheme : darkTheme;
                    ThemeSwitcher.of(context2).changeTheme(
                        theme: theme, reverseAnimation: false // default: false
                        );
                    setState(() {
                      isLightMode = val;
                    });
                    SPref.instance.setBool('isLightMode', val);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
