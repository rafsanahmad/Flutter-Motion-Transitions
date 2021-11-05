/*
 * *
 *  * Created by Rafsan Ahmad on 11/6/21, 12:52 AM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/model/navigate_destination.dart';
import 'package:flutter_motion_transitions/utils/colors.dart';
import 'package:flutter_motion_transitions/utils/constants.dart';
import 'package:provider/provider.dart';

class BottomDrawerDestinations extends StatelessWidget {
  const BottomDrawerDestinations({
    required this.destinations,
    required this.drawerController,
    required this.dropArrowController,
    required this.onItemTapped,
  });

  final List<Destination> destinations;
  final AnimationController drawerController;
  final AnimationController dropArrowController;
  final ValueChanged<String> onItemTapped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        for (var destination in destinations)
          InkWell(
            onTap: () {
              onItemTapped(destination.name);
              drawerController.reverse();
              dropArrowController.forward();
            },
            child: Selector<EmailStore, String>(
              selector: (context, emailStore) =>
                  emailStore.currentlySelectedInbox,
              builder: (context, currentlySelectedInbox, child) {
                return ListTile(
                  leading: ImageIcon(
                    AssetImage(
                      destination.icon,
                      package: assetsPackage,
                    ),
                    color: destination.name == currentlySelectedInbox
                        ? theme.colorScheme.secondary
                        : ReplyColors.white50.withOpacity(0.64),
                  ),
                  title: Text(
                    destination.name,
                    style: theme.textTheme.bodyText2!.copyWith(
                      color: destination.name == currentlySelectedInbox
                          ? theme.colorScheme.secondary
                          : ReplyColors.white50.withOpacity(0.64),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
