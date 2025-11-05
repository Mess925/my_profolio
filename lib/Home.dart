import 'package:flutter/material.dart';
import 'WelcomePage.dart';
import 'Metorshower.dart'; // Add this import

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate;
  const HomePage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return MeteorShower(
      numberOfMeteors: 15, // More meteors for full coverage
      duration: const Duration(seconds: 100), // Adjust speed
      meteorColor: Colors.black.withOpacity(
        0.6,
      ), // White meteors on your gradient
      child: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhotoSection(isMobile: isMobile),
                  HeroSection(isMobile: isMobile, isTablet: isTablet),
                ],
              );
            }
            return Row(
              children: [
                Expanded(
                  child: Center(
                    child: HeroSection(isMobile: isMobile, isTablet: isTablet),
                  ),
                ),
                Expanded(child: PhotoSection(isMobile: isMobile)),
              ],
            );
          },
        ),
      ),
    );
  }
}
