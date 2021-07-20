import 'package:cloudwalk/pages/pages.dart';
import 'package:flutter/material.dart';

import 'routes_name.dart';
import 'transition_animation/transition_animation.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.initial:
        return AppRoutes.slideUpRoute(DashboardPage());


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not available')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 42),
            child: Text(
              'You requested page is not available at the moment.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
