import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'WelcomePage.dart';
import 'Helper.dart';

class AboutMePage extends StatelessWidget {
  final Function(int)? onNavigate;
  const AboutMePage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.black],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          if (isMobile) {
            return Center(
              child: aboutText(isMobile: isMobile, isTablet: isTablet),
            );
          }
          return Row(
            children: [
              Expanded(
                child: aboutText(isMobile: isMobile, isTablet: isTablet),
              ),
              Expanded(child: PhotoSection(isMobile: isMobile)),
            ],
          );
        },
      ),
    );
  }
}

class aboutText extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  const aboutText({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'C', 'icon': FontAwesomeIcons.c, 'color': Colors.blue},
      {'name': 'C++', 'icon': FontAwesomeIcons.code, 'color': Colors.indigo},
      {'name': 'Dart', 'icon': FontAwesomeIcons.dartLang, 'color': Colors.teal},
      {'name': 'Python', 'icon': FontAwesomeIcons.python, 'color': Colors.cyan},
      {'name': 'Swift', 'icon': FontAwesomeIcons.swift, 'color': Colors.orange},
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ABOUT ME',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(55, 60, 70, isMobile, isTablet),
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '''A recent graduate from Coventry University with a Bachelor\'s degree, I\'m passionate about mobile application development and currently honing my skills in iOS development. Eager to leverage my knowledge and contribute to a dynamic team, I\'m actively seeking opportunities to embark on a rewarding career in this exciting field.''',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(18, 22, 24, isMobile, isTablet),
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),
            Text(
              'Skills',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(28, 32, 36, isMobile, isTablet),
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: skills.map((skill) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getFontSize(20, 25, 30, isMobile, isTablet),
                    vertical: getFontSize(12, 15, 18, isMobile, isTablet),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (skill['color'] as Color).withOpacity(0.8),
                        (skill['color'] as Color),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: (skill['color'] as Color).withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        skill['icon'] as IconData,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        size: getFontSize(20, 24, 28, isMobile, isTablet),
                      ),
                      SizedBox(width: 10),
                      Text(
                        skill['name'] as String,
                        style: GoogleFonts.abrilFatface(
                          fontSize: getFontSize(16, 20, 24, isMobile, isTablet),
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
