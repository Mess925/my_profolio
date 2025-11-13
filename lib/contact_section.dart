// contact_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.verySlow,
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  SizedBox(height: isMobile ? 40 : 60),
                  _buildContactInfo(context),
                  SizedBox(height: isMobile ? 40 : 60),
                  _buildSocialLinks(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
            color: AppColors.primaryCyan,
            letterSpacing: 4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            'LET\'S CONNECT',
            style: GoogleFonts.abrilFatface(
              fontSize: Responsive.fontSize(
                context,
                mobile: 40,
                tablet: 72,
                desktop: 96,
              ),
              color: Colors.white,
              height: 1.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m always open to new opportunities and collaborations',
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final contacts = [
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'Email',
        'value': 'hanminthant222@gmail.com',
        'url': 'mailto:hanminthant222@gmail.com',
        'color': const Color(0xFFEA4335),
      },
      {
        'icon': FontAwesomeIcons.phone,
        'title': 'Phone',
        'value': '+65 8824 7721',
        'url': 'tel:+6588247721',
        'color': const Color(0xFF25D366),
      },
      {
        'icon': FontAwesomeIcons.locationDot,
        'title': 'Location',
        'value': 'Singapore',
        'url': null,
        'color': const Color(0xFF00BCD4),
      },
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: contacts.map((contact) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ContactCard(
              icon: contact['icon'] as IconData,
              title: contact['title'] as String,
              value: contact['value'] as String,
              url: contact['url'] as String?,
              color: contact['color'] as Color,
              onTap: contact['url'] != null
                  ? () => _launchURL(contact['url'] as String)
                  : null,
            ),
          );
        }).toList(),
      );
    } else if (isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _ContactCard(
                  icon: contacts[0]['icon'] as IconData,
                  title: contacts[0]['title'] as String,
                  value: contacts[0]['value'] as String,
                  url: contacts[0]['url'] as String?,
                  color: contacts[0]['color'] as Color,
                  onTap: contacts[0]['url'] != null
                      ? () => _launchURL(contacts[0]['url'] as String)
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ContactCard(
                  icon: contacts[1]['icon'] as IconData,
                  title: contacts[1]['title'] as String,
                  value: contacts[1]['value'] as String,
                  url: contacts[1]['url'] as String?,
                  color: contacts[1]['color'] as Color,
                  onTap: contacts[1]['url'] != null
                      ? () => _launchURL(contacts[1]['url'] as String)
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ContactCard(
            icon: contacts[2]['icon'] as IconData,
            title: contacts[2]['title'] as String,
            value: contacts[2]['value'] as String,
            url: contacts[2]['url'] as String?,
            color: contacts[2]['color'] as Color,
            onTap: contacts[2]['url'] != null
                ? () => _launchURL(contacts[2]['url'] as String)
                : null,
          ),
        ],
      );
    } else {
      return Row(
        children: contacts.map((contact) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _ContactCard(
                icon: contact['icon'] as IconData,
                title: contact['title'] as String,
                value: contact['value'] as String,
                url: contact['url'] as String?,
                color: contact['color'] as Color,
                onTap: contact['url'] != null
                    ? () => _launchURL(contact['url'] as String)
                    : null,
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildSocialLinks(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Connect With Me',
              style: GoogleFonts.abrilFatface(
                fontSize: Responsive.fontSize(
                  context,
                  mobile: 24,
                  tablet: 32,
                  desktop: 36,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SocialButtonsRow(isMobile: isMobile),
      ],
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? url;
  final Color color;
  final VoidCallback? onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
    required this.color,
    this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: widget.url != null
          ? (_) => setState(() => _isHovered = true)
          : null,
      onExit: widget.url != null
          ? (_) => setState(() => _isHovered = false)
          : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppAnimations.normal,
          padding: EdgeInsets.all(isMobile ? 24 : 28),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? LinearGradient(
                    colors: [
                      widget.color.withOpacity(0.15),
                      widget.color.withOpacity(0.05),
                    ],
                  )
                : AppColors.cardGradient,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.5)
                  : Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.color.withOpacity(0.2)
                    : Colors.black.withOpacity(0.3),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppAnimations.normal,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(_isHovered ? 0.2 : 0.1),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  widget.icon,
                  color: widget.color,
                  size: isMobile ? 24 : 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 13 : 15,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.value,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButtonsRow extends StatelessWidget {
  final bool isMobile;

  const SocialButtonsRow({Key? key, required this.isMobile}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

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
        url: 'https://linktr.ee/han_min',
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

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSection('Personal', personalLinks, true),
          const SizedBox(height: 32),
          _buildSection('Professional', professionalLinks, true),
        ],
      );
    } else if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Personal', personalLinks, false),
          const SizedBox(width: 20),
          _buildSection('Professional', professionalLinks, false),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Personal', personalLinks, false),
          const SizedBox(width: 20),
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
        // Text(
        //   header,
        //   style: GoogleFonts.inter(
        //     fontSize: isMobileLayout ? 16 : 18,
        //     color: Colors.white.withOpacity(0.7),
        //     fontWeight: FontWeight.w600,
        //     letterSpacing: 1,
        //   ),
        // ),
        // SizedBox(height: isMobileLayout ? 16 : 20),
        isMobileLayout
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < links.length; i++) ...[
                    _SocialButton(
                      icon: links[i].icon,
                      label: links[i].label,
                      color: links[i].color,
                      isMobile: isMobileLayout,
                      onTap: () => _launchURL(links[i].url),
                    ),
                    if (i < links.length - 1) const SizedBox(width: 8),
                  ],
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
    final double buttonSize = widget.isMobile ? 60 : 80;
    final double iconSize = widget.isMobile ? 22 : 28;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppAnimations.normal,
          curve: AppAnimations.defaultCurve,
          width: buttonSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppAnimations.normal,
                curve: AppAnimations.defaultCurve,
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
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusMedium,
                  ),
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
                    duration: AppAnimations.normal,
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
                style: GoogleFonts.inter(
                  fontSize: widget.isMobile ? 10 : 12,
                  color: _isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
