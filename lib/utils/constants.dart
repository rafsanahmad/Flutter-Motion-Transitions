/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 7:54 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';

import 'extensions.dart';

const assetsPackage = 'flutter_gallery_assets';
const iconAssetLocation = 'reply/icons';
const folderIconAssetLocation = '$iconAssetLocation/twotone_folder.png';
final mobileMailNavKey = GlobalKey<NavigatorState>();
const double kFlingVelocity = 2.0;
const kAnimationDuration = Duration(milliseconds: 300);
const String homePageLocation = '/reply/home';
const String searchPageLocation = 'reply/search';
SlowMotionSpeedSetting currentSlowMotionSpeed =
    SlowMotionSpeedSetting.slow;
