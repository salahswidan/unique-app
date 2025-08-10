import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // Mock order data for demonstration
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#POSTER-2024-001',
      'date': '15/12/2024',
      'status': 'Delivered',
      'total': 45.99,
      'items': [
        {'name': 'Custom Nature Poster', 'size': 'Medium', 'frame': 'Vintage Wood'},
      ],
    },
    {
      'id': '#POSTER-2024-002',
      'date': '10/12/2024',
      'status': 'In Transit',
      'total': 32.50,
      'items': [
        {'name': 'Abstract Art Poster', 'size': 'Large', 'frame': 'No Frame'},
      ],
    },
    {
      'id': '#POSTER-2024-003',
      'date': '05/12/2024',
      'status': 'Delivered',
      'total': 28.75,
      'items': [
        {'name': 'City Skyline Poster', 'size': 'Small', 'frame': 'Simple Black'},
      ],
    },
    {
      'id': '#POSTER-2024-004',
      'date': '01/12/2024',
      'status': 'Delivered',
      'total': 67.25,
      'items': [
        {'name': 'Custom Family Photo', 'size': 'Large', 'frame': 'Modern Metal'},
        {'name': 'Vintage Travel Poster', 'size': 'Medium', 'frame': 'Classic Gold'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColor),
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(
            color: Color(AppConstants.textColor),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(AppConstants.textColor),
          ),
          onPressed: () => context.go('/'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _orders.isEmpty
          ? _buildEmptyState()
          : _buildOrderList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Color(AppConstants.secondaryTextColor),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            'Start shopping to see your order history here',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.paddingXLarge),
          SizedBox(
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
                'Start Shopping',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return _buildOrderCard(order, index);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index) {
    final statusColor = _getStatusColor(order['status']);
    
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['id'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(AppConstants.textColor),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['date'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(AppConstants.secondaryTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                    vertical: AppConstants.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.paddingMedium),
            
            // Order Items
            ...order['items'].map<Widget>((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(AppConstants.samplePosterColors[index % AppConstants.samplePosterColors.length]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(AppConstants.textColor),
                          ),
                        ),
                        Text(
                          '${item['size']} • ${item['frame']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(AppConstants.secondaryTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            const SizedBox(height: AppConstants.paddingMedium),
            
            // Order Total and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${order['total'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.primaryBlue),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _showOrderDetails(order);
                      },
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          color: Color(AppConstants.primaryBlue),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (order['status'] == 'Delivered')
                      TextButton(
                        onPressed: () {
                          _reorderItems(order);
                        },
                        child: Text(
                          'Reorder',
                          style: TextStyle(
                            color: Color(AppConstants.primaryBlue),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'In Transit':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Color(AppConstants.secondaryTextColor);
    }
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildOrderDetailsModal(order),
    );
  }

  Widget _buildOrderDetailsModal(Map<String, dynamic> order) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.textColor),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  _buildDetailRow('Order Number', order['id']),
                  _buildDetailRow('Order Date', order['date']),
                  _buildDetailRow('Status', order['status']),
                  _buildDetailRow('Total', '\$${order['total'].toStringAsFixed(2)}'),
                  
                  const SizedBox(height: AppConstants.paddingLarge),
                  
                  Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(AppConstants.textColor),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.paddingMedium),
                  
                  ...order['items'].map<Widget>((item) => Container(
                    margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(AppConstants.primaryBlue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: AppConstants.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppConstants.textColor),
                                ),
                              ),
                              Text(
                                '${item['size']} • ${item['frame']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(AppConstants.secondaryTextColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(AppConstants.textColor),
            ),
          ),
        ],
      ),
    );
  }

  void _reorderItems(Map<String, dynamic> order) {
    // Navigate to cart with reordered items
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Items added to cart for reorder'),
        backgroundColor: Color(AppConstants.primaryBlue),
      ),
    );
    context.go('/cart');
  }
}
