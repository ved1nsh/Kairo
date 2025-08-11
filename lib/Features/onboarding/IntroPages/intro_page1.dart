import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kairo/Features/onboarding/widgets/OB_button.dart';
import 'intro_page2.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> with TickerProviderStateMixin {
  static const String _fullText =
      'Ever wondered what it really takes to turn your life around? ';
  final Duration _perChar = const Duration(milliseconds: 70);
  final Duration _caretBlinkDur = const Duration(milliseconds: 600);

  late final AnimationController _typeController;
  late final Animation<int> _charCount;
  late final AnimationController _caretBlinkController;
  late final Animation<double> _caretOpacity;
  late final AnimationController _buttonFadeController;
  late final Animation<double> _buttonFade;
  late final AnimationController _pageFadeOutC;

  bool _typingDone = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _typeController = AnimationController(
      vsync: this,
      duration: _perChar * _fullText.length,
    );

    _charCount = StepTween(
      begin: 0,
      end: _fullText.length,
    ).animate(_typeController)..addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        setState(() => _typingDone = true);
        _buttonFadeController.forward();
      }
    });

    _caretBlinkController = AnimationController(
      vsync: this,
      duration: _caretBlinkDur,
    )..repeat(reverse: true);

    _caretOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _caretBlinkController, curve: Curves.easeInOut),
    );

    _buttonFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _buttonFade = CurvedAnimation(
      parent: _buttonFadeController,
      curve: Curves.easeInOut,
    );

    _pageFadeOutC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1,
    );

    // Slight delay before typing starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _typeController.forward();
      });
    });
  }

  @override
  void dispose() {
    _typeController.dispose();
    _caretBlinkController.dispose();
    _buttonFadeController.dispose();
    _pageFadeOutC.dispose();
    super.dispose();
  }

  void _goNext() {
    if (!_typingDone || _isNavigating) return;
    _isNavigating = true;
    _caretBlinkController.stop();
    _pageFadeOutC.reverse().whenComplete(() {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => const IntroPage2(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 28.sp,
      fontFamily: 'ClashDisplay',
      fontWeight: FontWeight.w300,
      color: Colors.black,
      height: 1.2,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE9CAC5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: FadeTransition(
          opacity: _pageFadeOutC,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _charCount,
                    builder: (_, __) {
                      final typedLen = _charCount.value.clamp(
                        0,
                        _fullText.length,
                      );
                      final typed = _fullText.substring(0, typedLen);

                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textStyle,
                          children: [
                            TextSpan(text: typed),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: _BlinkingCaret(
                                opacityAnim: _caretOpacity,
                                textStyle: textStyle,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              FadeTransition(
                opacity: _buttonFade,
                child: IgnorePointer(
                  ignoring: !_typingDone,
                  child: OnboardingButton(
                    text: "Let's find out",
                    onPressed: _goNext,
                  ),
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlinkingCaret extends StatelessWidget {
  final Animation<double> opacityAnim;
  final TextStyle textStyle;
  const _BlinkingCaret({required this.opacityAnim, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    final fs = textStyle.fontSize ?? 16;
    final lh = fs * (textStyle.height ?? 1.0);
    final caretHeight = lh * 0.9;
    final inset = (lh - caretHeight) / 2;
    return FadeTransition(
      opacity: opacityAnim,
      child: Container(
        margin: EdgeInsets.only(left: 2.w, top: inset, bottom: inset),
        width: 2.w,
        height: caretHeight,
        color: Colors.black,
      ),
    );
  }
}
