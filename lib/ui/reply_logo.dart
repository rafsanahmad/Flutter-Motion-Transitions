/*
 * *
 *  * Created by Rafsan Ahmad on 11/5/21, 8:38 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/utils/colors.dart';
import 'package:flutter_motion_transitions/utils/constants.dart';

class ReplyLogo extends StatelessWidget {
  const ReplyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      AssetImage(
        'reply/reply_logo.png',
        package: assetsPackage,
      ),
      size: 32,
      color: ReplyColors.white50,
    );
  }
}
