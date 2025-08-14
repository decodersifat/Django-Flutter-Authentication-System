import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:inqbic/Model/OnboardingData.dart';
import 'package:inqbic/Presentation/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool onBoardingFlag = false;
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  void initState() {
    super.initState();
    _loadOnboardingState();
  }

  Future<void> _setOnboardingState() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('onBoardingFlag', onBoardingFlag);
  }

  Future<void> _loadOnboardingState() async {
    final pref = await SharedPreferences.getInstance();
    bool? flag = pref.getBool('onBoardingFlag');
    if (flag != null && flag) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _autoLoginPageTransition();
      });
    }
  }

  void _autoLoginPageTransition() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  Color hexToColorOpacity(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'B3$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  List<Widget> _buildIndicator() {
    return List.generate(pages.length, (index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 8,
        width: _activePage == index ? 24 : 8,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: _activePage == index ? Colors.blueGrey : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    });
  }

  void _nextPage() async {
    if (_activePage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      onBoardingFlag = true;
      await _setOnboardingState();
      _autoLoginPageTransition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? _buildWebUI() : _buildAndroidOrIosUI();
  }

  Widget _buildAndroidOrIosUI() {
    Color bgColor = hexToColor('#FFFFFF');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(pages[_activePage]['image']),
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.color),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    color: hexToColorOpacity('#000000'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            pages[index]['image'],
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          pages[index]['title'],
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            pages[index]['description'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildIndicator()),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          hexToColor(pages[_activePage]['color']),
                        ),
                        child: Text(
                          _activePage == pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: TextStyle(
                            color: hexToColor(pages[_activePage]['btnColor']),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebUI() {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Text(
                "This is web UI",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
