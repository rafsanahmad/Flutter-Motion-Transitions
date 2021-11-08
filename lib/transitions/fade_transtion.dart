/*
 * *
 *  * Created by Rafsan Ahmad on 11/8/21, 12:58 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughTransitionPageWrapper extends Page {
  const FadeThroughTransitionPageWrapper({
    required this.mailbox,
    required this.transitionKey,
  }) : super(key: transitionKey);

  final Widget mailbox;
  final ValueKey transitionKey;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return mailbox;
        });
  }
}
