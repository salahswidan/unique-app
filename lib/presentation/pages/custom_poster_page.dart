import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/custom_poster_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../../core/constants/app_constants.dart';

class CustomPosterPage extends StatefulWidget {
  const CustomPosterPage({super.key});

  @override
  State<CustomPosterPage> createState() => _CustomPosterPageState();
}

class _CustomPosterPageState extends State<CustomPosterPage>
    with TickerProviderStateMixin {
  late AnimationController _sizeAnimationController;
  late Animation<double> _sizeAnimation;
  late AnimationController _stepAnimationController;
  late Animation<double> _stepAnimation;

  @override
  void initState() {
    super.initState();
    _sizeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sizeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _sizeAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _stepAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _stepAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _stepAnimationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _sizeAnimationController.dispose();
    _stepAnimationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      context.read<CustomPosterBloc>().add(SelectImage(image.path));
      _stepAnimationController.forward();
    }
  }

  void _selectSize(String size) {
    context.read<CustomPosterBloc>().add(SelectSize(size));
    _sizeAnimationController.forward().then((_) {
      _sizeAnimationController.reverse();
    });
  }

  void _selectFrame(String frame) {
    context.read<CustomPosterBloc>().add(SelectFrame(frame));
  }

  void _createCustomPoster() {
    final state = context.read<CustomPosterBloc>().state;
    if (state is CustomPosterInProgress) {
      context.read<CustomPosterBloc>().add(CreateCustomPoster());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocConsumer<CustomPosterBloc, CustomPosterState>(
        listener: (context, state) {
          if (state is CustomPosterCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Custom poster created successfully!')),
            );
            context.go('/checkout');
          } else if (state is CustomPosterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is CustomPosterInitial) {
            return _buildStep1UploadImage();
          } else if (state is CustomPosterInProgress) {
            if (state.selectedImagePath != null && state.selectedSize == null) {
              return _buildStep2ChooseSize(state);
            } else if (state.selectedSize != null && state.selectedFrame == null) {
              return _buildStep3ChooseFrame(state);
            } else if (state.selectedFrame != null) {
              return _buildStep4ReviewConfirm(state);
            }
          } else if (state is CustomPosterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return _buildStep1UploadImage();
        },
      ),
    );
  }

  Widget _buildStep1UploadImage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          _buildStepIndicator(1, 4),
          
          const SizedBox(height: 32),
          
          // Hero Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(AppConstants.primaryBlue).withOpacity(0.1),
                  Color(AppConstants.primaryBlue).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 64,
                  color: Color(AppConstants.primaryBlue),
                ),
                const SizedBox(height: 16),
                Text(
                  'Upload Your Image',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose an image from your gallery to create a custom poster',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(AppConstants.secondaryTextColor),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Upload Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload_file),
              label: const Text(
                'Select Image from Gallery',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(AppConstants.primaryBlue),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2ChooseSize(CustomPosterInProgress state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          _buildStepIndicator(2, 4),
          
          const SizedBox(height: 24),
          
          // Image Preview
          if (state.selectedImagePath != null)
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(state.selectedImagePath!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          
          const SizedBox(height: 32),
          
          // Size Selection Header
          Text(
            'Choose Size',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select the perfect size for your poster',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Size Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: AppConstants.posterDimensions.keys.map((size) {
              final isSelected = state.selectedSize == size;
              final dimensions = AppConstants.posterDimensions[size]!;
              
              return GestureDetector(
                onTap: () => _selectSize(size),
                child: AnimatedBuilder(
                  animation: _sizeAnimation,
                  builder: (context, child) {
                    final scale = isSelected ? _sizeAnimation.value : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          color: isSelected ? Color(AppConstants.primaryBlue) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(color: Color(AppConstants.primaryBlue), width: 3)
                              : Border.all(color: Colors.grey.shade300, width: 1),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Color(AppConstants.primaryBlue).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              size,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isSelected ? Colors.white : Color(AppConstants.textColor),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${dimensions['width']}" × ${dimensions['height']}"',
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white70 : Color(AppConstants.secondaryTextColor),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${dimensions['price']}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white70 : Color(AppConstants.primaryBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CustomPosterBloc>().add(ResetCustomPoster());
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: state.selectedSize != null
                      ? () {
                          // Move to next step
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryBlue),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep3ChooseFrame(CustomPosterInProgress state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          _buildStepIndicator(3, 4),
          
          const SizedBox(height: 24),
          
          // Image and Size Preview
          Row(
            children: [
              // Image Preview
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(state.selectedImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Size Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size: ${state.selectedSize}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.textColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppConstants.posterDimensions[state.selectedSize]!['width']}" × ${AppConstants.posterDimensions[state.selectedSize]!['height']}"',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(AppConstants.secondaryTextColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Frame Selection Header
          Text(
            'Choose Frame',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a frame style for your poster',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Frame Options
          Wrap(
            spacing: 12,
            runSpacing: 16,
            children: AppConstants.frameTypes.map((frame) {
              final isSelected = state.selectedFrame == frame;
              final frameData = AppConstants.frameTypesData[frame]!;
              
              return GestureDetector(
                onTap: () => _selectFrame(frame),
                child: Container(
                  width: 160,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(AppConstants.primaryBlue) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(color: Color(AppConstants.primaryBlue), width: 3)
                        : Border.all(color: Colors.grey.shade300, width: 1),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Color(AppConstants.primaryBlue).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        IconData(frameData['icon'] as int, fontFamily: 'MaterialIcons'),
                        size: 32,
                        color: isSelected ? Colors.white : Color(frameData['color'] as int),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        frame,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Color(AppConstants.textColor),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${frameData['price']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white70 : Color(AppConstants.primaryBlue),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CustomPosterBloc>().add(SelectSize(''));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: state.selectedFrame != null
                      ? () {
                          // Move to next step
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryBlue),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep4ReviewConfirm(CustomPosterInProgress state) {
    final sizeData = AppConstants.posterDimensions[state.selectedSize]!;
    final frameData = AppConstants.frameTypesData[state.selectedFrame!]!;
    final totalPrice = sizeData['price'] + frameData['price'];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Indicator
          _buildStepIndicator(4, 4),
          
          const SizedBox(height: 24),
          
          // Review Header
          Text(
            'Review & Confirm',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review your custom poster details before checkout',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.secondaryTextColor),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Poster Preview Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Image Preview
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(state.selectedImagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Details
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        'Size',
                        state.selectedSize!,
                        Icons.straighten,
                      ),
                    ),
                    Expanded(
                                             child: _buildDetailItem(
                         'Frame',
                         state.selectedFrame!,
                         IconData(frameData['icon'] as int, fontFamily: 'MaterialIcons'),
                       ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Dimensions
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dimensions:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(AppConstants.textColor),
                        ),
                      ),
                      Text(
                        '${sizeData['width']}" × ${sizeData['height']}"',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(AppConstants.secondaryTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Price Breakdown
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Breakdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textColor),
                  ),
                ),
                const SizedBox(height: 16),
                _buildPriceRow('Poster (${state.selectedSize})', '\$${sizeData['price']}'),
                _buildPriceRow('Frame (${state.selectedFrame})', '\$${frameData['price']}'),
                const Divider(height: 24),
                _buildPriceRow(
                  'Total',
                  '\$${totalPrice.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CustomPosterBloc>().add(SelectFrame(''));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _createCustomPoster,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryBlue),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue Shopping',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int currentStep, int totalSteps) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        final isCurrent = index == currentStep - 1;
        
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
            decoration: BoxDecoration(
              color: isActive 
                  ? Color(AppConstants.primaryBlue)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: Color(AppConstants.primaryBlue),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(AppConstants.secondaryTextColor),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.textColor),
          ),
        ),
      ],
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
