/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 1:13 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/pages/home_page.dart';
import 'package:flutter_motion_transitions/pages/search_page.dart';
import 'package:flutter_motion_transitions/router/router_provider.dart';
import 'package:flutter_motion_transitions/utils/constants.dart';
import 'package:flutter_motion_transitions/utils/custom_transition_page.dart';
import 'package:provider/provider.dart';

class ReplyRouterDelegate extends RouterDelegate<ReplyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ReplyRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  RouterProvider replyState;

  ReplyRouterDelegate({required this.replyState})
      : navigatorKey = GlobalObjectKey<NavigatorState>(replyState) {
    replyState.addListener(() {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RouterProvider>.value(value: replyState),
      ],
      child: Selector<RouterProvider, ReplyRoutePath?>(
          selector: (context, routerProvider) => routerProvider.routePath,
          builder: (context, routePath, child) {
            return Navigator(
              key: navigatorKey,
              onPopPage: _handlePopPage,
              pages: [
                const CustomTransitionPage(
                  transitionKey: ValueKey('Home'),
                  screen: HomePage(),
                ),
                if (routePath is ReplySearchPath)
                  const CustomTransitionPage(
                    transitionKey: ValueKey('Search'),
                    screen: SearchPage(),
                  ),
              ],
            );
          }),
    );
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    // _handlePopPage should not be called on the home page because the
    // PopNavigatorRouterDelegateMixin will bubble up the pop to the
    // SystemNavigator if there is only one route in the navigator.
    assert(route.willHandlePopInternally ||
        replyState.routePath is ReplySearchPath);

    final bool didPop = route.didPop(result);
    if (didPop) replyState.routePath = const ReplyHomePath();
    return didPop;
  }

  @override
  Future<void> setNewRoutePath(ReplyRoutePath configuration) {
    replyState.routePath = configuration;
    return SynchronousFuture<void>(null);
  }

  @override
  void dispose() {
    replyState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  ReplyRoutePath get currentConfiguration => replyState.routePath;
}

@immutable
abstract class ReplyRoutePath {
  const ReplyRoutePath();
}

class ReplyHomePath extends ReplyRoutePath {
  const ReplyHomePath();
}

class ReplySearchPath extends ReplyRoutePath {
  const ReplySearchPath();
}

class ReplyRouteInformationParser
    extends RouteInformationParser<ReplyRoutePath> {
  @override
  Future<ReplyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = Uri.parse(routeInformation.location!);
    if (url.path == searchPageLocation) {
      return SynchronousFuture<ReplySearchPath>(const ReplySearchPath());
    }
    return SynchronousFuture<ReplyHomePath>(const ReplyHomePath());
  }

  @override
  RouteInformation? restoreRouteInformation(ReplyRoutePath configuration) {
    if (configuration is ReplyHomePath) {
      return const RouteInformation(location: homePageLocation);
    }
    if (configuration is ReplySearchPath) {
      return const RouteInformation(location: searchPageLocation);
    }
    return null;
  }
}
