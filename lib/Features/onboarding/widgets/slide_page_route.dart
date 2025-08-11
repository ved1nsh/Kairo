import 'package:flutter/material.dart';

class ComponentSlideTransition extends PageRouteBuilder {
  final Widget page;
  final Color fromColor;
  final Color toColor;

  ComponentSlideTransition({
    required this.page,
    required this.fromColor,
    required this.toColor,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: const Duration(milliseconds: 800),
         reverseTransitionDuration: const Duration(milliseconds: 800),
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           // Background color transition
           return AnimatedBuilder(
             animation: animation,
             builder: (context, child) {
               return Container(
                 color: Color.lerp(fromColor, toColor, animation.value),
                 child: child,
               );
             },
             child: child,
           );
         },
       );
}
