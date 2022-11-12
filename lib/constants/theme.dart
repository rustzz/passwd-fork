import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

import 'colors.dart';

// Application's text theme
final textTheme = TextTheme(
  headline1: GoogleFonts.openSans(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.openSans(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.openSans(
    fontSize: 48,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.openSans(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.openSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.openSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

// Application's pageTransitionTheme
final pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    ),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.windows: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    ),
    TargetPlatform.linux: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    ),
    TargetPlatform.macOS: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    ),
    TargetPlatform.fuchsia: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    ),
  },
);

// Application's appBarTheme
final appBarTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
);

// Application's dialogTheme
final dialogTheme = DialogTheme(
  backgroundColor: '#181818'.toColor(),
);

// Application's complete theme
final appTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  accentColor: primaryColor,
  iconTheme: IconThemeData(
    color: ThemeData.dark().iconTheme.color,
  ),
  textTheme: textTheme,
  visualDensity: VisualDensity.standard,
  pageTransitionsTheme: pageTransitionsTheme,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  appBarTheme: appBarTheme.copyWith(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(
      color: ThemeData.dark().textTheme.bodyText1.color,
    ),
  ),
  canvasColor: canvasColor,
  scaffoldBackgroundColor: canvasColor,
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
        backgroundColor: canvasColor,
        unselectedIconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.92),
        ),
        showUnselectedLabels: false,
        elevation: 4,
      ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor.withOpacity(0.4),
    selectionHandleColor: primaryColor,
  ),
  buttonColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      )),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          return primaryColorHovered;
        }

        return primaryColor;
      }),
      overlayColor: MaterialStateProperty.all(
        primaryColor.withOpacity(0.24),
      ),
    ),
  ),
  splashColor: primaryColor.withOpacity(0.24),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      )),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.all(
        primaryColor.withOpacity(0.24),
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    highlightColor: primaryColor.withOpacity(0.24),
  ),
  backgroundColor: canvasColor,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 14,
      letterSpacing: 1.5,
    ),
  ),
  dialogTheme: dialogTheme,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.white.withOpacity(0.025),
    unselectedIconTheme: IconThemeData(
      color: Colors.white.withOpacity(0.92),
    ),
    selectedIconTheme: IconThemeData(
      color: primaryColor,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: Colors.white.withOpacity(0.92),
    ),
    selectedLabelTextStyle: TextStyle(
      color: primaryColor,
    ),
  ),
);
