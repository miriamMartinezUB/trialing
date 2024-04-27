import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trialing/common/navigation/router.dart';
import 'package:trialing/resoruces/routes.dart';

class NavigationService {
  final GoRouter _router = GoRouter(routes: routes);

  final List<String> _navigationStack = [Routes.home];

  GoRouter get router => _router;

  String get currentRoute => _navigationStack.last;

  bool get canGoBack => _navigationStack.length > 1;

  void navigateTo(String routeName, {Object? arguments}) {
    _navigationStack.add(routeName);
    String path = _getRoutePath(routeName);
    _router.go(path, extra: arguments);
  }

  Future<dynamic> replace(String routeName, {Object? arguments}) async {
    _navigationStack.clear();
    _navigationStack.add(routeName);
    String path = _getRoutePath(routeName);
    return _router.replace(path, extra: arguments);
  }

  void goBack() {
    if (_router.canPop()) {
      _navigationStack.removeLast();
      _router.pop();
    } else {
      throw FlutterError("Can not pop");
    }
  }

  void close() {
    if (_router.canPop()) {
      _router.pop();
    } else {
      throw FlutterError("Can not pop");
    }
  }

  String _getRoutePath(String routeName) {
    return routeName.startsWith('/') ? routeName : '/$routeName';
  }
}
