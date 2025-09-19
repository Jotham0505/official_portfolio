import 'dart:math';
import 'package:flutter/material.dart';

class WhatIDoSection extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      "title": "Bridging UI & API",
      "icon": Icons.developer_board,
      "description":
          "Seamlessly connecting front-end design with backend APIs for smooth experiences.",
    },
    {
      "title": "Creative Problem-Solving",
      "icon": Icons.lightbulb_outline,
      "description":
          "Designing innovative solutions for complex technical challenges.",
    },
    {
      "title": "Iterative Development",
      "icon": Icons.loop,
      "description":
          "Agile, step-by-step improvements for rapid and reliable delivery.",
    },
    {
      "title": "From Vision to Value",
      "icon": Icons.diamond_outlined,
      "description":
          "Transforming ideas into tangible business outcomes that create value.",
    },
  ];

  WhatIDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: isMobile ? 1.2 : 1.1,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return _FlipCard(
                title: service["title"]!,
                iconData: service["icon"]!,
                description: service["description"]!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FlipCard extends StatefulWidget {
  final String title;
  final IconData iconData;
  final String description;

  const _FlipCard({
    required this.title,
    required this.iconData,
    required this.description,
  });

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
          _isFlipped = true;
        });
      },
      onExit: (_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              _isHovered = false;
              _isFlipped = false;
            });
          }
        });
      },
      child: GestureDetector(
        onTap: () => setState(() => _isFlipped = !_isFlipped),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: _isHovered
              ? (Matrix4.identity()..scale(1.05))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: Colors.white, // Always white border
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, anim) {
              final rotate = Tween(begin: pi, end: 0.0).animate(anim);
              return AnimatedBuilder(
                animation: rotate,
                builder: (context, childWidget) {
                  final isUnder = (ValueKey(_isFlipped) != childWidget!.key);
                  var tilt = ((anim.value - 0.5).abs() - 0.5) * 0.003;
                  tilt *= isUnder ? -1.0 : 1.0;
                  final value = isUnder
                      ? min(rotate.value, pi / 2)
                      : rotate.value;
                  return Transform(
                    transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
                    alignment: Alignment.center,
                    child: childWidget,
                  );
                },
                child: child,
              );
            },
            child: _isFlipped
                ? _BackCard(
                    description: widget.description,
                    key: const ValueKey(true),
                  )
                : _FrontCard(
                    title: widget.title,
                    iconData: widget.iconData,
                    key: const ValueKey(false),
                  ),
          ),
        ),
      ),
    );
  }
}

class _FrontCard extends StatelessWidget {
  final String title;
  final IconData iconData;

  const _FrontCard({required this.title, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: Colors.white, // White icons
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Aeonik', // Aeonik font
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  final String description;

  const _BackCard({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Aeonik',
            fontSize: 14,
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
