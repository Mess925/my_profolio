// home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'about_section.dart';
import 'projects_section.dart';
import 'contact_section.dart'; // Add this import

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isNavigating = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    if (_isNavigating || _currentPage == page) return;

    setState(() {
      _isNavigating = true;
      _currentPage = page;
    });

    _pageController
        .animateToPage(
          page,
          duration: AppAnimations.slow,
          curve: AppAnimations.defaultCurve,
        )
        .then((_) {
          if (mounted) {
            setState(() => _isNavigating = false);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          AnimatedContainer(
            duration: AppAnimations.slow,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: _currentPage == 0
                    ? Alignment.topRight
                    : _currentPage == 1
                    ? Alignment.center
                    : Alignment.bottomLeft,
                radius: 1.5,
                colors: [Colors.grey.shade900.withOpacity(0.3), Colors.black],
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (page) {
                    if (mounted) {
                      setState(() => _currentPage = page);
                    }
                  },
                  children: const [
                    AboutSection(),
                    ProjectsSection(),
                    ContactSection(), // Now properly using the 3rd page
                  ],
                ),
              ),
            ],
          ),
          // Page indicators (Desktop only)
          if (Responsive.isDesktop(context)) _buildPageIndicators(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      height: isMobile ? 70 : 80,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Text(
            'HAN',
            style: GoogleFonts.abrilFatface(
              fontSize: isMobile ? 24 : 28,
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
          const Spacer(),

          // Navigation buttons (Desktop/Tablet)
          if (!isMobile) ...[
            _NavButton(
              label: 'ABOUT',
              isActive: _currentPage == 0,
              onPressed: () => _navigateToPage(0),
            ),
            _NavButton(
              label: 'PROJECTS',
              isActive: _currentPage == 1,
              onPressed: () => _navigateToPage(1),
            ),
            _NavButton(
              label: 'CONTACT',
              isActive: _currentPage == 2,
              onPressed: () => _navigateToPage(2),
            ),
          ],

          // Mobile menu
          if (isMobile)
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: Colors.white),
              color: const Color(0xFF1A1A1A),
              onSelected: _navigateToPage,
              itemBuilder: (context) => [
                _buildMenuItem('ABOUT', 0),
                _buildMenuItem('PROJECTS', 1),
                _buildMenuItem('CONTACT', 2),
              ],
            ),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildMenuItem(String label, int value) {
    return PopupMenuItem<int>(
      value: value,
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: _currentPage == value ? AppColors.primaryCyan : Colors.white,
          fontWeight: _currentPage == value ? FontWeight.w600 : FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Positioned(
      right: 40,
      top: 0,
      bottom: 0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final isActive = _currentPage == index;
            return GestureDetector(
              onTap: () => _navigateToPage(index),
              child: AnimatedContainer(
                duration: AppAnimations.normal,
                curve: AppAnimations.defaultCurve,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: isActive ? 12 : 8,
                height: isActive ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColors.primaryCyan
                      : Colors.white.withOpacity(0.3),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primaryCyan.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _NavButton({
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: widget.isActive || _isHovered
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                  letterSpacing: 1.5,
                  fontWeight: widget.isActive
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: AppAnimations.normal,
                height: 2,
                width: widget.isActive ? 40 : (_isHovered ? 20 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
