import 'package:flutter/material.dart';

class AnimatedSubtitle extends StatefulWidget {
  const AnimatedSubtitle({super.key});

  @override
  State<AnimatedSubtitle> createState() => _AnimatedSubtitleState();
}

class _AnimatedSubtitleState extends State<AnimatedSubtitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  final words = ["AI", "•", "Flutter", "•", "Creativity"];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(); // 🔁 keeps looping while on homepage

    _fadeAnimations = List.generate(words.length, (i) {
      final start = i / words.length;
      final end = (i + 1) / words.length;
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(words.length, (i) {
        return FadeTransition(
          opacity: _fadeAnimations[i],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              words[i],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 600 ? 16 : 28,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.2,
                fontFamily: 'Aeonik',
              ),
            ),
          ),
        );
      }),
    );
  }
}
