import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todos/presentation/page/main/index.dart';
import 'package:todos/presentation/utils/index.dart';
import 'app_injector.dart';
import 'presentation/app/index.dart';
import 'presentation/base/index.dart';
import 'presentation/resources/index.dart';

late ApplicationBloc appBloc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AppLocalizations.shared.reloadLanguageBundle(languageCode: 'en');
  await initInjector();
  appBloc = ApplicationBloc();
  runApp(
    BlocProvider<ApplicationBloc>(
      create: (BuildContext context) => appBloc,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appBloc.dispatchEvent(AppLaunched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent),
      ),
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: BlocBuilder<ApplicationBloc, BaseState>(
          bloc: appBloc,
          builder: (context, state) {
            return const MainPage(
              pageTag: PageTag.main,
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
