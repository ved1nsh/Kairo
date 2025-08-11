import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/ob_pg_indicator.dart';
import '../widgets/slide_page_route.dart';
import 'onboarding_2.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1>
    with TickerProviderStateMixin {
  late AnimationController _exitController;
  late Animation<Offset> _titleExitAnimation;
  late Animation<Offset> _mainTitleExitAnimation;
  late Animation<Offset> _contentExitAnimation;
  late Animation<double> _fadeExitAnimation;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _titleExitAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0), // Slide out left
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _mainTitleExitAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.0, 0.0), // Slide out right
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _contentExitAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.0, 0.0), // Slide out right
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _fadeExitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _exitController.dispose();
    super.dispose();
  }

  void _navigateToNext() async {
    setState(() {
      _isExiting = true;
    });

    // Start exit animation
    await _exitController.forward();

    // Navigate to next page with background color transition
    if (mounted) {
      Navigator.push(
        context,
        ComponentSlideTransition(
          page: const Onboarding2(),
          fromColor: const Color(0xFFD5EF84),
          toColor: const Color(0xFF3F564C),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EF84),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            children: [
              // Page indicator at the top (doesn't animate)
              Container(
                margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
                child: PageIndicator(currentPage: 1, totalPages: 4),
              ),

              // Main content area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "The first one," text with slide out animation
                    SlideTransition(
                      position:
                          _isExiting
                              ? _titleExitAnimation
                              : Tween<Offset>(
                                begin: Offset.zero,
                                end: Offset.zero,
                              ).animate(_exitController),
                      child: FadeTransition(
                        opacity:
                            _isExiting
                                ? _fadeExitAnimation
                                : Tween<double>(
                                  begin: 1.0,
                                  end: 1.0,
                                ).animate(_exitController),
                        child: Text(
                          'The first one,',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // "Physical Wellbeing" title with slide out animation
                    SlideTransition(
                      position:
                          _isExiting
                              ? _mainTitleExitAnimation
                              : Tween<Offset>(
                                begin: Offset.zero,
                                end: Offset.zero,
                              ).animate(_exitController),
                      child: FadeTransition(
                        opacity:
                            _isExiting
                                ? _fadeExitAnimation
                                : Tween<double>(
                                  begin: 1.0,
                                  end: 1.0,
                                ).animate(_exitController),
                        child: Text(
                          'Physical\nWellbeing',
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 35.h),

                    // Content (image and text) with slide out animation
                    Expanded(
                      child: SlideTransition(
                        position:
                            _isExiting
                                ? _contentExitAnimation
                                : Tween<Offset>(
                                  begin: Offset.zero,
                                  end: Offset.zero,
                                ).animate(_exitController),
                        child: FadeTransition(
                          opacity:
                              _isExiting
                                  ? _fadeExitAnimation
                                  : Tween<double>(
                                    begin: 1.0,
                                    end: 1.0,
                                  ).animate(_exitController),
                          child: Column(
                            children: [
                              // Image
                              SizedBox(
                                height: 200.h,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/onboarding/pw1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.h),

                              // Text content
                              Text(
                                'Stay active, eat well, and rest enough.',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 10.h),

                              Text(
                                'Your body is your energy source — care for it daily to feel strong, fresh, and confident.',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Button
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: GestureDetector(
                  onTap: _navigateToNext,
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      'assets/images/onboarding/nav_button1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
