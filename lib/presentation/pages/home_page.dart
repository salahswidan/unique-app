import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/posters_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/wishlist_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/poster_card.dart';
import '../../core/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
            context.read<PostersBloc>().add(LoadPosters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<PostersBloc, PostersState>(
        builder: (context, state) {
          if (state is PostersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostersLoaded) {
            return _buildContent(state);
          } else if (state is PostersError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No posters available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/custom-poster'),
        backgroundColor: Color(AppConstants.primaryBlue),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_photo_alternate),
        label: const Text(
          'Create Poster',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 4,
      ),
    );
  }

  Widget _buildContent(PostersLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
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
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover our curated collection',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textColor),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'High-quality posters perfect for any space — from abstract art to nature photography. Find the perfect piece for your home or office.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(AppConstants.secondaryTextColor),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/custom-poster'),
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text(
                      'Create Custom Poster',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
          ),
          
          const SizedBox(height: 32),
          
          // Featured Posters Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Posters',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.textColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Could navigate to a full catalog view
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Color(AppConstants.primaryBlue),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Posters Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.posters.length,
            itemBuilder: (context, index) {
              final poster = state.posters[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to poster detail page
                },
                child: PosterCard(
                  poster: poster,
                  index: index,
                ),
              );
            },
          ),
          
          const SizedBox(height: 32),
          
          // Categories Section
          Text(
            'Shop by Category',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textColor),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Category Cards
          Row(
            children: [
              Expanded(
                child: _buildCategoryCard(
                  'Abstract Art',
                  Icons.auto_awesome,
                  Color(AppConstants.primaryBlue),
                  () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCategoryCard(
                  'Nature',
                  Icons.landscape,
                  Colors.green.shade600,
                  () {},
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildCategoryCard(
                  'Minimalist',
                  Icons.crop_square,
                  Colors.grey.shade600,
                  () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCategoryCard(
                  'Vintage',
                  Icons.history,
                  Colors.orange.shade600,
                  () {},
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
