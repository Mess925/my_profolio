import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/Projects.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Contact.dart';
import 'Home.dart';
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
            'assets/images/n.jpg',
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
        constraints: BoxConstraints(maxWidth: isMobile ? 300 : 700),
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
                letterSpacing: 2,
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
        url: 'https://www.instagram.com/hthant__/?hl=en',
        label: 'Instagram',
        color: const Color(0xFFE4405F),
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/Mess925',
        label: 'GitHub',
        color: const Color(0xFF333333),
      ),
      SocialLink(
        icon: FontAwesomeIcons.whatsapp,
        url: 'tel:+6588247721',
        label: 'WhatsApp',
        color: const Color(0xFF25D366),
      ),
    ];

    final professionalLinks = [
      SocialLink(
        icon: FontAwesomeIcons.link,
        url:
            'https://linktr.ee/han_min?fbclid=PAZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAGnqa6ndjKyqZIwGKyQc4JO3veYqx39azHjNKfTaON8zZfMxWlR9BTAqWqlxEg_aem_GDGIIqFrZ-RZHtlHseSGBw',
        label: 'LinkTree',
        color: const Color(0xFF43E55E),
      ),
      SocialLink(
        icon: FontAwesomeIcons.envelope,
        url: 'mailto:hanminthant222@gmail.com',
        label: 'E-Mail',
        color: const Color(0xFFEA4335),
      ),
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/han-min-thant-0b051a283/',
        label: 'LinkedIn',
        color: const Color(0xFF0A66C2),
      ),
    ];

    if (isMobile || isTablet) {
      return Column(
        children: [
          _buildSection('Personal', personalLinks, true),
          const SizedBox(height: 32),
          _buildSection('Professional', professionalLinks, true),
        ],
      );
    } else {
      // Desktop layout - horizontal sections side by side
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Personal', personalLinks, false),
          const SizedBox(width: 80),
          _buildSection('Professional', professionalLinks, false),
        ],
      );
    }
  }

  Widget _buildSection(
    String header,
    List<SocialLink> links,
    bool isMobileLayout,
  ) {
    return Column(
      crossAxisAlignment: isMobileLayout
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          header,
          style: GoogleFonts.abrilFatface(
            fontSize: isMobileLayout ? 20 : 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: isMobileLayout ? 16 : 20),
        // Use Row for desktop to keep buttons horizontal
        isMobileLayout
            ? Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: links
                    .map(
                      (link) => _SocialButton(
                        icon: link.icon,
                        label: link.label,
                        color: link.color,
                        isMobile: isMobileLayout,
                        onTap: () => _launchURL(link.url),
                      ),
                    )
                    .toList(),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < links.length; i++) ...[
                    _SocialButton(
                      icon: links[i].icon,
                      label: links[i].label,
                      color: links[i].color,
                      isMobile: isMobileLayout,
                      onTap: () => _launchURL(links[i].url),
                    ),
                    if (i < links.length - 1) const SizedBox(width: 16),
                  ],
                ],
              ),
      ],
    );
  }
}

class SocialLink {
  final IconData icon;
  final String url;
  final String label;
  final Color color;

  SocialLink({
    required this.icon,
    required this.url,
    required this.label,
    required this.color,
  });
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isMobile;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
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
    final double buttonSize = widget.isMobile ? 70 : 85;
    final double iconSize = widget.isMobile ? 28 : 32;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: buttonSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  gradient: _isHovered
                      ? LinearGradient(
                          colors: [widget.color.withOpacity(0.8), widget.color],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: _isHovered ? null : Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? widget.color.withOpacity(0.5)
                        : Colors.white.withOpacity(0.15),
                    width: 2,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.color.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: _isHovered ? 1.1 : 1.0,
                    child: FaIcon(
                      widget.icon,
                      color: _isHovered
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                      size: iconSize,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: GoogleFonts.roboto(
                  fontSize: widget.isMobile ? 11 : 12,
                  color: _isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
