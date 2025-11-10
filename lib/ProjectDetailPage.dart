import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

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

  double getFontSize(
    double mobile,
    double tablet,
    double desktop,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

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
            fontSize: getFontSize(40, 50, 60, isMobile, isTablet),
            color: Colors.grey.withOpacity(0.8),
            letterSpacing: 2,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isMobile ? 16 : 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.05),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.close),
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
                horizontal: isMobile ? 20 : (isTablet ? 30 : 40),
                vertical: isMobile ? 40 : 60,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Title
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: getFontSize(32, 40, 48, isMobile, isTablet),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),

                      // Subtitle
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: getFontSize(16, 18, 20, isMobile, isTablet),
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      SizedBox(height: isMobile ? 40 : 60),

                      // Divider
                      Container(
                        height: 2,
                        width: isMobile ? 60 : 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.white.withOpacity(0)],
                          ),
                        ),
                      ),

                      SizedBox(height: isMobile ? 40 : 60),

                      // Overview Section
                      _buildSection(
                        'Overview',
                        widget.details.overview,
                        isMobile,
                        isTablet,
                      ),

                      SizedBox(height: isMobile ? 30 : 40),

                      // Key Features Section
                      _buildFeaturesSection(
                        'Key Features',
                        widget.details.keyFeatures,
                        isMobile,
                        isTablet,
                      ),

                      SizedBox(height: isMobile ? 30 : 40),

                      _buildSection(
                        'Technologies',
                        widget.details.technologies,
                        isMobile,
                        isTablet,
                      ),

                      SizedBox(height: isMobile ? 40 : 60),

                      if (widget.details.ctaButtonText != null)
                        Center(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: ElevatedButton(
                                onPressed:
                                    widget.details.onCtaPressed ??
                                    () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('No action yet.'),
                                          backgroundColor: Colors.grey.shade800,
                                        ),
                                      );
                                    },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 32 : 48,
                                    vertical: isMobile ? 16 : 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  widget.details.ctaButtonText!,
                                  style: GoogleFonts.poppins(
                                    fontSize: getFontSize(
                                      14,
                                      15,
                                      16,
                                      isMobile,
                                      isTablet,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    bool isMobile,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: getFontSize(20, 22, 24, isMobile, isTablet),
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: getFontSize(14, 15, 16, isMobile, isTablet),
            color: Colors.grey.shade300,
            height: 1.8,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(
    String title,
    List<String> features,
    bool isMobile,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: getFontSize(20, 22, 24, isMobile, isTablet),
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        ...features.map(
          (feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: GoogleFonts.poppins(
                    fontSize: getFontSize(14, 15, 16, isMobile, isTablet),
                    color: Colors.grey.shade300,
                    height: 1.8,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Expanded(
                  child: Text(
                    feature,
                    style: GoogleFonts.poppins(
                      fontSize: getFontSize(14, 15, 16, isMobile, isTablet),
                      color: Colors.grey.shade300,
                      height: 1.8,
                      fontWeight: FontWeight.w300,
                    ),
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
