// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:todo/ui/views/home.dart' as _i3;
import 'package:todo/ui/views/profile.dart' as _i4;
import 'package:todo/ui/views/todo_details.dart' as _i5;
import 'package:todo/ui/views/todo_edit.dart' as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.HomePage();
        }),
    ProfileRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.Profile();
        }),
    TodoDetailsRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.TodoDetails();
        }),
    TodoEditRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.TodoEdit();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomePageRoute.name, path: '/'),
        _i1.RouteConfig(ProfileRoute.name, path: '/Profile'),
        _i1.RouteConfig(TodoDetailsRoute.name, path: '/todo-details'),
        _i1.RouteConfig(TodoEditRoute.name, path: '/todo-edit')
      ];
}

class HomePageRoute extends _i1.PageRouteInfo {
  const HomePageRoute() : super(name, path: '/');

  static const String name = 'HomePageRoute';
}

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute() : super(name, path: '/Profile');

  static const String name = 'ProfileRoute';
}

class TodoDetailsRoute extends _i1.PageRouteInfo {
  const TodoDetailsRoute() : super(name, path: '/todo-details');

  static const String name = 'TodoDetailsRoute';
}

class TodoEditRoute extends _i1.PageRouteInfo {
  const TodoEditRoute() : super(name, path: '/todo-edit');

  static const String name = 'TodoEditRoute';
}
