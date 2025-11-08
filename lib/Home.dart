import 'package:flutter/material.dart';
import 'WelcomePage.dart';
import 'Metorshower.dart';

class HomePage extends StatefulWidget {
  final Function(int)? onNavigate;
  const HomePage({super.key, this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1) {
      // User scrolled to bottom, navigate to next page
      if (widget.onNavigate != null) {
        widget.onNavigate!(1); // Navigate to page 1 (Projects)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final isTablet =
            constraints.maxWidth >= 800 && constraints.maxWidth < 1200;

        if (isMobile) {
          // Mobile layout with separated scrollable and non-scrollable sections
          return MeteorShower(
            numberOfMeteors: 20,
            duration: const Duration(seconds: 10),
            meteorColor: Colors.red.withOpacity(0.6),
            child: Container(
              width: double.infinity,
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.black],
                ),
              ),
              child: Column(
                children: [
                  // Non-scrollable photo section (swipes will navigate pages)
                  PhotoSection(isMobile: isMobile),

                  // Scrollable hero section with auto-navigation at bottom
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: HeroSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Desktop/Tablet layout - fully scrollable with auto-navigation
          return SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: MeteorShower(
                numberOfMeteors: 20,
                duration: const Duration(seconds: 10),
                meteorColor: Colors.red.withOpacity(0.6),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.black],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: HeroSection(
                          isMobile: isMobile,
                          isTablet: isTablet,
                        ),
                      ),
                      Expanded(child: PhotoSection(isMobile: isMobile)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
