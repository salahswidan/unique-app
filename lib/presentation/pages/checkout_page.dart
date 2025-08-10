import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/cart_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../../core/constants/app_constants.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return _buildEmptyCart();
            }
            return _buildCheckoutContent(state);
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No cart data'));
          }
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some posters to your cart to proceed with checkout',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(AppConstants.primaryBlue),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Shopping',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutContent(CartLoaded state) {
    final subtotal = state.items.fold<double>(
      0.0,
      (sum, poster) => sum + poster.price,
    );
    const shipping = 5.99;
    final total = subtotal + shipping;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Cart & Checkout',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review your items and complete your order',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Cart Items
          Text(
            'Order Summary (${state.items.length} items)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: 16),
          
          // Items List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final poster = state.items[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Poster Image
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: poster.isCustom && poster.customImagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(poster.customImagePath!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.image,
                                color: Colors.grey.shade600,
                                size: 32,
                              ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Poster Details
                      Expanded(
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
                            const SizedBox(height: 4),
                            Text(
                              '${poster.size} • ${poster.frame}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(AppConstants.secondaryTextColor),
                              ),
                            ),
                            if (poster.isCustom) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Color(AppConstants.primaryBlue).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Custom',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(AppConstants.primaryBlue),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      // Price and Actions
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${poster.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(AppConstants.primaryBlue),
                            ),
                          ),
                          const SizedBox(height: 8),
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(RemoveFromCart(poster.id));
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red.shade400,
                              size: 20,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // Price Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textColor),
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildPriceRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                _buildPriceRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
                
                const Divider(height: 24),
                
                _buildPriceRow(
                  'Total',
                  '\$${total.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Show success message and clear cart
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.read<CartBloc>().add(ClearCart());
                context.go('/order-confirmation');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(AppConstants.primaryBlue),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Continue Shopping Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue Shopping',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Color(AppConstants.textColor),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Color(AppConstants.primaryBlue) : Color(AppConstants.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
