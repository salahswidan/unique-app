import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/wishlist_bloc.dart';
import '../../core/constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.photo_library,
            color: Color(AppConstants.primaryBlue),
            size: 28,
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            'Poster App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
        ],
      ),
      actions: [
        // Wishlist Icon with Badge
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            int wishlistCount = 0;
            if (state is WishlistLoaded) {
              wishlistCount = state.items.length;
            }
            
            return Stack(
              children: [
                IconButton(
                  onPressed: () => context.go('/wishlist'),
                  icon: Icon(
                    Icons.favorite_border,
                    color: Color(AppConstants.textColor),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                ),
                if (wishlistCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        wishlistCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        
        // Cart Icon with Badge
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            int cartCount = 0;
            if (state is CartLoaded) {
              cartCount = state.items.length;
            }
            
            return Stack(
              children: [
                IconButton(
                  onPressed: () => context.go('/cart'),
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(AppConstants.textColor),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryBlue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cartCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        
        const SizedBox(width: AppConstants.paddingSmall),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
