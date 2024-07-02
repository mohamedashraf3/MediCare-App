class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({required this.image, required this.title, required this.discription});
}

List<OnboardingContent> contents = [

  OnboardingContent(
    title:  "Never miss a dose!",
    image: 'assets/images/onboarding/never_miss.png',
    discription:   "Implement reminders and notifications to ensure timely medication intake.",
  ),
  OnboardingContent(
    title: 'Pay attention !',
    image: 'assets/images/onboarding/pay_attention.png',
    discription: "Stay informed about possible side effects and drug interactions with alerts and notification"
  ),
  OnboardingContent(
      title: 'Get access  !',
      image: 'assets/images/onboarding/get_access.png',
      discription: "Get access to the medicine store and find the desired medication, you can also find a suitable doctor and book an appoinment."
  ),
];
