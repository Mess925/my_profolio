import 'package:flutter/material.dart';
import 'WelcomePage.dart';
import 'Metorshower.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavigate;
  const HomePage({super.key, this.onNavigate});

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

        return SingleChildScrollView(
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
                child: isMobile
                    ? Column(
                        children: [
                          PhotoSection(isMobile: isMobile),
                          HeroSection(isMobile: isMobile, isTablet: isTablet),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
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
      },
    );
  }
}
