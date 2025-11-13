// project_detail_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class ProjectDetails {
  final String overview;
  final List<String> keyFeatures;
  final String technologies;
  final String? ctaButtonText;
  final VoidCallback? onCtaPressed;

  const ProjectDetails({
    required this.overview,
    required this.keyFeatures,
    required this.technologies,
    this.ctaButtonText,
    this.onCtaPressed,
  });
}

class ProjectDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final ProjectDetails details;

  const ProjectDetailPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.details,
  }) : super(key: key);

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

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
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'HAN',
          style: GoogleFonts.abrilFatface(
            fontSize: Responsive.fontSize(
              context,
              mobile: 32,
              tablet: 40,
              desktop: 48,
            ),
            color: Colors.white.withOpacity(0.8),
            letterSpacing: 2,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isMobile ? 16 : 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
                color: Colors.white.withOpacity(0.05),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.close_rounded, size: 24),
                onPressed: () => Navigator.pop(context),
                color: Colors.white,
                tooltip: 'Close',
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              Colors.grey.shade900.withOpacity(0.3),
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
                vertical: isMobile ? 40 : 60,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            widget.title,
                            style: GoogleFonts.abrilFatface(
                              fontSize: Responsive.fontSize(
                                context,
                                mobile: 36,
                                tablet: 48,
                                desktop: 56,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Subtitle
                          Text(
                            widget.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: Responsive.fontSize(
                                context,
                                mobile: 16,
                                tablet: 18,
                                desktop: 20,
                              ),
                              color: AppColors.primaryCyan,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                            ),
                          ),

                          SizedBox(height: isMobile ? 40 : 60),

                          // Divider
                          Container(
                            height: 2,
                            width: isMobile ? 60 : 80,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                          SizedBox(height: isMobile ? 40 : 60),

                          // Overview
                          _buildSection(
                            'Overview',
                            widget.details.overview,
                            context,
                          ),

                          SizedBox(height: isMobile ? 30 : 40),

                          // Features
                          _buildFeaturesSection(
                            'Key Features',
                            widget.details.keyFeatures,
                            context,
                          ),

                          SizedBox(height: isMobile ? 30 : 40),

                          // Technologies
                          _buildSection(
                            'Technologies',
                            widget.details.technologies,
                            context,
                          ),

                          SizedBox(height: isMobile ? 40 : 60),

                          // CTA Button
                          if (widget.details.ctaButtonText != null)
                            Center(child: _buildCtaButton(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 22,
              tablet: 26,
              desktop: 28,
            ),
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 15,
              tablet: 16,
              desktop: 17,
            ),
            color: Colors.white.withOpacity(0.85),
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(
    String title,
    List<String> features,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: Responsive.fontSize(
              context,
              mobile: 22,
              tablet: 26,
              desktop: 28,
            ),
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        ...features.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value,
                    style: GoogleFonts.inter(
                      fontSize: Responsive.fontSize(
                        context,
                        mobile: 15,
                        tablet: 16,
                        desktop: 17,
                      ),
                      color: Colors.white.withOpacity(0.85),
                      height: 1.8,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCtaButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryCyan.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:
              widget.details.onCtaPressed ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Feature coming soon!',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadiusSmall,
                      ),
                    ),
                  ),
                );
              },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.fontSize(
                context,
                mobile: 32,
                tablet: 40,
                desktop: 48,
              ),
              vertical: Responsive.fontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            widget.details.ctaButtonText!,
            style: GoogleFonts.inter(
              fontSize: Responsive.fontSize(
                context,
                mobile: 14,
                tablet: 15,
                desktop: 16,
              ),
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Project Details Data
ProjectDetails getProjectDetails(String title) {
  switch (title) {
    case 'ProtectivePath':
      return const ProjectDetails(
        overview:
            'ProtectivePath is an innovative navigation application designed specifically '
            'for visually impaired users. Using advanced haptic feedback and audio cues, '
            'it provides safe and intuitive navigation through urban environments.',
        keyFeatures: [
          'Real-time obstacle detection using device sensors',
          'Voice-guided turn-by-turn navigation',
          'Haptic feedback for directional guidance',
          'Accessible UI designed for screen readers',
          'Offline maps for uninterrupted navigation',
        ],
        technologies:
            'Swift • Google Maps API • TensorFlow Lite • Text-to-Speech',
        ctaButtonText: 'View Project',
      );

    case 'Little Lemon':
      return const ProjectDetails(
        overview:
            'Little Lemon is a sophisticated restaurant reservation system '
            'that streamlines the dining experience. Customers can browse menus, '
            'make reservations, and receive real-time updates on table availability.',
        keyFeatures: [
          'Interactive menu browsing with dietary filters',
          'Real-time table availability tracking',
          'Push notifications for reservation confirmations',
          'Integrated payment system for deposits',
          'Review and rating system',
        ],
        technologies: 'Swift • Firebase • Cloud Functions • Stripe API',
        ctaButtonText: 'View Demo',
      );

    case 'MiniRT':
      return const ProjectDetails(
        overview:
            'MiniRT is a ray tracing engine built from scratch in C, demonstrating '
            'advanced computer graphics techniques. It renders photorealistic 3D scenes '
            'with accurate lighting, shadows, and reflections.',
        keyFeatures: [
          'Phong reflection model implementation',
          'Support for multiple light sources',
          'Sphere, plane, and cylinder primitives',
          'Ambient, diffuse, and specular lighting',
          'Shadow casting and reflection',
        ],
        technologies: 'C • MinilibX • Linear Algebra • Computer Graphics',
        ctaButtonText: 'View on GitHub',
      );

    case 'RUN':
      return const ProjectDetails(
        overview:
            'RUN is a comprehensive fitness tracking application focused on running '
            'and jogging activities. It tracks your routes, monitors performance metrics, '
            'and helps you achieve your fitness goals.',
        keyFeatures: [
          'GPS-based route tracking and mapping',
          'Real-time pace and distance calculations',
          'Performance analytics and progress tracking',
          'Social features to share runs with friends',
          'Custom workout plans and challenges',
        ],
        technologies: 'Flutter • Google Maps API • SQLite • Health Connect',
        ctaButtonText: 'Download App',
      );

    case 'Webserv':
      return const ProjectDetails(
        overview:
            'Webserv is a custom HTTP web server implementation written in C++. '
            'Following the HTTP/1.1 protocol, it handles multiple concurrent connections '
            'and serves static and dynamic content efficiently.',
        keyFeatures: [
          'HTTP/1.1 protocol implementation',
          'Multi-client connection handling with select()',
          'CGI script execution support',
          'Virtual host configuration',
          'Custom error pages and redirects',
        ],
        technologies: 'C++ • Socket Programming • HTTP Protocol • CGI',
        ctaButtonText: 'View Documentation',
      );

    default:
      return const ProjectDetails(
        overview:
            'This project showcases innovative solutions and creative design approaches. '
            'Built with attention to detail and user experience in mind.',
        keyFeatures: [
          'Modern and responsive design',
          'Smooth animations and transitions',
          'Optimized performance',
          'Clean and maintainable code',
        ],
        technologies: 'Flutter • Dart • Material Design',
        ctaButtonText: 'Learn More',
      );
  }
}

// make it look better
