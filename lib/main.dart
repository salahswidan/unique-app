import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/di/dependency_injection.dart';
import 'core/constants/app_constants.dart';
import 'presentation/blocs/posters_bloc.dart';
import 'presentation/blocs/cart_bloc.dart';
import 'presentation/blocs/wishlist_bloc.dart';
import 'presentation/blocs/custom_poster_bloc.dart';
import 'presentation/pages/sign_in_page.dart';
import 'presentation/pages/sign_up_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/pages/wishlist_page.dart';
import 'presentation/pages/custom_poster_page.dart';
import 'presentation/pages/checkout_page.dart';

void main() {
  runApp(const PosterApp());
}

class PosterApp extends StatelessWidget {
  const PosterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    DependencyInjection.init();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostersBloc>(
          create: (context) => DependencyInjection.get<PostersBloc>('postersBloc'),
        ),
        BlocProvider<CartBloc>(
          create: (context) => DependencyInjection.get<CartBloc>('cartBloc'),
        ),
        BlocProvider<WishlistBloc>(
          create: (context) => DependencyInjection.get<WishlistBloc>('wishlistBloc'),
        ),
        BlocProvider<CustomPosterBloc>(
          create: (context) => DependencyInjection.get<CustomPosterBloc>('customPosterBloc'),
        ),
      ],
      child: MaterialApp.router(
        title: 'Poster App',
        theme: ThemeData(
          primaryColor: Color(AppConstants.primaryBlue),
          primarySwatch: Colors.blue,
          useMaterial3: true,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Color(AppConstants.backgroundColor),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(AppConstants.backgroundColor),
            foregroundColor: Color(AppConstants.textColor),
            elevation: 0,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppConstants.primaryBlue),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              ),
              elevation: 0,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              borderSide: BorderSide(color: Color(AppConstants.borderColor)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              borderSide: BorderSide(color: Color(AppConstants.primaryBlue)),
            ),
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/signin',
  routes: [
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/wishlist',
      builder: (context, state) => const WishlistPage(),
    ),
    GoRoute(
      path: '/custom-poster',
      builder: (context, state) => const CustomPosterPage(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
  ],
);
