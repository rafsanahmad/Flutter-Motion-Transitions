/*
 * *
 *  * Created by Rafsan Ahmad on 11/6/21, 12:54 AM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/utils/colors.dart';
import 'package:flutter_motion_transitions/utils/constants.dart';

class BottomDrawerFolderSection extends StatelessWidget {
  const BottomDrawerFolderSection({required this.folders});

  final Map<String, String> folders;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        for (var folder in folders.keys)
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: ImageIcon(
                AssetImage(
                  folders[folder]!,
                  package: assetsPackage,
                ),
                color: ReplyColors.white50.withOpacity(0.64),
              ),
              title: Text(
                folder,
                style: theme.textTheme.bodyText2!.copyWith(
                  color: ReplyColors.white50.withOpacity(0.64),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
