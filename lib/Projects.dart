import 'package:flutter/material.dart';
import 'ProjectDetailPage.dart';
import 'dart:ui';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;

          // Responsive padding
          final horizontalPadding = isMobile ? 16.0 : (isTablet ? 40.0 : 80.0);
          final verticalPadding = isMobile ? 20.0 : 40.0;

          // All devices: Horizontal scrolling
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {...PointerDeviceKind.values},
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 20.0 : 40.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                              constraints.maxHeight -
                              (verticalPadding * 2) -
                              40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ProjectCard(
                                title: 'ProtectivePath',
                                subtitle:
                                    'Navigation App For Visually Impaired',
                                imagePath: 'assets/images/ppth.png',
                                route: '/protective-path',
                                isTablet: isTablet,
                              ),
                              SizedBox(width: isTablet ? 20 : 30),
                              ProjectCard(
                                title: 'Little Lemon',
                                subtitle: 'Restaurant Reservation App',
                                imagePath: 'assets/images/res.png',
                                route: '/little-lemon',
                                isTablet: isTablet,
                              ),
                              SizedBox(width: isTablet ? 20 : 30),
                              ProjectCard(
                                title: 'MiniRT',
                                subtitle: 'Ray Tracing with C',
                                imagePath: 'assets/images/minirt.png',
                                route: '/minirt',
                                isTablet: isTablet,
                              ),
                              SizedBox(width: isTablet ? 20 : 30),
                              ProjectCard(
                                title: 'RUN',
                                subtitle: 'Fitness Running App',
                                imagePath: 'assets/images/r.png',
                                route: '/run',
                                isTablet: isTablet,
                              ),
                              SizedBox(width: isTablet ? 20 : 30),
                              ProjectCard(
                                title: 'Webserv',
                                subtitle: 'A WebServer',
                                imagePath: 'assets/images/project5.png',
                                route: '/webserv',
                                isTablet: isTablet,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NavButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const NavButton({Key? key, required this.text, required this.onTap})
    : super(key: key);

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isHovered ? 0.6 : 1.0,
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String route;
  final bool isTablet;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.route,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    // Responsive card dimensions
    final cardWidth = isMobile ? 280.0 : (widget.isTablet ? 300.0 : 350.0);
    final cardHeight = isMobile ? 380.0 : (widget.isTablet ? 450.0 : 500.0);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailPage(
                title: widget.title,
                subtitle: widget.subtitle,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, isHovered ? -10 : 0, 0),
          width: cardWidth,
          height: cardHeight,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isMobile
                  ? [
                      // Permanent shadow for mobile
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : isHovered
                  ? [
                      // Hover shadow for desktop
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 40,
                        offset: const Offset(0, -20),
                      ),
                    ]
                  : [
                      // Subtle default shadow for desktop
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Container (75% of card height)
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Center(
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF404040),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    size: 60,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'On Going Project',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 12,
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
                ),
                // Text Container (25% of card height)
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: isMobile ? 12 : 14,
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
}
