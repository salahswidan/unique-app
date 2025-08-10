import 'package:flutter/material.dart';
import 'package:unique/core/themes/app_colors.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      'Featured Collection',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      textAlign: TextAlign.center,
                      'Carefully curated posters that bring personality and style to any space',
                      style: TextStyle(
                        color: Color.fromRGBO(75, 85, 99, 1),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Poster();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 1), // x=0, y=1
            blurRadius: 2, // matches "2px"
            spreadRadius: 0, // matches "0" in CSS
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.network(
                'http://localhost:3000/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1541961017774-22349e4a1262%3Fw%3D500%26h%3D600%26fit%3Dcrop&w=1200&q=75',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abstract Geometric Art',
                  style: TextStyle(
                    color: Color.fromRGBO(31, 41, 55, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Modern abstract geometric artwork perfect for contemporary spaces.',
                  style: TextStyle(
                    color: Color.fromRGBO(107, 114, 128, 1),
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$24.99',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Chip(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              labelPadding: EdgeInsets.zero,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: Color(
                                0xFFF3F4F6,
                              ),
                              label: Text(
                                'Small',
                                style: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '30cm × 40cm',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Select Size',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
