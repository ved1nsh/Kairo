import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kairo/Features/onboarding/widgets/OB_button.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> with TickerProviderStateMixin {
  // Typewriter for title
  static const String _title =
      'Studies show there are 7 dimensions of human wellness.';
  // Slower typing speed (was 55ms)
  static const Duration _perChar = Duration(milliseconds: 80);
  static const Duration _caretBlinkDur = Duration(milliseconds: 600);
  static const Duration _postTypeFadeDelay = Duration(milliseconds: 250);

  late final AnimationController _typeController;
  late final Animation<int> _charCount;
  late final AnimationController _caretBlinkController;
  late final Animation<double> _caretOpacity;

  // Content fade (image + button AFTER typing)
  late final AnimationController _contentFadeC;
  late final Animation<double> _imageFade;
  late final Animation<double> _buttonFade;

  bool _typingDone = false;

  @override
  void initState() {
    super.initState();

    _typeController = AnimationController(
      vsync: this,
      duration: _perChar * _title.length,
    );

    _charCount = StepTween(
      begin: 0,
      end: _title.length,
    ).animate(_typeController)..addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        setState(() => _typingDone = true);
        // Slight delay before starting image & button fade
        Future.delayed(_postTypeFadeDelay, () {
          if (mounted) _contentFadeC.forward();
        });
      }
    });

    _caretBlinkController = AnimationController(
      vsync: this,
      duration: _caretBlinkDur,
    )..repeat(reverse: true);

    _caretOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _caretBlinkController, curve: Curves.easeInOut),
    );

    _contentFadeC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _imageFade = CurvedAnimation(
      parent: _contentFadeC,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    );
    _buttonFade = CurvedAnimation(
      parent: _contentFadeC,
      curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
    );

    // Start only typing (and caret) after slight delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 80), () {
        if (!mounted) return;
        _typeController.forward();
      });
    });
  }

  @override
  void dispose() {
    _typeController.dispose();
    _caretBlinkController.dispose();
    _contentFadeC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 28.sp,
      fontFamily: 'ClashDisplay',
      fontWeight: FontWeight.w300,
      color: Colors.black,
      height: 1.2,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE9CAC5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            SizedBox(height: 125.h),
            // Fixed-height typewriter (image below won't shift)
            _FixedHeightTypewriter(
              fullText: _title,
              style: titleStyle,
              charCount: _charCount,
              caret: _BlinkingCaret(
                opacityAnim: _caretOpacity,
                textStyle: titleStyle,
              ),
            ),

            // Image fades in
            Expanded(
              child: FadeTransition(
                opacity: _imageFade,
                child: Image.asset(
                  'assets/images/onboarding/wellness.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 60.h),
            // Button fades in (slightly later)
            Padding(
              padding: EdgeInsets.only(bottom: 100.h),
              child: FadeTransition(
                opacity: _buttonFade,
                child: OnboardingButton(
                  text: 'Take me through them',
                  onPressed: () {
                    if (_typingDone) {
                      Navigator.pushNamed(context, '/intro3');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reserves final text height so layout below stays fixed
class _FixedHeightTypewriter extends StatelessWidget {
  final String fullText;
  final TextStyle style;
  final Animation<int> charCount;
  final Widget caret;
  const _FixedHeightTypewriter({
    required this.fullText,
    required this.style,
    required this.charCount,
    required this.caret,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Invisible full text to reserve space
        final full = Opacity(
          opacity: 0,
          child: SizedBox(
            width: constraints.maxWidth,
            child: Text(fullText, style: style, softWrap: true),
          ),
        );

        return AnimatedBuilder(
          animation: charCount,
          builder: (_, __) {
            final typedLen = charCount.value.clamp(0, fullText.length);
            final typed = fullText.substring(0, typedLen);

            final visible = SizedBox(
              width: constraints.maxWidth,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: style,
                  children: [
                    TextSpan(text: typed),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: caret,
                    ),
                  ],
                ),
              ),
            );

            return Stack(
              alignment: Alignment.topLeft,
              children: [full, visible],
            );
          },
        );
      },
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
