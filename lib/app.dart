/*
 * *
 *  * Created by Rafsan Ahmad on 11/1/21, 7:51 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/router/router.dart';
import 'package:flutter_motion_transitions/router/router_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/email_store.dart';
import 'utils/colors.dart';

class EmailApp extends StatefulWidget {
  const EmailApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailAppState();
}

class _EmailAppState extends State<EmailApp> {
  final RouterProvider _replyState = RouterProvider(const ReplyHomePath());

  final ReplyRouteInformationParser _routeInformationParser =
      ReplyRouteInformationParser();

  late final ReplyRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = ReplyRouterDelegate(replyState: _replyState);
  }

  @override
  void dispose() {
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<EmailStore>.value(value: EmailStore()),
        ],
        child: Selector<EmailStore, ThemeMode>(
            selector: (context, emailStore) => emailStore.themeMode,
            builder: (context, thememode, child) {
              return MaterialApp.router(
                  routeInformationParser: _routeInformationParser,
                  routerDelegate: _routerDelegate,
                  themeMode: thememode,
                  title: 'Reply',
                  darkTheme: _buildReplyDarkTheme(context),
                  theme: _buildReplyLightTheme(context));
            }));
  }
}

ThemeData _buildReplyLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    bottomAppBarColor: ReplyColors.blue700,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ReplyColors.blue700,
      modalBackgroundColor: Colors.white.withOpacity(0.7),
    ),
    cardColor: ReplyColors.white50,
    chipTheme: _buildChipTheme(
      ReplyColors.blue700,
      ReplyColors.lightChipBackground,
      Brightness.light,
    ),
    colorScheme: const ColorScheme.light(
      primary: ReplyColors.blue700,
      primaryVariant: ReplyColors.blue800,
      secondary: ReplyColors.orange500,
      secondaryVariant: ReplyColors.orange400,
      surface: ReplyColors.white50,
      error: ReplyColors.red400,
      onPrimary: ReplyColors.white50,
      onSecondary: ReplyColors.black900,
      onBackground: ReplyColors.black900,
      onSurface: ReplyColors.black900,
      onError: ReplyColors.black900,
      background: ReplyColors.blue50,
    ),
    textTheme: _buildReplyLightTextTheme(base.textTheme),
    scaffoldBackgroundColor: ReplyColors.blue50,
  );
}

ThemeData _buildReplyDarkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    bottomAppBarColor: ReplyColors.darkBottomAppBarBackground,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ReplyColors.darkDrawerBackground,
      modalBackgroundColor: Colors.black.withOpacity(0.7),
    ),
    cardColor: ReplyColors.darkCardBackground,
    chipTheme: _buildChipTheme(
      ReplyColors.blue200,
      ReplyColors.darkChipBackground,
      Brightness.dark,
    ),
    colorScheme: const ColorScheme.dark(
      primary: ReplyColors.blue200,
      primaryVariant: ReplyColors.blue300,
      secondary: ReplyColors.orange300,
      secondaryVariant: ReplyColors.orange300,
      surface: ReplyColors.black800,
      error: ReplyColors.red200,
      onPrimary: ReplyColors.black900,
      onSecondary: ReplyColors.black900,
      onBackground: ReplyColors.white50,
      onSurface: ReplyColors.white50,
      onError: ReplyColors.black900,
      background: ReplyColors.black900,
    ),
    textTheme: _buildReplyDarkTextTheme(base.textTheme),
    scaffoldBackgroundColor: ReplyColors.black900,
  );
}

ChipThemeData _buildChipTheme(
  Color primaryColor,
  Color chipBackground,
  Brightness brightness,
) {
  return ChipThemeData(
    backgroundColor: primaryColor.withOpacity(0.12),
    disabledColor: primaryColor.withOpacity(0.87),
    selectedColor: primaryColor.withOpacity(0.05),
    secondarySelectedColor: chipBackground,
    padding: const EdgeInsets.all(4),
    shape: const StadiumBorder(),
    labelStyle: GoogleFonts.workSansTextTheme().bodyText2!.copyWith(
          color: brightness == Brightness.dark
              ? ReplyColors.white50
              : ReplyColors.black900,
        ),
    secondaryLabelStyle: GoogleFonts.workSansTextTheme().bodyText2!,
    brightness: brightness,
  );
}

TextTheme _buildReplyLightTextTheme(TextTheme base) {
  return base.copyWith(
    headline4: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: ReplyColors.black900,
    ),
    headline5: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.27,
      color: ReplyColors.black900,
    ),
    headline6: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.18,
      color: ReplyColors.black900,
    ),
    subtitle2: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.04,
      color: ReplyColors.black900,
    ),
    bodyText1: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: ReplyColors.black900,
    ),
    bodyText2: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.05,
      color: ReplyColors.black900,
    ),
    caption: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: ReplyColors.black900,
    ),
  );
}

TextTheme _buildReplyDarkTextTheme(TextTheme base) {
  return base.copyWith(
    headline4: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: ReplyColors.white50,
    ),
    headline5: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.27,
      color: ReplyColors.white50,
    ),
    headline6: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.18,
      color: ReplyColors.white50,
    ),
    subtitle2: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.04,
      color: ReplyColors.white50,
    ),
    bodyText1: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: ReplyColors.white50,
    ),
    bodyText2: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.05,
      color: ReplyColors.white50,
    ),
    caption: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: ReplyColors.white50,
    ),
  );
}
