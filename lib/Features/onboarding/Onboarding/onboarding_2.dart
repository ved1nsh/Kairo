import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/ob_pg_indicator.dart';
import '../widgets/slide_page_route.dart'; // Add this import
import 'onboarding_3.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2>
    with TickerProviderStateMixin {
  // Entrance
  late AnimationController _enterController;
  late Animation<Offset> _titleEnter;
  late Animation<Offset> _mainTitleEnter;
  late Animation<Offset> _contentEnter;
  late Animation<double> _fadeEnter;

  // Exit
  late AnimationController _exitController;
  late Animation<Offset> _titleExit;
  late Animation<Offset> _mainTitleExit;
  late Animation<Offset> _contentExit;
  late Animation<double> _fadeExit;

  bool _isExiting = false;

  @override
  void initState() {
    super.initState();

    // ENTRANCE
    _enterController = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    _titleEnter = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
      ),
    );

    _mainTitleEnter = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: const Interval(0.25, 0.8, curve: Curves.easeOut),
      ),
    );

    _contentEnter = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: const Interval(0.4, 1, curve: Curves.easeOut),
      ),
    );

    _fadeEnter = CurvedAnimation(
      parent: _enterController,
      curve: Curves.easeIn,
    );

    // EXIT
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 420),
      vsync: this,
    );

    _titleExit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _mainTitleExit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _contentExit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _fadeExit = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 160), () {
      if (mounted) _enterController.forward();
    });
  }

  @override
  void dispose() {
    _enterController.dispose();
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
          page: const Onboarding3(),
          fromColor: const Color(0xFF324F49), // Current background color
          toColor: const Color(0xFF6C4232), // Onboarding3 background color
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentOpacity = _isExiting ? _fadeExit : _fadeEnter;
    return Scaffold(
      backgroundColor: const Color(0xFF324F49),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
                child: PageIndicator(currentPage: 2, totalPages: 4),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: _isExiting ? _titleExit : _titleEnter,
                      child: FadeTransition(
                        opacity: contentOpacity,
                        child: Text(
                          'The second one,',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SlideTransition(
                      position: _isExiting ? _mainTitleExit : _mainTitleEnter,
                      child: FadeTransition(
                        opacity: contentOpacity,
                        child: Text(
                          'Mental\nWellbeing',
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35.h),
                    Expanded(
                      child: SlideTransition(
                        position: _isExiting ? _contentExit : _contentEnter,
                        child: FadeTransition(
                          opacity: contentOpacity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200.h,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/onboarding/mew1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Practice mindfulness and manage stress.',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Your mental health affects everything — nurture it daily for clarity, peace, and resilience.',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
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
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: GestureDetector(
                  onTap: _navigateToNext,
                  child: SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Image.asset(
                        'assets/images/onboarding/btn1.png',
                        fit: BoxFit.contain,
                      ),
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
