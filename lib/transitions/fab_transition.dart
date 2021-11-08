/*
 * *
 *  * Created by Rafsan Ahmad on 11/8/21, 2:33 AM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/pages/compose_page.dart';
import 'package:provider/provider.dart';

import 'fade_through_transition_switch.dart';

class FabTransitionWrapper extends StatelessWidget {
  static const double _mobileFabDimension = 56;
  static final fabKey = UniqueKey();

  const FabTransitionWrapper({required this.onMailView});

  final bool onMailView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const circleFabBorder = CircleBorder();

    final fabSwitcher = FadeThroughTransitionSwitcher(
      fillColor: Colors.transparent,
      child: onMailView
          ? Icon(
              Icons.reply_all,
              key: fabKey,
              color: Colors.black,
            )
          : const Icon(
              Icons.create,
              color: Colors.black,
            ),
    );
    final tooltip = onMailView ? 'Reply' : 'Compose';

    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return const ComposePage();
      },
      openColor: theme.cardColor,
      onClosed: (success) {
        Provider.of<EmailStore>(
          context,
          listen: false,
        ).onCompose = false;
      },
      closedShape: circleFabBorder,
      closedColor: theme.colorScheme.secondary,
      closedElevation: 6,
      closedBuilder: (context, openContainer) {
        return Tooltip(
          message: tooltip,
          child: InkWell(
            customBorder: circleFabBorder,
            onTap: () {
              Provider.of<EmailStore>(
                context,
                listen: false,
              ).onCompose = true;
              openContainer();
            },
            child: SizedBox(
              height: _mobileFabDimension,
              width: _mobileFabDimension,
              child: Center(
                child: fabSwitcher,
              ),
            ),
          ),
        );
      },
    );
  }
}
