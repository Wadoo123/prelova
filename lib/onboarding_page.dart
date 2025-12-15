import 'package:flutter/material.dart';
import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'lib/assets/onboarding/onboarding1.png',
      'title': 'Discover Preloved Treasures',
      'description':
          'Temukan berbagai barang preloved dengan kualitas terbaik.'
          'Beli atau jual dengan mudah, bantu bumi tetap lestari.',
    },
    {
      'image': 'lib/assets/onboarding/onboarding2.png',
      'title': 'Sell Easily, Shop Seamlessly',
      'description':
          'Upload produk bekasmu, temukan pembeli baru.'
          'Semua dalam satu aplikasi yang cepat dan aman.',
    },
    {
      'image': 'lib/assets/onboarding/onboarding3.png',
      'title': 'Join the Sustainable Community',
      'description':
          'Jadilah bagian dari komunitas yang mencintai keberlanjutan.'
          'Karena barang bekasmu bisa jadi awal kisah orang lain.',
    },
  ];

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _goNext() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goBack() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == _pages.length - 1;
    final bool isFirstPage = _currentIndex == 0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F9FC), Color(0xFFEAEFF5), Color(0xFFD6E9FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (_, index) {
                    return _OnboardingItem(
                      image: _pages[index]['image']!,
                      title: _pages[index]['title']!,
                      description: _pages[index]['description']!,
                    );
                  },
                ),
              ),

              _Indicator(currentIndex: _currentIndex),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// LEFT BUTTON
                    OutlinedButton(
                      onPressed: isFirstPage ? _goToLogin : _goBack,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        isFirstPage ? 'Skip' : 'Back',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),

                    /// RIGHT BUTTON
                    ElevatedButton(
                      onPressed: () {
                        if (isLastPage) {
                          _goToLogin();
                        } else {
                          _goNext();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const _OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 320),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final int currentIndex;

  const _Indicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(currentIndex == index ? 1.0 : 0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
