import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- add this

class ResumeSection extends StatefulWidget {
  const ResumeSection({super.key});

  @override
  State<ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection> {
  final String resumeUrl =
      "https://drive.google.com/file/d/1ZAMwV5ConAzMZffW3a0XDWxvO-Sxkpiy/view?usp=sharing";
  final String certificateUrl =
      "https://drive.google.com/file/d/1flnHFYNv6eHFfTBMuFzA0N9ZjAdDsCF9/view?usp=sharing";
  final String linkedInUrl =
      "https://www.linkedin.com/in/jothamemmanuelcheeran/";
  final String githubUrl = "https://github.com/Jotham0505";
  final String leetcodeUrl = "https://leetcode.com/u/Jotham_cheeran/";
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

  // helper to open URL in browser/external app
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
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
          ? const EdgeInsets.all(1)
          : const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;

          double headingFontSize = isMobile ? 32 : 64;
          double subHeadingFontSize = isMobile ? 20 : 48;
          double bodyFontSize = isMobile ? 12 : 14;

          final List<Widget> slides = [
            _buildLeetCodeSlide(subHeadingFontSize, bodyFontSize),
            _buildCertificationsSlide(
              subHeadingFontSize,
              bodyFontSize,
              bodyFontSize,
            ),
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
        const SizedBox(height: 30),
        Row(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _openUrl(resumeUrl), // <--- open resume
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text(
                "Download Resume",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () =>
                  _openUrl(leetcodeUrl), // <--- open LeetCode profile
              icon: Icon(FontAwesomeIcons.code, color: Colors.white),
              label: const Text(
                "LeetCode Profile",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
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
        Text('''• Flutter Essential Training - LinkedIn Learning
• Oracle Cloud Infrastructure 2025 Certified AI Foundations Associate
• Artificial Intelligence Fundamentals - IBM
• Oracle Cloud Infrastructure 2025 Certified Generative AI - Oracle
• Postman API Fundamentals - Postman
''', style: TextStyle(fontSize: 14, height: 1.5, fontFamily: 'Aeonik')),
      ],
    );
  }

  // Slide 2
  Widget _buildLeetCodeSlide(double subHeadingFontSize, double bodyFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Internship Experience",
          style: TextStyle(fontSize: subHeadingFontSize, fontFamily: 'Aeonik'),
        ),
        const SizedBox(height: 13),
        Text(
          "Flutter Development Intern at Peece Wellness Technologies Pvt. Ltd.",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            fontFamily: 'Aeonik',
          ),
        ),
        const SizedBox(height: 13),
        Text(
          '''• Restructured the Flutter app using the GETx pattern, improving modularity.
• Designed UI and UX for Rewards and Profile, boosting navigation efficiency.
• Integrated Google Places API, reducing location search latency.
• Improved in-app reviews, sharing, and asset handling, raising referrals and engagement.''',
          style: TextStyle(fontSize: 14, height: 1.5, fontFamily: 'Aeonik'),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _openUrl(certificateUrl), // <--- open certificate
          icon: const Icon(Icons.download, color: Colors.white),
          label: const Text(
            "Download Certificate",
            style: TextStyle(color: Colors.white, fontSize: 14),
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
            const SizedBox(width: 8),
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
