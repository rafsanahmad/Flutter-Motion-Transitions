/*
 * *
 *  * Created by Rafsan Ahmad on 11/5/21, 8:45 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/transitions/fab_transition.dart';
import 'package:provider/provider.dart';

class ReplyFab extends StatefulWidget {
  const ReplyFab({this.extended = false});

  final bool extended;

  @override
  _ReplyFabState createState() => _ReplyFabState();
}

class _ReplyFabState extends State<ReplyFab>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Selector<EmailStore, bool>(
      selector: (context, emailStore) => emailStore.onMailView,
      builder: (context, onMailView, child) {
        return FabTransitionWrapper(onMailView: onMailView);
      },
    );
  }
}
