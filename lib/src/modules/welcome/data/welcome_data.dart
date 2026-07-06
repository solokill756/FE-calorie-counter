import '../domain/entities/welcome_slide_entity.dart';

class WelcomeData {
  static const List<WelcomeSlideEntity> slides = [
    WelcomeSlideEntity(
      title: 'Welcome to',
      subtitle: 'myfitnesspal',
      imagePath: 'assets/welcome_images/slide1.png',
      description: 'Ready for some wins? Start tracking, it\'s easy!',
    ),
    WelcomeSlideEntity(
      title: 'Welcome to',
      subtitle: 'myfitnesspal',
      imagePath: 'assets/welcome_images/slide2.png',
      description: 'Discover the impact of your food and fitness',
    ),
    WelcomeSlideEntity(
      title: 'Welcome to',
      subtitle: 'myfitnesspal',
      imagePath: 'assets/welcome_images/slide3.png',
      description: 'And make mindful eating a habit for life',
    ),
  ];
}
