// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kavach/routes/app_router.dart';
import 'package:kavach/routes/app_routes.dart';

void main() {
  test('route registry resolves the command center', () {
    final route = AppRouter.onGenerateRoute(
      const RouteSettings(name: AppRoutes.commandCenter),
    );

    expect(route.settings.name, AppRoutes.commandCenter);
  });
}
