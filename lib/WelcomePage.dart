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

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final bool isTablet;

  const HeroSection({required this.isMobile, required this.isTablet});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = [
      {
        'name': 'C',
        'icon': FontAwesomeIcons.c,
        'color': const Color(0xFF5C6BC0),
      },
      {
        'name': 'C++',
        'icon': FontAwesomeIcons.code,
        'color': const Color(0xFF3F51B5),
      },
      {
        'name': 'Dart',
        'icon': FontAwesomeIcons.dartLang,
        'color': const Color(0xFF00ACC1),
      },
      {
        'name': 'Python',
        'icon': FontAwesomeIcons.python,
        'color': const Color(0xFF0097A7),
      },
      {
        'name': 'Swift',
        'icon': FontAwesomeIcons.swift,
        'color': const Color(0xFFFF6F00),
      },
    ];

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(widget.isMobile ? 24 : 80),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: widget.isMobile ? 340 : (widget.isTablet ? 900 : 1200),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            padding: EdgeInsets.all(
              widget.isMobile ? 32 : (widget.isTablet ? 56 : 64),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Meet label with accent
                Text(
                  'MEET',
                  style: GoogleFonts.abrilFatface(
                    fontSize: getFontSize(
                      14,
                      16,
                      18,
                      widget.isMobile,
                      widget.isTablet,
                    ),
                    color: Colors.white.withOpacity(0.6),
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Name with gradient
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.white, Colors.white.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'HAN',
                    style: GoogleFonts.abrilFatface(
                      fontSize: getFontSize(
                        80,
                        100,
                        120,
                        widget.isMobile,
                        widget.isTablet,
                      ),
                      color: Colors.white,
                      height: 0.95,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Title with accent color
                Text(
                  'Mobile App Developer',
                  style: GoogleFonts.abrilFatface(
                    fontSize: getFontSize(
                      18,
                      22,
                      26,
                      widget.isMobile,
                      widget.isTablet,
                    ),
                    color: const Color(0xFF00BCD4),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Bio with better readability
                Text(
                  '''I'm a recent Computer Science graduate with First Class Honours from Coventry University. Currently honing my coding skills at 42 Singapore, I'm passionate about mobile app development. I have experience with Swift and am now focusing on Flutter for cross-platform applications, as well as Python for backend development.''',
                  style: GoogleFonts.inter(
                    fontSize: getFontSize(
                      15,
                      17,
                      19,
                      widget.isMobile,
                      widget.isTablet,
                    ),
                    color: Colors.white.withOpacity(0.85),
                    height: 1.7,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 40),

                // Skills header
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00BCD4),
                            const Color(0xFF0097A7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Technical Skills',
                      style: GoogleFonts.abrilFatface(
                        fontSize: getFontSize(
                          24,
                          28,
                          32,
                          widget.isMobile,
                          widget.isTablet,
                        ),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Enhanced skill chips
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.start,
                  children: skills.asMap().entries.map((entry) {
                    final index = entry.key;
                    final skill = entry.value;
                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 600 + (index * 100)),
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.easeOutBack,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: _SkillChip(
                            skill: skill,
                            isMobile: widget.isMobile,
                            isTablet: widget.isTablet,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final Map<String, dynamic> skill;
  final bool isMobile;
  final bool isTablet;

  const _SkillChip({
    required this.skill,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: getFontSize(16, 20, 24, widget.isMobile, widget.isTablet),
          vertical: getFontSize(10, 12, 14, widget.isMobile, widget.isTablet),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [
                    (widget.skill['color'] as Color),
                    (widget.skill['color'] as Color).withOpacity(0.7),
                  ]
                : [
                    (widget.skill['color'] as Color).withOpacity(0.2),
                    (widget.skill['color'] as Color).withOpacity(0.1),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (widget.skill['color'] as Color).withOpacity(
              _isHovered ? 0.8 : 0.3,
            ),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: (widget.skill['color'] as Color).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.skill['icon'] as IconData,
              color: Colors.white,
              size: getFontSize(18, 22, 24, widget.isMobile, widget.isTablet),
            ),
            const SizedBox(width: 8),
            Text(
              widget.skill['name'] as String,
              style: GoogleFonts.inter(
                fontSize: getFontSize(
                  14,
                  16,
                  18,
                  widget.isMobile,
                  widget.isTablet,
                ),
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
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
