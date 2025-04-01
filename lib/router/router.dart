import 'package:go_router/go_router.dart';
import 'package:stirred_app/presentation/views/drink_details/drink_details_view.dart';
import 'package:stirred_app/presentation/views/drinks.dart';
import 'package:stirred_app/presentation/views/login_view.dart';
import 'package:stirred_app/presentation/views/splash_view.dart';

final router = GoRouter(
  routes: [
    // GoRoute(path: '/', builder: (context, state) => SplashView(child: LoginView())),
    // GoRoute(path: '/', builder: (context, state) => DrinkDetailsView()),
    GoRoute(path: '/', builder: (context, state) => DrinksView()),
  ],
);