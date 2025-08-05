import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kairo/Components/OB_button.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _secondTextController; // Add this
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _secondTextFade; // Add this

  bool _showSecondText = false;

  @override
  void initState() {
    super.initState();

    // Controller for fade-in animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Controller for slide animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Controller for second text fade animation
    _secondTextController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.3), // Adjust this to control how far up it goes
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    _secondTextFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondTextController, curve: Curves.easeInOut),
    );

    // Start the initial fade-in animation
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _secondTextController.dispose(); // Add this
    super.dispose();
  }

  void _handleButtonPress() {
    setState(() {
      _showSecondText = true;
    });

    // Start slide animation first
    _slideController.forward();

    // Start second text fade after a delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _secondTextController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9CAC5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            // Expanded area for text content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First text with slide and fade animations
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Ever wondered what it really takes to turn your life around?',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Second text that appears after button press with fade animation
                    if (_showSecondText)
                      FadeTransition(
                        opacity: _secondTextFade, // Use the fade animation
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.h), // Adjust spacing
                          child: Column(
                            children: [
                              Text(
                                'It takes precisely',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87,
                                  height: 0.1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '3',
                                style: GoogleFonts.abhayaLibre(
                                  fontSize: 140.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              Text(
                                'dimensions of\nwellness to change\nyour life around',
                                style: TextStyle(
                                  fontSize: 32.sp, // Made slightly smaller
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Fixed button at the bottom
            Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: CustomButton(
                  backgroundColor: const Color(0xFF191B46),
                  text: _showSecondText ? 'Continue' : "Let's find out",
                  onPressed:
                      _showSecondText
                          ? () => Navigator.pushNamed(context, '/onboarding2')
                          : _handleButtonPress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
