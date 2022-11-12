import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:touch_bar/touch_bar.dart';

import 'constants/colors.dart';
import 'constants/theme.dart';
import 'models/entries.dart';
import 'redux/appstate.dart';
import 'screens/init/init_screen.dart';
import 'services/locator.dart';
import 'utils/desktop_window.dart';
import 'utils/loggers.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogging();
  Loggers.mainLogger.info('Passwd initialized');

  if (Platform.isAndroid || Platform.isIOS) {
    initializeLocator();
  } else {
    await setupDesktopWindow();
    initializeLocator('desktop');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      setTouchBar(
        TouchBar(
          children: [
            TouchBarLabel(
              'Passwd.',
              textColor: primaryColor,
            ),
          ],
        ),
      );
    }

    return AsyncReduxProvider<AppState>.value(
      value: Store<AppState>(
        initialState: AppState(
          entries: Entries(entries: []),
          isSyncing: false,
          autofillLaunch: false,
          isLoggedIn: false,
        ),
      ),
      child: EzLocalizationBuilder(
        delegate: EzLocalizationDelegate(
          supportedLocales: [
            Locale('ru'), // Russian
            Locale('en'), // English
            Locale('hi'), // Hindi
            Locale('fr'), // French
            Locale('nl'), // Dutch
            Locale('pl'), // Polish
            Locale('de'), // German
            Locale('zh'), // Chinese
            Locale('pt_BR'), // Brazilian Portugese
          ],
        ),
        builder: (context, localizationDelegate) => MaterialApp(
          title: 'Passwd',
          localizationsDelegates: localizationDelegate.localizationDelegates,
          supportedLocales: localizationDelegate.supportedLocales,
          localeResolutionCallback:
              localizationDelegate.localeResolutionCallback,
          theme: appTheme,
          builder: (context, child) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: canvasColor,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
              ),
            );

            if (Platform.isMacOS) {
              final mediaQueryData = MediaQueryData.fromWindow(
                WidgetsBinding.instance.window,
              );

              final paddedMediaQueryData = mediaQueryData.copyWith(
                padding: mediaQueryData.padding.copyWith(
                  top: 20,
                ),
              );

              return MediaQuery(
                data: paddedMediaQueryData,
                child: child,
              );
            }

            return child;
          },
          debugShowCheckedModeBanner: false,
          // home: InitScreen(),
          routes: {
            '/': (context) => InitScreen(),
            '/autofill': (context) => InitScreen(
                  dispatchAutofill: true,
                ),
          },
        ),
      ),
    );
  }
}
