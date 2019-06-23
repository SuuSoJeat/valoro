import 'package:flutter/material.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/ui/views/home_view.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) {
          return SplashScreen(
            'assets/mangekyo-sharingan.flr',
            HomeView(),
            startAnimation: 'rotate',
            backgroundColor: Colors.black,
          );
        });
//      case RoutePaths.Login:
//        return MaterialPageRoute(builder: (_) => LoginView());
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
