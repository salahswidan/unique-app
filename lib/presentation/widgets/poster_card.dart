import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/poster.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/wishlist_bloc.dart';
import '../../core/constants/app_constants.dart';

class PosterCard extends StatelessWidget {
  final Poster poster;
  final int index;
  
  const PosterCard({
    super.key,
    required this.poster,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(AppConstants.samplePosterColors[index % AppConstants.samplePosterColors.length]);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster Image/Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: poster.isCustom && poster.customImagePath != null ? null : color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: poster.isCustom && poster.customImagePath != null
                    ? DecorationImage(
                        image: AssetImage(poster.customImagePath!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: poster.isCustom && poster.customImagePath != null
                  ? null
                  : Center(
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
            ),
          ),
          
          // Poster Details
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  poster.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textColor),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: AppConstants.paddingSmall),
                
                Row(
                  children: [
                    Icon(
                      Icons.straighten,
                      size: 16,
                      color: Color(AppConstants.secondaryTextColor),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      poster.size,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(AppConstants.secondaryTextColor),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.paddingSmall),
                
                Row(
                  children: [
                    Icon(
                      Icons.crop_free,
                      size: 16,
                      color: Color(AppConstants.secondaryTextColor),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        poster.frame,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(AppConstants.secondaryTextColor),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.paddingMedium),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${poster.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.primaryBlue),
                      ),
                    ),
                    Row(
                      children: [
                        // Wishlist Button
                        BlocBuilder<WishlistBloc, WishlistState>(
                          builder: (context, wishlistState) {
                            final isInWishlist = wishlistState is WishlistLoaded &&
                                wishlistState.items.any((item) => item.id == poster.id);
                            
                            return IconButton(
                              onPressed: () {
                                if (isInWishlist) {
                                  context.read<WishlistBloc>().add(
                                    RemoveFromWishlist(poster.id),
                                  );
                                } else {
                                  context.read<WishlistBloc>().add(
                                    AddToWishlist(poster),
                                  );
                                }
                              },
                              icon: Icon(
                                isInWishlist ? Icons.favorite : Icons.favorite_border,
                                color: isInWishlist ? Colors.red : Color(AppConstants.secondaryTextColor),
                                size: 20,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
                            );
                          },
                        ),
                        
                        // Add to Cart Button
                        IconButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                              AddToCart(poster, 1),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${poster.title} added to cart'),
                                backgroundColor: Color(AppConstants.primaryBlue),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Color(AppConstants.primaryBlue),
                            size: 20,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 48,
                            minHeight: 48,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
