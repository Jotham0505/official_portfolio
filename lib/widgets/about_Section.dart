import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_updated/widgets/what_i_do_widget.dart';

class Aboutsection extends StatelessWidget {
  const Aboutsection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 30 : 60,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          // Responsive sizes
          final double headingSize = isMobile ? 40 : 64;
          final double bodySize = isMobile ? 16 : 16;
          final double gapBetween = isMobile ? 20 : 40;

          Widget introWidget() => _buildIntro(isMobile, headingSize, bodySize)
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideX(begin: isMobile ? 0.0 : -0.2, curve: Curves.easeOut);

          Widget whatIDoWidget() => WhatIDoSection()
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .slideX(begin: isMobile ? 0.0 : 0.2, curve: Curves.easeOut);

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                introWidget(),
                SizedBox(height: gapBetween),
                whatIDoWidget(),
              ],
            );
          } else {
            final double leftWidth = constraints.maxWidth * 0.48;
            final double rightWidth = constraints.maxWidth * 0.48;
            final double spacer = constraints.maxWidth * 0.04;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: leftWidth, child: introWidget()),
                SizedBox(width: spacer),
                SizedBox(width: rightWidth, child: whatIDoWidget()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildIntro(bool isMobile, double headingSize, double bodySize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Me",
          style: TextStyle(
            fontSize: headingSize,
            fontFamily: 'Aeonik',
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "I’m Jotham Emmanuel Cheeran — a student developer from Vellore Institute of Technology, "
          "crafting fast, accessible mobile apps with Flutter and powering them with intelligence through Python and applied ML. "
          "I design end-to-end experiences — from clean, elegant UI to measurable outcomes — often bridging Flutter with "
          "FastAPI or Flask backends to deliver full-stack solutions. I thrive in collaborative, team-driven environments "
          "where creativity meets precision. Recent work includes semantic search powered by embeddings and "
          "iterative shipping with Git/GitHub workflows. Open to internships where impact, craft, and teamwork truly matter.",
          style: TextStyle(
            fontSize: bodySize,
            height: 1.6,
            fontFamily: 'Aeonik',
            color: Colors.white,
          ),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            // contact link
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Contact Me",
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: isMobile ? 16 : 18,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
