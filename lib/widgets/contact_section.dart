import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final String resumeUrl =
      "https://drive.google.com/file/d/1ZAMwV5ConAzMZffW3a0XDWxvO-Sxkpiy/view?usp=sharing";
  final String certificateUrl =
      "https://drive.google.com/file/d/1flnHFYNv6eHFfTBMuFzA0N9ZjAdDsCF9/view?usp=sharing";
  final String linkedInUrl =
      "https://www.linkedin.com/in/jothamemmanuelcheeran/";
  final String githubUrl = "https://github.com/Jotham0505";
  final String leetcodeUrl = "https://leetcode.com/u/Jotham_cheeran/";
  final String instagramUrl =
      "https://www.instagram.com/jothamemmanuelcheeran/";
  final String email = "jothamemmanuelcheeran@gmail.com";

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Every project tells a unique story,\n"
                "thoughtfully designed to blend seamlessly with its surroundings.\n"
                "Are you ready to craft some magic?",
                style: TextStyle(
                  fontSize: isMobile ? 14 : 48,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Aeonik',
                ),
              ),
              SizedBox(height: isMobile ? 20 : 40),
              Container(height: 1, color: Colors.black),
              SizedBox(height: isMobile ? 20 : 40),
              Row(
                children: [
                  Text(
                    "GET IN TOUCH",
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 16,
                      fontFamily: 'Aeonik',
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: isMobile ? 16 : 32,
                    backgroundColor: Colors.black,
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          await _launchUrl(linkedInUrl);
                        },
                        icon: Icon(
                          size: isMobile ? 16 : 24,
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 20 : 40),
        Container(
          width: double.infinity,
          color: Colors.black,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: isMobile ? 8 : 20,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.start,
                children: [
                  _buildContactInfo(isMobile),
                  SizedBox(width: isMobile ? 8 : 240),
                  _buildSocialLinks(isMobile),
                  SizedBox(width: isMobile ? 8 : 320),
                  _buildExtraInfo(isMobile),
                ],
              ),
              Divider(color: Colors.grey[800], thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Built with Flutter",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: isMobile ? 8 : 12,
                      fontFamily: 'Aeonik',
                    ),
                  ),
                  Text(
                    "Always learning, always building",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: isMobile ? 8 : 12,
                      fontFamily: 'Aeonik',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMobile ? SizedBox() : SizedBox(height: 16.0),
        Text(
          "+91 9663466229",
          style: TextStyle(
            fontSize: isMobile ? 8 : 12,
            color: Colors.grey[600],
            fontFamily: 'Aeonik',
          ),
        ),
        Text(
          "jothamemmanuelcheeran@gmail.com",
          style: TextStyle(
            fontSize: isMobile ? 7 : 16,
            color: Colors.white,
            fontFamily: 'Aeonik',
          ),
        ),
        SizedBox(height: isMobile ? 32.0 : 140.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.copyright, size: 8, color: Colors.grey),
            const SizedBox(width: 2),
            Text(
              "2025 Jotham's Portfolio",
              style: TextStyle(
                fontSize: isMobile ? 8 : 12,
                color: Colors.grey[600],
                fontFamily: 'Aeonik',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLinks(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _launchUrl(linkedInUrl),
          child: _socialLink("LinkedIn", isMobile),
        ),
        GestureDetector(
          onTap: () => _launchUrl(instagramUrl),
          child: _socialLink("Instagram", isMobile),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => _launchUrl(githubUrl),
              child: _socialText("Github", isMobile),
            ),
            SizedBox(width: isMobile ? 8 : 16),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: isMobile ? 10 : 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => _launchUrl(githubUrl),
                icon: Icon(
                  Icons.north_east,
                  color: Colors.black,
                  size: isMobile ? 16 : 32,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialLink(String text, bool isMobile) {
    return Row(
      children: [
        _socialText(text, isMobile),
        SizedBox(width: isMobile ? 4 : 16),
        Icon(Icons.north_east, size: isMobile ? 16 : 32, color: Colors.white),
      ],
    );
  }

  Widget _socialText(String text, bool isMobile) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.underline,
        fontSize: isMobile ? 14 : 48,
        color: Colors.white,
        fontFamily: 'Aeonik',
        decorationColor: Colors.white,
      ),
    );
  }

  Widget _buildExtraInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMobile ? SizedBox() : SizedBox(height: 16.0),
        _infoBlock("Location", "Bangalore, India", isMobile),
        const SizedBox(height: 8),
        _infoBlock("Interests", "AI · App Dev · API", isMobile),
      ],
    );
  }

  Widget _infoBlock(String title, String value, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 8 : 12,
            color: Colors.grey[600],
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isMobile ? 10 : 12,
            color: Colors.grey[400],
            fontFamily: 'Aeonik',
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
