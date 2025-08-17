import 'package:food_delivery/features/onboarding/domain/entities_model.dart';

class EntitiesData {
  static final List<OnBoardingEntity> onboardingData = [
    OnBoardingEntity(
      image: "assets/images/onBoarding1.png",
      title: "We serve incomparable delicacies",
      subtitle:
          "All the best restaurants with their top menu waiting for you...",
    ),
    OnBoardingEntity(
      image: "assets/images/onBoarding2.png",
      title: "Fast delivery",
      subtitle: "Get your food delivered to your doorstep quickly",
    ),
    OnBoardingEntity(
      image: "assets/images/onBoarding1.png",
      title: "Easy payment",
      subtitle: "Pay easily with multiple secure methods",
    ),
  ];
}
