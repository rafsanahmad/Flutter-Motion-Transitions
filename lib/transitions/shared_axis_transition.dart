/*
 * *
 *  * Created by Rafsan Ahmad on 11/8/21, 2:31 AM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisTransitionPageWrapper extends Page {
  const SharedAxisTransitionPageWrapper(
      {required this.screen, required this.transitionKey})
      : super(key: transitionKey);

  final Widget screen;
  final ValueKey transitionKey;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            fillColor: Theme.of(context).cardColor,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        });
  }
}
