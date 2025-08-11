import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kairo/Features/onboarding/widgets/OB_button.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});
  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> with TickerProviderStateMixin {
  // Text blocks
  final String _block1 =
      "We've simplified the\n7 dimensions of wellness into 3 core categories.";
  final String _highlightPhrase = "3 core categories.";
  final String _block2 = "to make your journey clearer and more focused";
  final String _block3 =
      "Let's explore each category together, one step at a time.";

  // Speeds
  static const _perChar1 = Duration(milliseconds: 65);
  static const _perChar2 = Duration(milliseconds: 55);
  static const _perChar3 = Duration(milliseconds: 50);
  static const _startDelay = Duration(milliseconds: 100);

  // Controllers
  late final AnimationController _c1;
  late final Animation<int> _cc1;
  late final AnimationController _c2;
  late final Animation<int> _cc2;
  late final AnimationController _c3;
  late final Animation<int> _cc3;

  late final AnimationController _caretBlinkC;
  late final Animation<double> _caretOpacity;

  late final AnimationController _buttonFadeC;
  late final Animation<double> _buttonFade;

  bool _b1Done = false;
  bool _b2Done = false;
  bool _b3Done = false;

  @override
  void initState() {
    super.initState();

    // Block 1
    _c1 = AnimationController(
      vsync: this,
      duration: _perChar1 * _block1.length,
    );
    _cc1 = StepTween(begin: 0, end: _block1.length).animate(_c1)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          setState(() => _b1Done = true);
          _c2.forward();
        }
      });

    // Block 2
    _c2 = AnimationController(
      vsync: this,
      duration: _perChar2 * _block2.length,
    );
    _cc2 = StepTween(begin: 0, end: _block2.length).animate(_c2)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          setState(() => _b2Done = true);
          _c3.forward();
        }
      });

    // Block 3
    _c3 = AnimationController(
      vsync: this,
      duration: _perChar3 * _block3.length,
    );
    _cc3 = StepTween(begin: 0, end: _block3.length).animate(_c3)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          setState(() => _b3Done = true);
          _buttonFadeC.forward();
        }
      });

    // Caret blink (shared for current typing block)
    _caretBlinkC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _caretOpacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: _caretBlinkC, curve: Curves.easeInOut));

    // Button fade
    _buttonFadeC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _buttonFade = CurvedAnimation(
      parent: _buttonFadeC,
      curve: Curves.easeInOut,
    );

    // Start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(_startDelay, () {
        if (mounted) _c1.forward();
      });
    });
  }

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    _caretBlinkC.dispose();
    _buttonFadeC.dispose();
    super.dispose();
  }

  InlineSpan _caretFor(TextStyle style, bool active) {
    if (!active) return const WidgetSpan(child: SizedBox.shrink());
    final fs = style.fontSize ?? 16;
    final lh = fs * (style.height ?? 1.0);
    final caretH = lh * 0.9;
    final inset = (lh - caretH) / 2;
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: FadeTransition(
        opacity: _caretOpacity,
        child: Container(
          margin: EdgeInsets.only(left: 2.w, top: inset, bottom: inset),
          width: 2.w,
          height: caretH,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _reserveHeight({
    required String fullText,
    required TextStyle style,
    required Widget child,
    TextAlign align = TextAlign.left,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ghost = Opacity(
          opacity: 0,
          child: SizedBox(
            width: constraints.maxWidth,
            child: Text(
              fullText,
              style: style,
              textAlign: align,
              softWrap: true,
            ),
          ),
        );
        return Stack(alignment: Alignment.topLeft, children: [ghost, child]);
      },
    );
  }

  RichText _buildBlock1(TextStyle base, int visible) {
    // Highlight phrase
    final hiStart = _block1.indexOf(_highlightPhrase);
    final hiEnd = hiStart + _highlightPhrase.length;
    final spans = <InlineSpan>[];

    if (visible > 0) {
      if (visible <= hiStart) {
        spans.add(TextSpan(text: _block1.substring(0, visible)));
      } else if (visible <= hiEnd) {
        spans.add(TextSpan(text: _block1.substring(0, hiStart)));
        spans.add(
          TextSpan(
            text: _block1.substring(hiStart, visible),
            style: base.copyWith(
              color: const Color(0xFFFF1900),
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      } else {
        spans.add(TextSpan(text: _block1.substring(0, hiStart)));
        spans.add(
          TextSpan(
            text: _block1.substring(hiStart, hiEnd),
            style: base.copyWith(
              color: const Color(0xFFFF1900),
              fontWeight: FontWeight.w700,
            ),
          ),
        );
        spans.add(TextSpan(text: _block1.substring(hiEnd, visible)));
      }
    }

    spans.add(_caretFor(base, !_b1Done));
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(style: base, children: spans),
      softWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final block1Style = TextStyle(
      fontSize: 28.sp, // reduced per request
      fontFamily: 'ClashDisplay',
      fontWeight: FontWeight.w300,
      color: Colors.black,
      height: 1.2,
    );
    final block2Style = TextStyle(
      fontSize: 28.sp,
      fontFamily: 'ClashDisplay',
      fontWeight: FontWeight.w300,
      color: Colors.black,
      height: 1.2,
    );
    final block3Style = TextStyle(
      fontSize: 26.sp,
      fontFamily: 'ClashDisplay',
      fontWeight: FontWeight.w300,
      color: Colors.black,
      height: 1.3,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE9CAC5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            SizedBox(height: 125.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Block 1
                  AnimatedBuilder(
                    animation: _cc1,
                    builder: (_, __) {
                      final v = _cc1.value;
                      return _reserveHeight(
                        fullText: _block1,
                        style: block1Style,
                        child: _buildBlock1(block1Style, v),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  AnimatedOpacity(
                    opacity: _b1Done ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 20.w,
                      height: 1.5.h,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Block 2
                  if (_b1Done)
                    AnimatedBuilder(
                      animation: _cc2,
                      builder: (_, __) {
                        final v = _cc2.value;
                        final typed = _block2.substring(
                          0,
                          v.clamp(0, _block2.length),
                        );
                        final spans = <InlineSpan>[
                          if (typed.isNotEmpty) TextSpan(text: typed),
                          _caretFor(block2Style, !_b2Done),
                        ];
                        return _reserveHeight(
                          fullText: _block2,
                          style: block2Style,
                          child: RichText(
                            text: TextSpan(style: block2Style, children: spans),
                          ),
                        );
                      },
                    ),
                  if (_b2Done) SizedBox(height: 100.h),
                  // Block 3 (center)
                  if (_b2Done)
                    AnimatedBuilder(
                      animation: _cc3,
                      builder: (_, __) {
                        final v = _cc3.value;
                        final typed = _block3.substring(
                          0,
                          v.clamp(0, _block3.length),
                        );
                        final spans = <InlineSpan>[
                          if (typed.isNotEmpty) TextSpan(text: typed),
                          _caretFor(block3Style, !_b3Done),
                        ];
                        return _reserveHeight(
                          fullText: _block3,
                          style: block3Style,
                          align: TextAlign.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(style: block3Style, children: spans),
                          ),
                        );
                      },
                    ),
                  if (_b3Done) SizedBox(height: 60.h),
                ],
              ),
            ),
            FadeTransition(
              opacity: _buttonFade,
              child: IgnorePointer(
                ignoring: !_b3Done,
                child: OnboardingButton(
                  text: "Let's find out",
                  onPressed: () {
                    if (_b3Done) {
                      _caretBlinkC.stop();
                      Navigator.pushNamed(context, '/onboarding1');
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
