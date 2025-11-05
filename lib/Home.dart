import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate;

  const HomePage({super.key, this.onNavigate});

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
            return Column(
              children: [
                _PhotoSection(isMobile: isMobile),
                _HeroSection(isMobile: isMobile, isTablet: isTablet),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: Center(
                  child: _HeroSection(isMobile: isMobile, isTablet: isTablet),
                ),
              ),
              Expanded(child: _PhotoSection(isMobile: isMobile)),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _HeroSection({required this.isMobile, required this.isTablet});

  double _getFontSize(double mobile, double tablet, double desktop) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }

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
              fontSize: _getFontSize(18, 22, 24),
              color: Colors.white,
              letterSpacing: 2,
              height: 0.1,
            ),
          ),
        ),
        Text(
          'HAN',
          style: GoogleFonts.abrilFatface(
            fontSize: _getFontSize(94, 110, 128),
            color: Colors.white,
            height: 0.9,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Mobile App Developer',
          style: GoogleFonts.abrilFatface(
            fontSize: _getFontSize(19, 23, 26),
            color: Colors.white,
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
            color: _isHovered ? Colors.white : Colors.white.withOpacity(0.85),
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

class _PhotoSection extends StatelessWidget {
  final bool isMobile;

  const _PhotoSection({required this.isMobile});

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
            'assets/images/profile.jpg', // Replace with your image path
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Placeholder when image is not found
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
