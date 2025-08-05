import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        bool isActive =
            index == (currentPage - 1); // Only current page is active
        return Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          width: 70.w,
          height: 3.h,
          decoration: BoxDecoration(
            color:
                isActive
                    ? Colors.black
                    : Colors.transparent, // Only current page is black
            border:
                !isActive
                    ? Border.all(color: Colors.black, width: 1.0)
                    : null, // Black border for all inactive pages
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      }),
    );
  }
}
