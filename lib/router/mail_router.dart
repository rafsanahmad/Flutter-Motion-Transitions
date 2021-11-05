/*
 * *
 *  * Created by Rafsan Ahmad on 11/5/21, 10:05 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';

import 'mail_view_router.dart';

class MailRouter extends StatelessWidget {
  const MailRouter({required this.drawerController});

  final AnimationController drawerController;

  @override
  Widget build(BuildContext context) {
    final RootBackButtonDispatcher backButtonDispatcher =
        Router.of(context).backButtonDispatcher as RootBackButtonDispatcher;

    return Router(
      routerDelegate:
          MailViewRouterDelegate(drawerController: drawerController),
      backButtonDispatcher: ChildBackButtonDispatcher(backButtonDispatcher)
        ..takePriority(),
    );
  }
}
