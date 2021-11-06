/*
 * *
 *  * Created by Rafsan Ahmad on 11/5/21, 8:45 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/pages/compose_page.dart';
import 'package:provider/provider.dart';

class ReplyFab extends StatefulWidget {
  const ReplyFab({this.extended = false});

  final bool extended;

  @override
  _ReplyFabState createState() => _ReplyFabState();
}

class _ReplyFabState extends State<ReplyFab>
    with SingleTickerProviderStateMixin {
  static const double _mobileFabDimension = 56;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const circleFabBorder = CircleBorder();

    return Selector<EmailStore, bool>(
      selector: (context, emailStore) => emailStore.onMailView,
      builder: (context, onMailView, child) {
        // TODO: Add Fade through transition between compose and reply FAB (Motion)
        final fabSwitcher = onMailView
            ? const Icon(
                Icons.reply_all,
                color: Colors.black,
              )
            : const Icon(
                Icons.create,
                color: Colors.black,
              );
        final tooltip = onMailView ? 'Reply' : 'Compose';

        // TODO: Add Container Transform from FAB to compose email page (Motion)
        return Material(
          color: theme.colorScheme.secondary,
          shape: circleFabBorder,
          child: Tooltip(
            message: tooltip,
            child: InkWell(
              customBorder: circleFabBorder,
              onTap: () {
                Provider.of<EmailStore>(
                  context,
                  listen: false,
                ).onCompose = true;

                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return const ComposePage();
                    },
                  ),
                );
              },
              child: SizedBox(
                height: _mobileFabDimension,
                width: _mobileFabDimension,
                child: Center(
                  child: fabSwitcher,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
