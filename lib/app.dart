/*
 * *
 *  * Created by Rafsan Ahmad on 11/1/21, 7:51 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/router/router.dart';
import 'package:flutter_motion_transitions/router/router_provider.dart';
import 'package:flutter_motion_transitions/utils/theme.dart';
import 'package:provider/provider.dart';

import 'model/email_store.dart';

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
                  darkTheme: buildReplyDarkTheme(context),
                  theme: buildReplyLightTheme(context));
            }));
  }
}
