import 'package:flutter/material.dart';
import 'package:movie_db_app/login/view/login_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Data Found'),
            ),
          ),
        );
    }
  }
}
