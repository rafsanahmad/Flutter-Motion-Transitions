/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 7:56 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  
 */
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/model/navigate_destination.dart';
import 'package:flutter_motion_transitions/router/mail_router.dart';
import 'package:flutter_motion_transitions/ui/animated_bottom_app_bar.dart';
import 'package:flutter_motion_transitions/ui/bottom_drawer/bottom_drawer.dart';
import 'package:flutter_motion_transitions/ui/reply_fab.dart';
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

  bool get _bottomDrawerVisible {
    final status = _drawerController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBottomDrawerVisibility() {
    if (_drawerController.value < 0.4) {
      Provider.of<EmailStore>(
        context,
        listen: false,
      ).bottomDrawerVisible = true;
      _drawerController.animateTo(0.4, curve: standardEasing);
      _dropArrowController.animateTo(0.35, curve: standardEasing);
      return;
    }

    _dropArrowController.forward();
    _drawerController.fling(
      velocity: _bottomDrawerVisible ? -kFlingVelocity : kFlingVelocity,
    );
  }

  double get _bottomDrawerHeight {
    final renderBox =
        _bottomDrawerKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
      bottomNavigationBar: AnimatedBottomAppBar(
        bottomAppBarController: _bottomAppBarController,
        bottomAppBarCurve: _bottomAppBarCurve,
        bottomDrawerVisible: _bottomDrawerVisible,
        drawerController: _drawerController,
        dropArrowCurve: _dropArrowCurve,
        toggleBottomDrawerVisibility: _toggleBottomDrawerVisibility,
      ),
      floatingActionButton: _bottomDrawerVisible
          ? null
          : const Padding(
              padding: EdgeInsetsDirectional.only(bottom: 8),
              child: ReplyFab(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final drawerSize = constraints.biggest;
    final drawerTop = drawerSize.height;
    final ValueChanged<String> updateMailbox = _onDestinationSelected;

    final drawerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, drawerTop, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_drawerCurve);

    return Stack(
      clipBehavior: Clip.none,
      key: _bottomDrawerKey,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: MailRouter(
            drawerController: _drawerController,
          ),
        ),
        GestureDetector(
          onTap: () {
            _drawerController.reverse();
            _dropArrowController.reverse();
          },
          child: Visibility(
            maintainAnimation: true,
            maintainState: true,
            visible: _bottomDrawerVisible,
            child: FadeTransition(
              opacity: _drawerCurve,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
              ),
            ),
          ),
        ),
        PositionedTransition(
          rect: drawerAnimation,
          child: Visibility(
            visible: _bottomDrawerVisible,
            child: BottomDrawer(
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              leading: _BottomDrawerDestinations(
                destinations: _navigationDestinations,
                drawerController: _drawerController,
                dropArrowController: _dropArrowController,
                onItemTapped: updateMailbox,
              ),
              trailing: _BottomDrawerFolderSection(folders: _folders),
            ),
          ),
        ),
      ],
    );
  }

  /*Drawer Functions*/

  void _onDestinationSelected(String destination) {
    var emailStore = Provider.of<EmailStore>(
      context,
      listen: false,
    );

    if (emailStore.onMailView) {
      emailStore.currentlySelectedEmailId = -1;
    }

    if (emailStore.currentlySelectedInbox != destination) {
      emailStore.currentlySelectedInbox = destination;
    }

    setState(() {});
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _drawerController.value -= details.primaryDelta! / _bottomDrawerHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_drawerController.isAnimating ||
        _drawerController.status == AnimationStatus.completed) {
      return;
    }

    final flingVelocity =
        details.velocity.pixelsPerSecond.dy / _bottomDrawerHeight;

    if (flingVelocity < 0.0) {
      _drawerController.fling(
        velocity: math.max(kFlingVelocity, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      _dropArrowController.forward();
      _drawerController.fling(
        velocity: math.min(-kFlingVelocity, -flingVelocity),
      );
    } else {
      if (_drawerController.value < 0.6) {
        _dropArrowController.forward();
      }
      _drawerController.fling(
        velocity:
            _drawerController.value < 0.6 ? -kFlingVelocity : kFlingVelocity,
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        switch (notification.direction) {
          case ScrollDirection.forward:
            _bottomAppBarController.forward();
            break;
          case ScrollDirection.reverse:
            _bottomAppBarController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }
}
