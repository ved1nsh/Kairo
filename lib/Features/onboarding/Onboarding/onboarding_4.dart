import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kairo/Features/onboarding/widgets/OB_button.dart';
import '../widgets/ob_pg_indicator.dart';

class Onboarding4 extends StatefulWidget {
  const Onboarding4({super.key});

  @override
  State<Onboarding4> createState() => _Onboarding4State();
}

class _Onboarding4State extends State<Onboarding4>
    with TickerProviderStateMixin {
  // Entrance (EXACTLY like onboarding_2 and onboarding_3)
  late AnimationController _enterController;
  late Animation<Offset> _titleEnter;
  late Animation<Offset> _mainContentEnter;
  late Animation<Offset> _footerEnter;
  late Animation<double> _fadeEnter;

  // Exit (EXACTLY like onboarding_2 and onboarding_3)
  late AnimationController _exitController;
  late Animation<Offset> _titleExit;
  late Animation<Offset> _mainContentExit;
  late Animation<Offset> _footerExit;
  late Animation<double> _fadeExit;

  bool _isExiting = false;

  @override
  void initState() {
    super.initState();

    // ENTRANCE (same timing as other pages)
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

    _mainContentEnter = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: const Interval(0.25, 0.8, curve: Curves.easeOut),
      ),
    );

    _footerEnter = Tween<Offset>(
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

    // EXIT (same timing as other pages)
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

    _mainContentExit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _footerExit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _fadeExit = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    // Start entrance animation (same delay as other pages)
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

  // Exit animation methods (same pattern as other pages)
  Future<void> _handleSignUp() async {
    if (_isExiting) return;
    setState(() {
      _isExiting = true;
    });
    await _exitController.forward();
    if (!mounted) return;
    Navigator.pushNamed(context, '/signup');
  }

  Future<void> _handleSignIn() async {
    if (_isExiting) return;
    setState(() {
      _isExiting = true;
    });
    await _exitController.forward();
    if (!mounted) return;
    Navigator.pushNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    // Same opacity logic as other pages
    final contentOpacity = _isExiting ? _fadeExit : _fadeEnter;

    return Scaffold(
      backgroundColor: const Color(0xFFE9CAC5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            children: [
              // Page Indicator (doesn't animate)
              Container(
                margin: EdgeInsets.only(top: 40.h, bottom: 60.h),
                child: const PageIndicator(currentPage: 4, totalPages: 4),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Title (slides from left, exits left)
                    SlideTransition(
                      position: _isExiting ? _titleExit : _titleEnter,
                      child: FadeTransition(
                        opacity: contentOpacity,
                        child: Text(
                          'You are just one\nstep away....',
                          style: TextStyle(
                            fontSize: 44.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),

                    // Main Content (slides from right, exits right)
                    Expanded(
                      child: SlideTransition(
                        position:
                            _isExiting ? _mainContentExit : _mainContentEnter,
                        child: FadeTransition(
                          opacity: contentOpacity,
                          child: Column(
                            children: [
                              const Spacer(),

                              // Centered content
                              Column(
                                children: [
                                  Text(
                                    'Create your account and let\'s begin.',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: 'ClashDisplay',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      height: 1.3,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 20.h),

                                  OnboardingButton(
                                    text: 'Sign up with Google',
                                    onPressed: _handleSignUp,
                                  ),

                                  SizedBox(height: 50.h),

                                  Text(
                                    'Or just log in — We\'ve missed you.',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontFamily: 'ClashDisplay',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      height: 1.3,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  SizedBox(height: 20.h),

                                  OnboardingButton(
                                    text: 'Sign in with Google',
                                    onPressed: _handleSignIn,
                                  ),
                                ],
                              ),

                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Footer Text (slides from right, exits right)
                    SlideTransition(
                      position: _isExiting ? _footerExit : _footerEnter,
                      child: FadeTransition(
                        opacity: contentOpacity,
                        child: Column(
                          children: [
                            Text(
                              'Let\'s start building the life you truly want —',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'ClashDisplay',
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  height: 1.4,
                                ),
                                children: [
                                  const TextSpan(text: 'one '),
                                  TextSpan(
                                    text: 'choice',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontFamily: 'ClashDisplay',
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF6C4232),
                                    ),
                                  ),
                                  const TextSpan(text: ',\none '),
                                  TextSpan(
                                    text: 'habit',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontFamily: 'ClashDisplay',
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF6C4232),
                                    ),
                                  ),
                                  const TextSpan(text: ',\none '),
                                  TextSpan(
                                    text: 'day at a time',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontFamily: 'ClashDisplay',
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF6C4232),
                                    ),
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
