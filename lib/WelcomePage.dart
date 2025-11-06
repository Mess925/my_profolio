import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/Projects.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Contact.dart';
import 'Home.dart';
// import 'Projects.dart';
import 'Helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const ScrollablePages(),
    );
  }
}

class ScrollablePages extends StatefulWidget {
  const ScrollablePages({super.key});

  @override
  State<ScrollablePages> createState() => _ScrollablePagesState();
}

class _ScrollablePagesState extends State<ScrollablePages> {
  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          HomePage(onNavigate: _navigateToPage),
          const ProjectPage(),
          const ContactPage(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: 60,
      actions: <Widget>[
        _NavButton(label: 'HOME', onPressed: () => _navigateToPage(0)),
        _NavButton(label: 'PROJECTS', onPressed: () => _navigateToPage(1)),
        _NavButton(label: 'CONTACT', onPressed: () => _navigateToPage(2)),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _NavButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.abrilFatface(
          fontSize: 16,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class PhotoSection extends StatelessWidget {
  final bool isMobile;

  const PhotoSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(isMobile ? 40 : 60),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? 300 : 700,
          maxHeight: isMobile ? 300 : 700,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/a.JPG',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.white.withOpacity(0.1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: isMobile ? 100 : 150,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Add your photo here',
                        style: GoogleFonts.abrilFatface(
                          fontSize: isMobile ? 18 : 24,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const HeroSection({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'C', 'icon': FontAwesomeIcons.c, 'color': Colors.blue},
      {'name': 'C++', 'icon': FontAwesomeIcons.code, 'color': Colors.indigo},
      {'name': 'Dart', 'icon': FontAwesomeIcons.dartLang, 'color': Colors.teal},
      {'name': 'Python', 'icon': FontAwesomeIcons.python, 'color': Colors.cyan},
      {'name': 'Swift', 'icon': FontAwesomeIcons.swift, 'color': Colors.orange},
    ];
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(isMobile ? 40 : 60),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? 300 : 700,
          // maxHeight: isMobile ? 300 : 700,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: isMobile ? 150 : 170),
              child: Text(
                'MEET',
                style: GoogleFonts.abrilFatface(
                  fontSize: getFontSize(18, 22, 32, isMobile, isTablet),
                  color: Colors.white,
                  letterSpacing: 2,
                  height: isMobile ? 1 : 0.1,
                ),
              ),
            ),
            Text(
              'HAN',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(94, 110, 128, isMobile, isTablet),
                color: Colors.white,
                height: 0.9,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Mobile App Developer',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(19, 23, 26, isMobile, isTablet),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              '''A recent graduate from Coventry University with a Bachelor\'s degree, I\'m passionate about mobile application development and currently honing my skills in iOS development. Eager to leverage my knowledge and contribute to a dynamic team, I\'m actively seeking opportunities to embark on a rewarding career in this exciting field.''',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(18, 22, 24, isMobile, isTablet),
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Skills',
              style: GoogleFonts.abrilFatface(
                fontSize: getFontSize(28, 32, 36, isMobile, isTablet),
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.start,
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

class SocialButtonsRow extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const SocialButtonsRow({required this.isMobile, required this.isTablet});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final personalLinks = [
      SocialLink(
        icon: FontAwesomeIcons.instagram,
        url: 'https://www.instagram.com/yourprofile',
        label: 'Instagram',
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/Mess925',
        label: 'GitHub',
      ),
      SocialLink(
        icon: FontAwesomeIcons.phone,
        url: 'tel:+6588247721',
        label: 'Phone',
      ),
    ];

    final professionalLinks = [
      SocialLink(
        icon: FontAwesomeIcons.link,
        url: 'https://linktr.ee/yourprofile',
        label: 'LinkTree',
      ),
      SocialLink(
        icon: FontAwesomeIcons.envelope,
        url: 'mailto:hanminthant222@gmail.com',
        label: 'E-Mail',
      ),
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/han-min-thant-0b051a283/',
        label: 'LinkedIn',
      ),
    ];

    if (isMobile || isTablet) {
      // Mobile: 2 columns, stacked vertically
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildColumn('Personal', personalLinks),
          const SizedBox(width: 32),
          _buildColumn('Professional', professionalLinks),
        ],
      );
    } else {
      // Desktop: stacked rows horizontally
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRow('Personal', personalLinks),
          SizedBox(height: isMobile ? 24 : 32),
          _buildRow('Professional', professionalLinks),
        ],
      );
    }
  }

  Widget _buildColumn(String header, List<SocialLink> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: GoogleFonts.abrilFatface(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (var link in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                _SocialButton(
                  icon: link.icon,
                  isMobile: true,
                  onTap: () => _launchURL(link.url),
                ),
                Text(
                  link.label,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRow(String header, List<SocialLink> links) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            header,
            style: GoogleFonts.abrilFatface(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 20),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                _SocialButton(
                  icon: link.icon,
                  isMobile: false,
                  onTap: () => _launchURL(link.url),
                ),
                const SizedBox(width: 12),
                Text(
                  link.label,
                  style: GoogleFonts.roboto(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SocialLink {
  final IconData icon;
  final String url;
  final String label;

  SocialLink({required this.icon, required this.url, required this.label});
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final bool isMobile;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double buttonSize = widget.isMobile ? 40 : 50;
    final double iconSize = widget.isMobile ? 20 : 24;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: widget.onTap,
          icon: FaIcon(
            widget.icon,
            color: _isHovered ? Colors.white : Colors.grey.withOpacity(0.85),
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
