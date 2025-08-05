import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kairo/Components/ob_pg_indicator.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EF84), // Light green background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Page indicator at the top
              Container(
                margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
                child: PageIndicator(
                  currentPage: 1, // Current page is 2
                  totalPages: 4, // Total pages are 4
                ),
              ),

              // Main content area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "The first one," text
                    Text(
                      'The first one,',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'ClashDisplay',
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // "Physical Wellbeing" title
                    Text(
                      'Physical\nWellbeing',
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontFamily: 'ClashDisplay',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),

                    // Illustration placeholder (you'll need to add your actual illustration)
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/onboarding/pw_ob.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // "Stay active, eat well..." text
                    Text(
                      'Stay active, eat well, and rest enough.',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: 'ClashDisplay',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),

                    // Description text
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

              // Next button at the bottom
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF191B46),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/onboarding3');
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24.sp,
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
