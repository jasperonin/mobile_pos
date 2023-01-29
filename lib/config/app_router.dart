import 'package:flutter/material.dart';
import 'package:mobile_pos/user_models/models.dart';
import 'package:mobile_pos/user_screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return UserHomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();
      case PaymentSelection.routeName:
        return PaymentSelection.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
