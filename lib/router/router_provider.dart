/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 1:29 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_motion_transitions/router/router.dart';

class RouterProvider with ChangeNotifier {
  RouterProvider(ReplyHomePath this._routePath);

  ReplyRoutePath _routePath;

  ReplyRoutePath get routePath => _routePath;

  set routePath(ReplyRoutePath? route) {
    if (route != _routePath) {
      _routePath = route!;
      notifyListeners();
    }
  }
}
