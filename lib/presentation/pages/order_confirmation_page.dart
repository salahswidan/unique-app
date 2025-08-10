import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(AppConstants.primaryBlue),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingXLarge),
              
              // Order Confirmed Text
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Order Confirmed!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textColor),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingMedium),
              
              // Success Message
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Thank you for your order! Your custom poster is being prepared with care.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(AppConstants.secondaryTextColor),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingXLarge),
              
              // Order Details Card
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.paddingLarge),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Color(AppConstants.borderColor),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Color(AppConstants.primaryBlue),
                              size: 24,
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Text(
                              'Order Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(AppConstants.textColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        _buildOrderDetailRow('Order Number', '#POSTER-2024-001'),
                        _buildOrderDetailRow('Order Date', _getCurrentDate()),
                        _buildOrderDetailRow('Estimated Delivery', '5-7 business days'),
                        _buildOrderDetailRow('Payment Status', 'Paid'),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingXLarge),
              
              // Action Buttons
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: AppConstants.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(AppConstants.primaryBlue),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
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
                      
                      const SizedBox(height: AppConstants.paddingMedium),
                      
                      SizedBox(
                        width: double.infinity,
                        height: AppConstants.buttonHeight,
                        child: OutlinedButton(
                          onPressed: () {
                            context.go('/orders');
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(AppConstants.primaryBlue)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
                            ),
                          ),
                          child: Text(
                            'View Order History',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(AppConstants.primaryBlue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(AppConstants.textColor),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }
}
