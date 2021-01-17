import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/authentication/splash.dart';
import 'package:petland/modules/inbox/inbox_bloc.dart';
import 'package:petland/navigator.dart';
import 'package:petland/share/import.dart';
import 'package:petland/themes/lightTheme.dart';
import 'package:petland/utils/app_internalization.dart';
import 'package:sentry/sentry.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

final _sentry = SentryClient(
    dsn:
        "https://43006013b62342d59158fea27e020902@o396604.ingest.sentry.io/5538831");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(
    () => runApp(Petland()),
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

class Petland extends StatelessWidget {
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
          child: ThemeProvider(
            initTheme: lightTheme,
            child: Builder(builder: (context) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => AuthBloc.instance,
                  ),
                  ChangeNotifierProvider(
                    create: (context) => PetBloc.instance,
                  ),
                  ChangeNotifierProvider(
                    create: (context) => PostBloc.instance,
                  ),
                ],
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
                  theme: ThemeProvider.of(context),
                  navigatorKey: navigatorKey,
                  home: SplashPage(),
                ),
              );
            }),
          ),
        );
      });
    });
  }
}
