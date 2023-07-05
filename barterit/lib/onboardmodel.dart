class OnBoarding {
  final String title;
  final String image;
  final String color;
  OnBoarding({required this.title, required this.image, required this.color});
}

List onBoardingContent = [
  OnBoarding(
    title: 'Welcome to BarterIt',
    image: 'assets/images/onboard0.png',
    color: 'black',
  ),
  OnBoarding(
    title: 'Find Your NEED',
    image: 'assets/images/onboard1.png',
    color: 'blue',
  ),
  OnBoarding(
    title: 'Get Started',
    image: 'assets/images/onboard2.png',
    color: 'yellow',
  )
];
