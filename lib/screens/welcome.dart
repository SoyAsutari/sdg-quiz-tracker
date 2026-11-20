import 'package:flutter/material.dart';
import 'login_screen.dart';

const double kDefaultPadding = 20.0;
const LinearGradient kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46C2CB), Color(0xFF7C4DFF)],
);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Controller to handle the swiping between pages
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // The content for the 3 onboarding slides
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Welcome to SDG Quiz",
      "description": "Test your knowledge on the 17 Sustainable Development Goals and see how you can make a difference.",
      "icon": Icons.public,
    },
    {
      "title": "Learn & Compete",
      "description": "Take quizzes on Climate Action, Quality Education, and more. Earn points and track your progress.",
      "icon": Icons.emoji_events,
    },
    {
      "title": "Ready to Start?",
      "description": "Join our community of learners. Create an account or login to start your first quiz today!",
      "icon": Icons.rocket_launch,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- SKIP BUTTON (Top Right) ---
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToLogin,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),

            // --- PAGE VIEW (Swiping Intro Screens) ---
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final slide = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon
                        Icon(
                          slide['icon'],
                          size: 120,
                          color: const Color(0xFF46C2CB),
                        ),
                        const SizedBox(height: 40),
                        // Title
                        Text(
                          slide['title'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          slide['description'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                                height: 1.5,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // --- DOT INDICATORS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => buildDot(index),
              ),
            ),
            
            const SizedBox(height: 40),

            // --- NEXT / GET STARTED BUTTON ---
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: GestureDetector(
                onTap: () {
                  if (_currentPage == _onboardingData.length - 1) {
                    // If it's the last page, go to Login
                    _goToLogin();
                  } else {
                    // Otherwise, go to the next page
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 56,
                  decoration: const BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    _currentPage == _onboardingData.length - 1 
                        ? "Get Started" 
                        : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to navigate to Login
  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // Helper widget for the sliding dots
  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: _currentPage == index ? 30 : 10, // Active dot is wider
      decoration: BoxDecoration(
        color: _currentPage == index 
            ? const Color(0xFF46C2CB) 
            : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}