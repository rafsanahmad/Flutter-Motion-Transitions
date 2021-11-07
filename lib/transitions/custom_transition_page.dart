/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 7:47 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/widgets.dart';

class CustomTransitionPage extends Page {
  final Widget screen;
  final ValueKey transitionKey;

  const CustomTransitionPage(
      {required this.screen, required this.transitionKey})
      : super(key: transitionKey);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        });
  }
}