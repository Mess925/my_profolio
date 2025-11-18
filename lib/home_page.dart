// home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'about_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';

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
    final isMobile = Responsive.isMobile(context);

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
                  // Disable PageView scrolling on mobile to avoid conflict with content scrolling
                  physics: isMobile
                      ? const AlwaysScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    if (mounted) {
                      setState(() => _currentPage = page);
                    }
                  },
                  children: const [
                    ProjectsSection(),
                    AboutSection(),
                    ContactSection(),
                  ],
                ),
              ),
              // Mobile bottom navigation bar
              if (isMobile) _buildMobileBottomNav(),
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

          // Navigation buttons (Desktop/Tablet only)
          if (!isMobile) ...[
            _NavButton(
              label: 'PROJECTS',
              isActive: _currentPage == 0,
              onPressed: () => _navigateToPage(0),
            ),
            _NavButton(
              label: 'ABOUT',
              isActive: _currentPage == 1,
              onPressed: () => _navigateToPage(1),
            ),
            _NavButton(
              label: 'CONTACT',
              isActive: _currentPage == 2,
              onPressed: () => _navigateToPage(2),
            ),
          ],

          // Mobile: just show current page name
          if (isMobile)
            Text(
              _currentPage == 0
                  ? 'PROJECTS'
                  : _currentPage == 1
                  ? 'ABOUT'
                  : 'CONTACT',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.primaryCyan,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileBottomNav() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MobileNavItem(
            icon: Icons.work_outline,
            activeIcon: Icons.work,
            label: 'Projects',
            isActive: _currentPage == 0,
            onTap: () => _navigateToPage(0),
          ),
          _MobileNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'About',
            isActive: _currentPage == 1,
            onTap: () => _navigateToPage(1),
          ),
          _MobileNavItem(
            icon: Icons.mail_outline,
            activeIcon: Icons.mail,
            label: 'Contact',
            isActive: _currentPage == 2,
            onTap: () => _navigateToPage(2),
          ),
        ],
      ),
    );
  }

  // PopupMenuItem<int> _buildMenuItem(String label, int value) {
  //   return PopupMenuItem<int>(
  //     value: value,
  //     child: Text(
  //       label,
  //       style: GoogleFonts.inter(
  //         color: _currentPage == value ? AppColors.primaryCyan : Colors.white,
  //         fontWeight: _currentPage == value ? FontWeight.w600 : FontWeight.w400,
  //         letterSpacing: 1.5,
  //       ),
  //     ),
  //   );
  // }

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

class _MobileNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: AppAnimations.fast,
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive
                    ? AppColors.primaryCyan
                    : Colors.white.withOpacity(0.5),
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: isActive
                    ? AppColors.primaryCyan
                    : Colors.white.withOpacity(0.5),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ],
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
