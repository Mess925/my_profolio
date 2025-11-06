import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AboutMe.dart';
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
          const AboutMePage(),
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
        _NavButton(label: 'ABOUT ME', onPressed: () => _navigateToPage(1)),
        _NavButton(label: 'PROJECTS', onPressed: () {}),
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
            'assets/images/a.jpeg',
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: isMobile ? 150 : 200),
          child: Text(
            'I am',
            style: GoogleFonts.abrilFatface(
              fontSize: getFontSize(18, 22, 24, isMobile, isTablet),
              color: Colors.black87,
              letterSpacing: 2,
              height: 0.1,
            ),
          ),
        ),
        Text(
          'HAN',
          style: GoogleFonts.abrilFatface(
            fontSize: getFontSize(94, 110, 128, isMobile, isTablet),
            color: Colors.black87,
            height: 0.9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Mobile App Developer',
          style: GoogleFonts.abrilFatface(
            fontSize: getFontSize(19, 23, 26, isMobile, isTablet),
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 40),
        _SocialButtonsRow(isMobile: isMobile),
      ],
    );
  }
}

class _SocialButtonsRow extends StatelessWidget {
  final bool isMobile;

  const _SocialButtonsRow({required this.isMobile});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final socialLinks = [
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/han-min-thant-0b051a283/',
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/Mess925',
      ),
      SocialLink(
        icon: FontAwesomeIcons.envelope,
        url: 'mailto:your-email@example.com',
      ),
      SocialLink(
        icon: FontAwesomeIcons.link,
        url: 'https://linktr.ee/yourprofile',
      ),
      SocialLink(icon: FontAwesomeIcons.phone, url: 'tel:+1234567890'),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: socialLinks
          .map(
            (link) => _SocialButton(
              icon: link.icon,
              isMobile: isMobile,
              onTap: () => _launchURL(link.url),
            ),
          )
          .toList(),
    );
  }
}

class SocialLink {
  final IconData icon;
  final String url;

  SocialLink({required this.icon, required this.url});
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
    final double iconSize = widget.isMobile ? 24 : 28;

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
            color: _isHovered ? Colors.white : Colors.black.withOpacity(0.85),
            size: iconSize,
          ),
          tooltip: _getTooltip(widget.icon),
        ),
      ),
    );
  }

  String _getTooltip(IconData icon) {
    if (icon == FontAwesomeIcons.linkedin) return 'LinkedIn';
    if (icon == FontAwesomeIcons.github) return 'GitHub';
    if (icon == FontAwesomeIcons.envelope) return 'Email';
    if (icon == FontAwesomeIcons.link) return 'Links';
    if (icon == FontAwesomeIcons.phone) return 'Phone';
    return '';
  }
}
