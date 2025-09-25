import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResumeSection extends StatefulWidget {
  const ResumeSection({super.key});

  @override
  State<ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection> {
  final String resumeUrl = "https://yourdomain.com/resume.pdf";
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ismobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFAF9F6),
      ),

      padding: ismobile
          ? EdgeInsets.all(1)
          : EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;

          double headingFontSize = isMobile ? 32 : 64;
          double subHeadingFontSize = isMobile ? 20 : 48;
          double bodyFontSize = isMobile ? 13 : 16;

          final List<Widget> slides = [
            _buildCertificationsSlide(
              subHeadingFontSize,
              bodyFontSize,
              bodyFontSize,
            ),
            _buildLeetCodeSlide(subHeadingFontSize, bodyFontSize),
            _buildAchievementsSlide(subHeadingFontSize, bodyFontSize),
          ];

          return isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftColumn(headingFontSize, bodyFontSize, context),
                    const SizedBox(height: 30),
                    _buildRightColumn(slides, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildLeftColumn(
                        headingFontSize,
                        bodyFontSize,
                        context,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(child: _buildRightColumn(slides, isMobile)),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildLeftColumn(
    double headingFontSize,
    double bodyFontSize,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let’s Work Together.",
          style: TextStyle(
            fontSize: headingFontSize,
            color: Colors.black87,
            fontFamily: 'Aeonik',
          ),
        ),
        const SizedBox(height: 12),

        QuoteCard(
          text:
              "My journey into tech began with a fascination for creating engaging digital experiences. Today, I specialize in building intuitive mobile applications and making them smarter with artificial intelligence. I enjoy solving complex challenges to create products that are not only powerful but also simple and enjoyable for everyone to use.I thrive in collaborative environments where I can work with a team to bring ambitious ideas to life.",
        ),
        SizedBox(height: 30),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {},
          icon: const Icon(Icons.download, color: Colors.white),
          label: const Text(
            "Download Resume",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(List<Widget> slides, bool isMobile) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage("assets/images/cardbg.png"),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scrollable content inside each slide
              SizedBox(
                height: isMobile ? 300 : 275,
                child: PageView(
                  controller: _pageController,
                  children: slides
                      .map((slide) => SingleChildScrollView(child: slide))
                      .toList(),
                ),
              ),
              Divider(color: Colors.black12, thickness: 0.5),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  Opacity(
                    opacity: _currentPage == 0 ? 0.5 : 1.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _currentPage == 0
                          ? null
                          : () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text(
                        "Previous",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  // Next Button
                  Opacity(
                    opacity: _currentPage == slides.length - 1 ? 0.5 : 1.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _currentPage == slides.length - 1
                          ? null
                          : () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                      label: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Slide 1
  Widget _buildCertificationsSlide(
    double headingFontSize,
    double subHeadingFontSize,
    double bodyFontSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Certifications",
          style: TextStyle(fontSize: headingFontSize, fontFamily: 'Aeonik'),
        ),
        const SizedBox(height: 16),
        Text(
          '''• Flutter Essential Training - LinkedIn Learning
• Oracle Cloud Infrastructure 2025 Certified AI Foundations Associate
• Artificial Intelligence Fundamentals - IBM
• Oracle Cloud Infrastructure 2025 Certified Generative AI - Oracle
• Postman API Fundamentals - Postman
''',
          style: TextStyle(
            fontSize: bodyFontSize,
            height: 1.6,
            fontFamily: 'Aeonik',
          ),
        ),
      ],
    );
  }

  // Slide 2
  Widget _buildLeetCodeSlide(double subHeadingFontSize, double bodyFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "LeetCode Achievements",
          style: TextStyle(fontSize: subHeadingFontSize, fontFamily: 'Aeonik'),
        ),
        const SizedBox(height: 16),
        Text(
          '''• Solved 500+ problems across various difficulty levels.
• Consistently ranked in the top 10% in weekly contests.
• Earned the "Guardian" badge for solving daily challenges.
• Proficient in algorithms, data structures, and dynamic programming.''',
          style: TextStyle(
            fontSize: bodyFontSize,
            height: 1.6,
            fontFamily: 'Aeonik',
          ),
        ),
      ],
    );
  }

  // Slide 3
  Widget _buildAchievementsSlide(
    double subHeadingFontSize,
    double bodyFontSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Other Achievements",
          style: TextStyle(fontSize: subHeadingFontSize, fontFamily: 'Aeonik'),
        ),
        const SizedBox(height: 16),
        Text(
          '''• Winner of the 2024 University Hackathon for "Best Mobile App".
• Published a technical article on Medium with 10k+ views.
• Contributed to 3 open-source Flutter projects on GitHub.
• Speaker at the local Flutter developer meetup.''',
          style: TextStyle(
            fontSize: bodyFontSize,
            height: 1.6,
            fontFamily: 'Aeonik',
          ),
        ),
      ],
    );
  }
}

class QuoteCard extends StatelessWidget {
  final String text;
  const QuoteCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
