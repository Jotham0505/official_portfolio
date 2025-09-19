import 'package:flutter/material.dart';

class ProjectAccordion extends StatefulWidget {
  const ProjectAccordion({super.key});

  @override
  State<ProjectAccordion> createState() => _ProjectAccordionState();
}

class _ProjectAccordionState extends State<ProjectAccordion> {
  int? expandedIndex;

  // Create one ScrollController per project
  late List<ScrollController> _controllers;

  final projects = [
    {
      "title": "Tea Factory Outlet Inventory App",
      "details": "Details about branding projects here.",
      "images": [
        "assets/images/tea8.png",
        "assets/images/tea4.png",
        "assets/images/tea1.png",
        "assets/images/tea6.png",
        "assets/images/tea2.png",
        "assets/images/tea7.png",
        "assets/images/tea3.png",
        "assets/images/tea5.png",
      ],
    },
    {
      "title": "Perplex - Flutter RAG App with FastAPI & Google Gemini",
      "details": "Details about web design projects here.",
      "images": ["assets/images/logo.png", "assets/images/logo.png"],
    },
    {
      "title": "Insigno - Inclusive Learning App",
      "details":
          """• Developed a learning application for Gujarati, Mathematics, and Science with integrated Indian Sign Language interpretation for accessibility.

• Implemented text-to-sign, speech-to-sign, and sign-to-text/speech conversion tools, enabling seamless communication.

• Designed interactive exercises, quizzes, and progress tracking dashboards for students, teachers, and parents.

• Created and structured 10+ curriculum-aligned learning modules with visual aids and sign-based explanations.

• Focused on inclusive education by combining AI-driven sign language translation with engaging e-learning methods.""",
      "images": [
        "assets/images/insigno1.png",
        "assets/images/insigno2.png",
        "assets/images/insigno3.png",
        "assets/images/insigno4.png",
        "assets/images/insigno5.png",
        "assets/images/insigno6.png",
      ],
    },
    {
      "title": "FinBase",
      "details":
          """• Dark mode UI with purple and teal highlights for a sleek, modern fintech feel.

• Consistent navigation with a custom bottom navigation bar across all screens.

• Use of rounded cards, shadows, and colorful icons to create a friendly yet professional design.

• Gamified elements (points, leagues, badges) to keep users motivated and engaged.

• Data visualization through custom line and bar charts for an intuitive understanding of financial habits.""",
      "images": [
        "assets/images/finbase5.png",
        "assets/images/finbase6.png",
        "assets/images/finbase7.png",
        "assets/images/finbase8.png",
        "assets/images/finbase1.png",
        "assets/images/finbase2.png",
        "assets/images/finbase3.png",
        "assets/images/finbase4.png",
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    // initialize a ScrollController for each project
    _controllers = List.generate(projects.length, (_) => ScrollController());
  }

  void _scrollLeft(int index) {
    final controller = _controllers[index];
    controller.animateTo(
      controller.offset - 300,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight(int index) {
    final controller = _controllers[index];
    controller.animateTo(
      controller.offset + 300,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double headingSize = isMobile ? 40 : 64;
    final double bodySize = isMobile ? 16 : 16;
    final double gapBetween = isMobile ? 20 : 40;
    return Container(
      color: Colors.black, // background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Take Complete charge of your Projects",
              style: TextStyle(
                fontSize: headingSize,
                color: Colors.white,
                fontFamily: 'Aeonik',
              ),
            ),
          ),
          const SizedBox(height: 40),
          Column(
            children: List.generate(projects.length, (index) {
              final project = projects[index];
              final isExpanded = expandedIndex == index;

              return Column(
                children: [
                  ListTile(
                    title: Text(
                      project["title"] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                    trailing: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: isExpanded ? 0.25 : 0,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        expandedIndex = isExpanded ? null : index;
                      });
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isExpanded
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project["details"] as String,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 500,
                                      child: ListView.separated(
                                        controller: _controllers[index],
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            (project["images"] as List<String>)
                                                .length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 16),
                                        itemBuilder: (context, imgIndex) {
                                          final img =
                                              (project["images"]
                                                  as List<String>)[imgIndex];
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  blurRadius: 12,
                                                  offset: const Offset(0, 6),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.asset(
                                                img,
                                                width: 260,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Left Floating Button
                                    Positioned(
                                      left: 0,
                                      top: 200,
                                      child: FloatingActionButton(
                                        mini: true,
                                        backgroundColor: Colors.white
                                            .withOpacity(0.7),
                                        onPressed: () => _scrollLeft(index),
                                        child: const Icon(
                                          Icons.chevron_left,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    // Right Floating Button
                                    Positioned(
                                      right: 0,
                                      top: 200,
                                      child: FloatingActionButton(
                                        mini: true,
                                        backgroundColor: Colors.white
                                            .withOpacity(0.7),
                                        onPressed: () => _scrollRight(index),
                                        child: const Icon(
                                          Icons.chevron_right,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const Divider(color: Colors.white24, thickness: 0.5),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
