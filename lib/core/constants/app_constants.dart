class AppConstants {
  // Design specifications
  static const int primaryBlue = 0xFF2563EB;
  static const int backgroundColor = 0xFFFFFFFF;
  static const int textColor = 0xFF1F2937;
  static const int secondaryTextColor = 0xFF6B7280;
  static const int borderColor = 0xFFE5E7EB;
  
  // Screen dimensions (375x812px for mobile)
  static const double screenWidth = 375.0;
  static const double screenHeight = 812.0;
  
  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Button dimensions
  static const double buttonHeight = 48.0;
  static const double buttonRadius = 8.0;
  
  // Poster sizes
  static const String smallSize = 'Small';
  static const String mediumSize = 'Medium';
  static const String largeSize = 'Large';
  
  // Poster dimensions (width x height in cm) with pricing
  static const Map<String, Map<String, dynamic>> posterDimensions = {
    smallSize: {'width': 30.0, 'height': 40.0, 'price': 19.99},
    mediumSize: {'width': 50.0, 'height': 70.0, 'price': 34.99},
    largeSize: {'width': 70.0, 'height': 100.0, 'price': 49.99},
  };
  
  // Frame types
  static const List<String> frameTypes = [
    'No Frame',
    'Simple Black',
    'Simple White',
    'Vintage Wood',
    'Modern Metal',
    'Classic Gold',
  ];
  
  // Frame types data with icons, colors, and pricing
  static const Map<String, Map<String, dynamic>> frameTypesData = {
    'No Frame': {
      'icon': 0xe3b3, // Icons.crop_free
      'color': 0xFF6B7280,
      'price': 0.0,
    },
    'Simple Black': {
      'icon': 0xe3b3, // Icons.crop_free
      'color': 0xFF000000,
      'price': 9.99,
    },
    'Simple White': {
      'icon': 0xe3b3, // Icons.crop_free
      'color': 0xFFFFFFFF,
      'price': 9.99,
    },
    'Vintage Wood': {
      'icon': 0xe3b3, // Icons.crop_free
      'color': 0xFF8B4513,
      'price': 24.99,
    },
    'Modern Metal': {
      'icon': 0xe3b3, // Icons.crop_free
      'color': 0xFFC0C0C0,
      'price': 29.99,
    },
    'Classic Gold': {
      'icon': 0xe3b3, // Icons.crop_free
      'color': 0xFFFFD700,
      'price': 39.99,
    },
  };
  
  // Sample poster colors for demo
  static const List<int> samplePosterColors = [
    0xFFE57373, // Red
    0xFF81C784, // Green
    0xFF64B5F6, // Blue
    0xFFFFB74D, // Orange
    0xFFBA68C8, // Purple
    0xFF4DB6AC, // Teal
    0xFFFF8A65, // Deep Orange
    0xFF7986CB, // Indigo
    0xFF4DD0E1, // Cyan
    0xFFA1887F, // Brown
  ];
}
