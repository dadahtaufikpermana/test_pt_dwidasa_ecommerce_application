import 'package:flutter/material.dart';
import 'package:test_pt_dwidasa_ecommerce_app/ui/splash_screen.dart';
import '../ui/products/pages/product_detail_page.dart';
import '../ui/products/pages/products_page.dart';

class Routes {
  static const splashScreen = '/splash_screen';
  static const productsPage = '/';
  static const productDetailPage = '/product_detail_page';
}

class RouteGenerator {
  static Widget _getMainPage(String? routeName, Object? arguments) {
    switch (routeName) {
      case Routes.splashScreen:
        return SplashScreen();
      case Routes.productsPage:
        return ProductsPage();
      case Routes.productDetailPage:
        if (arguments is int && arguments != 0) {
          return ProductDetailPage(productId: arguments);
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Invalid product ID'),
            ),
            body: Center(
              child: Text('Invalid product ID'),
            ),
          );
        }
    /* Default Page */
      default:
        return Scaffold(
          body: Center(child: Text("404 NOT FOUND")),
        );
    }
  }

  static Route<dynamic>? builder(RouteSettings? settings) {
    if (settings == null) return null;
    Widget page = _getMainPage(settings.name, settings.arguments);
    return MaterialPageRoute(
        builder: (buildContext) => page, settings: settings);
  }
}

