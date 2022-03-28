import 'package:flutter/material.dart';
import 'package:innovators/view/splash_page/splash_screen.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardScreen extends StatefulWidget {
  // var screenWidth;
  // var screenHeight;

  static const String routeName = "onborad-screen";
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  Material? materialButton;
  final onboardingPagesList = [
    PageModel(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 45.0,
              vertical: 90.0,
            ),
            child: Image.asset('assets/images/durov.jpeg'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Find an innovator',
              style: pageTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Opportunities for startups and small entrepreneurship to publish their offer and find like-minded people. ',
              style: pageInfoStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 45.0,
              vertical: 90.0,
            ),
            child: Image.asset(
              'assets/images/onboard2.jpg',
              height: 300,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'FIND EXPERIENCE',
              style: pageTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Opportunities for inexperienced junior level specialists in all spheres to find interesting and real-life practice opportunities.',
              style: pageInfoStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 45.0,
              vertical: 90.0,
            ),
            child: Image.asset('assets/images/onboard3.jpg'),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'FREELANCE SERVICES',
              style: pageTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'for special freelance, research, mentoring service offers, activities and news for students and other people. ',
              style: pageInfoStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // materialButton = _skipButton;
  }

  void _buildButton(int pageIndex) {
    if (pageIndex == 2) {
      setState(() {
        materialButton = _signupButton;
      });
    } else {
      setState(() {
        materialButton;
      });
    }
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          _storeOnboardInfo();
          Navigator.pushNamed(context, SplashScreen.routeName);
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Sign up',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Onboarding(
        pages: onboardingPagesList,
        onPageChange: (int pageIndex) {
          _buildButton(pageIndex);
        },
        footer: Footer(
          child: materialButton ??
              const Text(
                "Swipe Left",
                style: pageTitleStyle,
                textAlign: TextAlign.left,
              ),
          indicator: Indicator(
            indicatorDesign: IndicatorDesign.line(
              lineDesign: LineDesign(
                lineType: DesignType.line_uniform,
              ),
            ),
          ),
          footerPadding: const EdgeInsets.all(25),
        ),
      ),
    );
  }
}
