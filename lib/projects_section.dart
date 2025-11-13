// projects_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'constants.dart';
import 'project_detail_page.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.verticalPadding(context),
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                'Featured Projects',
                style: GoogleFonts.abrilFatface(
                  fontSize: Responsive.fontSize(
                    context,
                    mobile: 28,
                    tablet: 32,
                    desktop: 36,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 40),

          // Projects List
          Expanded(
            child: isMobile
                ? _buildMobileProjects(context)
                : _buildDesktopTabletProjects(context, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProjects(BuildContext context) {
    final projects = _getProjects(false);

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: projects[index],
        );
      },
    );
  }

  Widget _buildDesktopTabletProjects(BuildContext context, bool isTablet) {
    final projects = _getProjects(isTablet);

    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {...PointerDeviceKind.values},
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          Row(
            children: [
              for (int i = 0; i < projects.length; i++) ...[
                projects[i],
                if (i < projects.length - 1) const SizedBox(width: 30),
              ],
            ],
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  List<Widget> _getProjects(bool isTablet) {
    return [
      ProjectCard(
        title: 'ProtectivePath',
        subtitle: 'Navigation App For Visually Impaired',
        imagePath: 'assets/images/ppth.png',
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'Little Lemon',
        subtitle: 'Restaurant Reservation App',
        imagePath: 'assets/images/res.png',
        gradient: const LinearGradient(
          colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'MiniRT',
        subtitle: 'Ray Tracing with C',
        imagePath: 'assets/images/minirt.png',
        gradient: const LinearGradient(
          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'RUN',
        subtitle: 'Fitness Running App',
        imagePath: 'assets/images/r.png',
        gradient: const LinearGradient(
          colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
        ),
        isTablet: isTablet,
      ),
      ProjectCard(
        title: 'Webserv',
        subtitle: 'A WebServer',
        imagePath: 'assets/images/webserv.png',
        gradient: const LinearGradient(
          colors: [Color(0xFFfa709a), Color(0xFFfee140)],
        ),
        isTablet: isTablet,
      ),
    ];
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final LinearGradient gradient;
  final bool isTablet;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.gradient,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final cardWidth = isMobile
        ? double.infinity
        : (widget.isTablet ? 320.0 : 380.0);
    final cardHeight = isMobile ? 400.0 : (widget.isTablet ? 480.0 : 540.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(
                title: widget.title,
                subtitle: widget.subtitle,
                details: getProjectDetails(widget.title),
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: AppAnimations.normal,
          curve: AppAnimations.defaultCurve,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -10.0 : 0.0),
          width: cardWidth,
          height: cardHeight,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              border: Border.all(
                color: Colors.white.withOpacity(_isHovered ? 0.3 : 0.1),
                width: 1.5,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Section
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.borderRadiusLarge),
                          topRight: Radius.circular(AppSizes.borderRadiusLarge),
                        ),
                        child: Container(
                          decoration: BoxDecoration(gradient: widget.gradient),
                          child: Center(
                            child: Image.asset(
                              widget.imagePath,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholder();
                              },
                            ),
                          ),
                        ),
                      ),
                      // Gradient overlay on hover
                      if (_isHovered)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                AppSizes.borderRadiusLarge,
                              ),
                              topRight: Radius.circular(
                                AppSizes.borderRadiusLarge,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 48,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Text Section
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 20.0 : 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.subtitle,
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: isMobile ? 13 : 14,
                            letterSpacing: 0.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF2A2A2A),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline_rounded,
              size: 60,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Project In Progress',
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
