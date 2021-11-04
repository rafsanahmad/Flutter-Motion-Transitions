/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 7:56 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/model/navigate_destination.dart';
import 'package:flutter_motion_transitions/utils/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _drawerController;
  late final AnimationController _dropArrowController;
  late final AnimationController _bottomAppBarController;
  late final Animation<double> _drawerCurve;
  late final Animation<double> _dropArrowCurve;
  late final Animation<double> _bottomAppBarCurve;

  final _bottomDrawerKey = GlobalKey(debugLabel: 'Bottom Drawer');
  final _navigationDestinations = const <Destination>[
    Destination(
      name: 'Inbox',
      icon: '$iconAssetLocation/twotone_inbox.png',
      index: 0,
    ),
    Destination(
      name: 'Starred',
      icon: '$iconAssetLocation/twotone_star.png',
      index: 1,
    ),
    Destination(
      name: 'Sent',
      icon: '$iconAssetLocation/twotone_send.png',
      index: 2,
    ),
    Destination(
      name: 'Trash',
      icon: '$iconAssetLocation/twotone_delete.png',
      index: 3,
    ),
    Destination(
      name: 'Spam',
      icon: '$iconAssetLocation/twotone_error.png',
      index: 4,
    ),
    Destination(
      name: 'Drafts',
      icon: '$iconAssetLocation/twotone_drafts.png',
      index: 5,
    ),
  ];

  final _folders = <String, String>{
    'Receipts': folderIconAssetLocation,
    'Pine Elementary': folderIconAssetLocation,
    'Taxes': folderIconAssetLocation,
    'Vacation': folderIconAssetLocation,
    'Mortgage': folderIconAssetLocation,
    'Freelance': folderIconAssetLocation,
  };

  @override
  void initState() {
    super.initState();

    _drawerController = AnimationController(
      duration: kAnimationDuration,
      value: 0,
      vsync: this,
    )..addListener(() {
        if (_drawerController.status == AnimationStatus.dismissed &&
            _drawerController.value == 0) {
          Provider.of<EmailStore>(
            context,
            listen: false,
          ).bottomDrawerVisible = false;
        }

        if (_drawerController.value < 0.01) {
          setState(() {
            //Reload state when drawer is at its smallest to toggle visibility
            //If state is reloaded before this drawer closes abruptly instead
            //of animating.
          });
        }
      });

    _dropArrowController = AnimationController(
      duration: kAnimationDuration,
      vsync: this,
    );

    _bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    );

    _drawerCurve = CurvedAnimation(
      parent: _drawerController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _dropArrowCurve = CurvedAnimation(
      parent: _dropArrowController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _bottomAppBarCurve = CurvedAnimation(
      parent: _bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _dropArrowController.dispose();
    _bottomAppBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
