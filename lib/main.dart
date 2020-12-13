import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:petland/modules/home/home_page.dart';
import 'package:petland/navigator.dart';
import 'package:petland/themes/dartTheme.dart';
import 'package:petland/themes/lightTheme.dart';
import 'package:petland/utils/app_internalization.dart';
import 'package:petland/utils/responsive.dart';
import 'package:sentry/sentry.dart';

final _sentry = SentryClient(
    dsn:
        "https://43006013b62342d59158fea27e020902@o396604.ingest.sentry.io/5538831");
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
    () => runApp(PetLand()),
    (error, stackTrace) async {
      await _sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );
}

Image splash = Image.asset(
  'assets/image/splash.png',
  fit: BoxFit.fill,
);

class PetLand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(splash.image, context);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Responsive.init(constraints, orientation);
        return GestureDetector(
          onTap: () {
            if (!FocusScope.of(context).hasPrimaryFocus) {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const AppInternalizationlegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('vi', 'VN'),
            ],
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            navigatorKey: navigatorKey,
            home: HomePage(),
          ),
        );
      });
    });
  }
}
