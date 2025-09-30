import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TechStackShowcase extends StatelessWidget {
  static const List<Map<String, String>> techStack = [
    {"name": "Flutter", "icon": "assets/images/FLUTTER.png"},
    {"name": "FastAPI", "icon": "assets/images/FASTAPI.png"},
    {"name": "Flask", "icon": "assets/images/FLASK.png"},
    {"name": "Python", "icon": "assets/images/Python.png"},
    {"name": "Firebase", "icon": "assets/images/FIREBASE.png"},
    {"name": "Supabase", "icon": "assets/images/SUPABASE.png"},
    {"name": "GitHub", "icon": "assets/images/GITHUB.png"},
    {"name": "TensorFlow Lite", "icon": "assets/images/VS CODE.png"},
    {"name": "Java", "icon": "assets/images/JAVA.png"},
    {"name": "Dart", "icon": "assets/images/DART.png"},
    {"name": "MongoDB", "icon": "assets/images/MONGODB.png"},
    {"name": "AWS", "icon": "assets/images/AWS.png"},
  ];

  const TechStackShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double headingSize = isMobile ? 40 : 64;
    final double bodySize = isMobile ? 16 : 16;
    final double gapBetween = isMobile ? 20 : 40;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                "Tech Stack and Tools",
                style: TextStyle(fontSize: headingSize, fontFamily: 'Aeonik'),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 3 : 6,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isMobile ? 0.8 : 0.85,
            ),
            itemCount: techStack.length,
            itemBuilder: (context, index) {
              final tech = techStack[index];
              return _TechCard(name: tech["name"]!, iconPath: tech["icon"]!)
                  .animate()
                  .fadeIn(duration: 500.ms, delay: (100 * index).ms)
                  .slideY(begin: 0.3, curve: Curves.easeOut);
            },
          ),
        ],
      ),
    );
  }
}

class _TechCard extends StatefulWidget {
  final String name;
  final String iconPath;

  const _TechCard({required this.name, required this.iconPath});

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0)
          ..scale(_isHovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.65),
              Colors.white.withOpacity(0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF8E9BAE).withOpacity(0.8)
                : Colors.black12,
            width: 0.6,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Flexible(
                    child: Image.asset(
                      widget.iconPath,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  //const SizedBox(height: 10),
                  /*Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: 0.8,
                      fontFamily: 'Aeonik',
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
