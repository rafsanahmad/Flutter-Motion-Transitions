/*
 * *
 *  * Created by Rafsan Ahmad on 11/5/21, 8:34 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/router/router.dart';
import 'package:flutter_motion_transitions/router/router_provider.dart';
import 'package:flutter_motion_transitions/transitions/fade_through_transition_switch.dart';
import 'package:flutter_motion_transitions/ui/reply_logo.dart';
import 'package:flutter_motion_transitions/ui/settings_bottom_sheet.dart';
import 'package:flutter_motion_transitions/ui/waterfall_notched_rectangle.dart';
import 'package:flutter_motion_transitions/utils/colors.dart';
import 'package:flutter_motion_transitions/utils/constants.dart';
import 'package:provider/provider.dart';

class AnimatedBottomAppBar extends StatelessWidget {
  const AnimatedBottomAppBar({
    required this.bottomAppBarController,
    required this.bottomAppBarCurve,
    required this.bottomDrawerVisible,
    required this.drawerController,
    required this.dropArrowCurve,
    required this.toggleBottomDrawerVisibility,
  });

  final AnimationController bottomAppBarController;
  final Animation<double> bottomAppBarCurve;
  final bool bottomDrawerVisible;
  final AnimationController drawerController;
  final Animation<double> dropArrowCurve;
  final VoidCallback toggleBottomDrawerVisibility;

  @override
  Widget build(BuildContext context) {
    var fadeOut = Tween<double>(begin: 1, end: -1).animate(
      drawerController.drive(CurveTween(curve: standardEasing)),
    );

    return Selector<EmailStore, bool>(
      selector: (context, emailStore) => emailStore.onMailView,
      builder: (context, onMailView, child) {
        bottomAppBarController.forward();

        return SizeTransition(
          sizeFactor: bottomAppBarCurve,
          axisAlignment: -1,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 2),
            child: BottomAppBar(
              shape: const WaterfallNotchedRectangle(),
              notchMargin: 6,
              child: Container(
                color: Colors.transparent,
                height: kToolbarHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: toggleBottomDrawerVisibility,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          RotationTransition(
                            turns: Tween(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(dropArrowCurve),
                            child: const Icon(
                              Icons.arrow_drop_up,
                              color: ReplyColors.white50,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const ReplyLogo(),
                          const SizedBox(width: 10),
                          FadeThroughTransitionSwitcher(
                            fillColor: Colors.transparent,
                            child: onMailView
                                ? const SizedBox(width: 48)
                                : FadeTransition(
                                    opacity: fadeOut,
                                    child: Selector<EmailStore, String>(
                                      selector: (context, emailStore) =>
                                          emailStore.currentlySelectedInbox,
                                      builder: (
                                        context,
                                        currentlySelectedInbox,
                                        child,
                                      ) {
                                        return Text(
                                          currentlySelectedInbox,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: ReplyColors.white50,
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: _BottomAppBarActionItems(
                          drawerController: drawerController,
                          drawerVisible: bottomDrawerVisible,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BottomAppBarActionItems extends StatelessWidget {
  const _BottomAppBarActionItems({
    required this.drawerController,
    required this.drawerVisible,
  });

  final AnimationController drawerController;
  final bool drawerVisible;

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailStore>(
      builder: (context, model, child) {
        final onMailView = model.onMailView;
        var radius = const Radius.circular(12);
        final modalBorder = BorderRadius.only(
          topRight: radius,
          topLeft: radius,
        );
        Color? starIconColor;

        if (onMailView) {
          var currentEmailStarred = false;

          if (model.emails[model.currentlySelectedInbox]!.isNotEmpty) {
            currentEmailStarred = model.isEmailStarred(
              model.emails[model.currentlySelectedInbox]!
                  .elementAt(model.currentlySelectedEmailId),
            );
          }

          starIconColor = currentEmailStarred
              ? Theme.of(context).colorScheme.secondary
              : ReplyColors.white50;
        }

        return FadeThroughTransitionSwitcher(
          fillColor: Colors.transparent,
          child: drawerVisible
              ? Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    color: ReplyColors.white50,
                    onPressed: () async {
                      drawerController.reverse();
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: modalBorder,
                        ),
                        builder: (context) => const SettingsBottomSheet(),
                      );
                    },
                  ),
                )
              : onMailView
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: ImageIcon(
                            const AssetImage(
                              '$iconAssetLocation/twotone_star.png',
                              package: assetsPackage,
                            ),
                            color: starIconColor,
                          ),
                          onPressed: () {
                            model.starEmail(
                              model.currentlySelectedInbox,
                              model.currentlySelectedEmailId,
                            );
                            if (model.currentlySelectedInbox == 'Starred') {
                              mobileMailNavKey.currentState!.pop();
                              model.currentlySelectedEmailId = -1;
                            }
                          },
                          color: ReplyColors.white50,
                        ),
                        IconButton(
                          icon: const ImageIcon(
                            AssetImage(
                              '$iconAssetLocation/twotone_delete.png',
                              package: assetsPackage,
                            ),
                          ),
                          onPressed: () {
                            model.deleteEmail(
                              model.currentlySelectedInbox,
                              model.currentlySelectedEmailId,
                            );

                            mobileMailNavKey.currentState!.pop();
                            model.currentlySelectedEmailId = -1;
                          },
                          color: ReplyColors.white50,
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                          color: ReplyColors.white50,
                        ),
                      ],
                    )
                  : Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        color: ReplyColors.white50,
                        onPressed: () {
                          Provider.of<RouterProvider>(
                            context,
                            listen: false,
                          ).routePath = const ReplySearchPath();
                        },
                      ),
                    ),
        );
      },
    );
  }
}
