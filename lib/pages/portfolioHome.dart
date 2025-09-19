import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:portfolio_updated/widgets/about_Section.dart';
import 'package:portfolio_updated/widgets/contact_section.dart';
import 'package:portfolio_updated/widgets/projects.dart';
import 'package:portfolio_updated/widgets/resume_section.dart';
import 'package:portfolio_updated/widgets/staggered_text.dart';
import 'package:portfolio_updated/widgets/tech_grid.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _staggerController;
  late AnimationController _arrowController;
  final ScrollController _scrollController = ScrollController();

  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  String _hoveredNav = "";

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();

    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _staggerController.dispose();
    _arrowController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final RenderBox scrollBox =
          _scrollController.position.context.storageContext.findRenderObject()
              as RenderBox;

      final targetOffset = box
          .localToGlobal(Offset.zero, ancestor: scrollBox)
          .dy;

      _scrollController.animateTo(
        _scrollController.offset + targetOffset - 80,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: Stack(
          children: [
            // --- Watermark background ---
            Positioned.fill(
              child: Opacity(
                opacity: 1.0,
                child: Image.asset("assets/images/bg1.png", fit: BoxFit.cover),
              ),
            ),

            // --- Scrollable content ---
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Navigation
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Rotating circular logo
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    RotationTransition(
                                      turns: _rotationController,
                                      child: CustomPaint(
                                        size: const Size(48, 48),
                                        painter: CircularTextPainter(
                                          text: "JOTHAM • EMMANUEL • CHEERAN •",
                                          textStyle:
                                              GoogleFonts.playfairDisplay(
                                                fontSize: 8,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: const AssetImage(
                                        "assets/images/logo.png",
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            // Name & Role
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Jotham Cheeran",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Aeonik',
                                  ),
                                ),
                                Text(
                                  "Flutter Developer",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontFamily: 'Aeonik',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (!isMobile)
                          Row(
                            children: [
                              _navItem("Home"),
                              _navItem("About me"),
                              _navItem("Skills"),
                              _navItem("Project"),
                              _navItem("Resume"),
                            ],
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {},
                          ),
                      ],
                    ),
                  ),

                  // ---------- Hero Section ----------
                  AnimatedBuilder(
                    animation: _staggerController,
                    builder: (context, child) {
                      final value = _staggerController.value;

                      return Column(
                        children: [
                          Transform.scale(
                            scale: Curves.easeOutBack.transform(
                              value.clamp(0.0, 0.4) / 0.4,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ScaleTransition(
                                  scale: Tween(begin: 0.9, end: 1.1).animate(
                                    CurvedAnimation(
                                      parent: _pulseController,
                                      curve: Curves.easeInOut,
                                    ),
                                  ),
                                  child: Container(
                                    width: 260,
                                    height: 260,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.08),
                                          Colors.transparent,
                                        ],
                                        stops: const [0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 120,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile2.png',
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          Opacity(
                            opacity: Curves.easeIn.transform(
                              ((value - 0.3).clamp(0.0, 0.3)) / 0.3,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Pixels. Code. Impact.",
                                  style: TextStyle(
                                    fontSize: isMobile ? 28 : 40,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontFamily: 'Aeonik',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                AnimatedSubtitle(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          Opacity(
                            opacity: Curves.easeIn.transform(
                              ((value - 0.55).clamp(0.0, 0.45)) / 0.45,
                            ),
                            child: SizedBox(
                              width: isMobile ? screenWidth * 0.85 : 650,
                              child: Text(
                                "As an AI and Flutter developer, I specialize in building smart, scalable, and beautifully designed applications that blend innovation with performance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  color: Colors.grey[700],
                                  height: 1.6,
                                  fontFamily: 'Aeonik',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          FadeTransition(
                            opacity: Tween(begin: 0.4, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _arrowController,
                                curve: Curves.easeInOut,
                              ),
                            ),
                            child: SlideTransition(
                              position:
                                  Tween<Offset>(
                                    begin: const Offset(0, 0.2),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: _arrowController,
                                      curve: Curves.easeInOut,
                                    ),
                                  ),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 40,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 50),

                  // About Section
                  Container(key: aboutKey, child: const Aboutsection()),
                  const SizedBox(height: 50),

                  // Skills Section
                  Container(key: skillsKey, child: const TechStackShowcase()),
                  const SizedBox(height: 50),

                  // Projects Section
                  Container(key: projectsKey, child: const ProjectAccordion()),

                  // Resume Section
                  Container(
                    key: resumeKey,
                    child: const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: ResumeSection(),
                    ),
                  ),

                  Divider(thickness: 0.3, color: Colors.grey[300]),

                  // Contact Section
                  Container(key: contactKey, child: const ContactSection()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title) {
    final isHovered = _hoveredNav == title;
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredNav = title),
      onExit: (_) => setState(() => _hoveredNav = ""),
      child: GestureDetector(
        onTap: () {
          switch (title) {
            case "About me":
              _scrollToSection(aboutKey);
              break;
            case "Skills":
              _scrollToSection(skillsKey);
              break;
            case "Project":
              _scrollToSection(projectsKey);
              break;
            case "Resume":
              _scrollToSection(resumeKey);
              break;
            default:
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOutCubic,
              );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isHovered ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: isHovered ? Colors.black : Colors.grey[800],
              fontFamily: 'Aeonik',
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

class CircularTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;

  CircularTextPainter({required this.text, required this.textStyle});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2.4;
    final totalAngle = 2 * math.pi;
    final perCharAngle = totalAngle / text.length;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final angle = i * perCharAngle - math.pi / 2;

      final textPainter = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      final offset = Offset(
        size.width / 2 + radius * math.cos(angle) - textPainter.width / 2,
        size.height / 2 + radius * math.sin(angle) - textPainter.height / 2,
      );

      canvas.save();
      canvas.translate(
        offset.dx + textPainter.width / 2,
        offset.dy + textPainter.height / 2,
      );
      canvas.rotate(angle + math.pi / 2);
      canvas.translate(-textPainter.width / 2, -textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CircularTextPainter oldDelegate) => false;
}
