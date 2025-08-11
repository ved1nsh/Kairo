import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/ob_pg_indicator.dart';
import '../widgets/slide_page_route.dart';
import 'onboarding_4.dart';
// TODO: import onboarding_4.dart (adjust path) when ready
// import 'onboarding_4.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3>
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

  Future<void> _goNext() async {
    if (_isExiting) return;
    setState(() {
      _isExiting = true; // Add setState here!
    });
    await _exitController.forward();
    if (!mounted) return;
    Navigator.push(
      context,
      ComponentSlideTransition(
        page: const Onboarding4(),
        fromColor: const Color(0xFF6C4232),
        toColor: const Color(0xFFE9CAC5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contentOpacity = _isExiting ? _fadeExit : _fadeEnter;
    return Scaffold(
      backgroundColor: const Color(0xFF6C4232),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h, bottom: 32.h),
                child: const PageIndicator(currentPage: 3, totalPages: 4),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _isExiting ? _titleExit : _titleEnter,
                      child: FadeTransition(
                        opacity: contentOpacity,
                        child: Text(
                          'The last one,',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SlideTransition(
                      position: _isExiting ? _mainTitleExit : _mainTitleEnter,
                      child: FadeTransition(
                        opacity: contentOpacity,
                        child: Text(
                          'Spiritual & Social \n Wellbeing',
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Expanded(
                      child: SlideTransition(
                        position: _isExiting ? _contentExit : _contentEnter,
                        child: FadeTransition(
                          opacity: contentOpacity,
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/onboarding/ssw1.png',
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (_, __, ___) => const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Feel connected — to yourself, others, and something greater.',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: 'ClashDisplay',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  height: 1.35,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                "Whether it's faith, values, community, or close bonds.",
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
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: GestureDetector(
                  onTap: _goNext,
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
