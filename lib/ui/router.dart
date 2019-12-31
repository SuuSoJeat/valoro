import 'package:flutter/material.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/ui/views/debt_view.dart';
import 'package:valoro/ui/views/home_view.dart';
import 'package:valoro/ui/views/login_view.dart';
import 'package:valoro/ui/views/recent_records_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Debt:
        return MaterialPageRoute(builder: (_) => DebtView());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.RecentRecords:
        return MaterialPageRoute(builder: (_) => RecentRecordsView(), fullscreenDialog: true);
//      case RoutePaths.Post:
//        var post = settings.arguments as Post;
//        return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
